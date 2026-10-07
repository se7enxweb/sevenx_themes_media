/*
 * Click to load for YouTube videos (media design).
 *
 * The page carries a placeholder for each video (content/parts/youtube_player.tpl):
 * a local copy of its image, a play button and a line saying the video comes
 * from YouTube. Nothing is requested from Google until the visitor plays it;
 * the player then comes from www.youtube-nocookie.com.
 *
 * "Always allow YouTube videos on this site" is remembered in localStorage
 * (first party, no cookie). While it is set, players load as the page opens,
 * still from youtube-nocookie.com, and "Stop loading YouTube automatically"
 * takes it back and returns those players to their placeholders.
 *
 * The cookie banner (exp-cookie-consent.js) offers the same choice as
 * "Embedded videos (YouTube)" and drives this same key, through the handler
 * registered below; a change made under a video is recorded in the banner's
 * consent cookie in turn. One consent, two places to give or take it back.
 *
 * Without JavaScript the placeholder is a plain link to the video on YouTube.
 *
 * The video modal (index-noncritical.js) asks window.ExpYouTubeConsent for
 * its markup, so a video opened from a link behaves the same way.
 */
(function () {
    'use strict';

    var STORAGE_KEY = 'exp-youtube-always';
    var ID_PATTERN = /^[A-Za-z0-9_-]{11}$/;
    var ALLOW = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';
    var config = null;

    function getConfig() {
        if (config === null) {
            config = {};
            var node = document.getElementById('exp-yt-config');
            if (node) {
                try {
                    config = JSON.parse(node.textContent) || {};
                } catch (e) {
                    config = {};
                }
            }
        }
        return config;
    }

    function text(key, fallback) {
        var value = getConfig()[key];
        return typeof value === 'string' && value !== '' ? value : fallback;
    }

    function isAllowed() {
        try {
            return window.localStorage.getItem(STORAGE_KEY) === '1';
        } catch (e) {
            return false;
        }
    }

    function setAllowed(on) {
        try {
            if (on) {
                window.localStorage.setItem(STORAGE_KEY, '1');
            } else {
                window.localStorage.removeItem(STORAGE_KEY);
            }
        } catch (e) {
            /* storage blocked: the choice lasts for this page only */
        }
    }

    function players(root) {
        return Array.prototype.slice.call((root || document).querySelectorAll('.js-exp-yt'));
    }

    function createFrame(id, title, autoplay) {
        var frame = document.createElement('iframe');
        frame.src = 'https://www.youtube-nocookie.com/embed/' + id + (autoplay ? '?autoplay=1' : '');
        frame.title = title || text('frameTitle', 'YouTube video');
        frame.width = '770';
        frame.height = '433';
        frame.setAttribute('frameborder', '0');
        frame.setAttribute('allow', ALLOW);
        frame.setAttribute('referrerpolicy', 'strict-origin-when-cross-origin');
        frame.setAttribute('allowfullscreen', '');
        if (!autoplay) {
            frame.setAttribute('loading', 'lazy');
        }
        return frame;
    }

    /* The link the server drew becomes a button: it plays here rather than
       leaving for YouTube. */
    function enhance(player) {
        if (player.getAttribute('data-exp-yt-ready') === '1') {
            return;
        }
        var id = player.getAttribute('data-exp-yt-id') || '';
        if (!ID_PATTERN.test(id)) {
            return;
        }
        player.setAttribute('data-exp-yt-ready', '1');

        var link = player.querySelector('a.js-exp-yt-play');
        if (link) {
            var button = document.createElement('button');
            button.type = 'button';
            button.className = link.className;
            button.setAttribute('aria-label', link.getAttribute('data-exp-yt-label') || link.getAttribute('aria-label') || text('play', 'Play video'));
            while (link.firstChild) {
                button.appendChild(link.firstChild);
            }
            link.parentNode.replaceChild(button, link);
        }
        var always = player.querySelector('.exp-yt-always');
        if (always) {
            always.hidden = false;
        }
    }

    function load(player, autoplay, automatic) {
        if (player.classList.contains('is-loaded')) {
            return;
        }
        var id = player.getAttribute('data-exp-yt-id') || '';
        var poster = player.querySelector('.js-exp-yt-play');
        if (!ID_PATTERN.test(id) || !poster) {
            return;
        }
        var frame = createFrame(id, player.getAttribute('data-exp-yt-title'), autoplay);
        player.expYtPoster = poster;
        poster.parentNode.replaceChild(frame, poster);
        player.classList.add('is-loaded');
        player.classList.toggle('is-automatic', !!automatic);
        if (autoplay) {
            frame.focus();
        }
    }

    function unload(player) {
        var frame = player.querySelector('.exp-yt-frame iframe');
        if (!frame || !player.expYtPoster) {
            return;
        }
        frame.parentNode.replaceChild(player.expYtPoster, frame);
        player.classList.remove('is-loaded', 'is-automatic');
    }

    function sync() {
        var allowed = isAllowed();
        players().forEach(function (player) {
            var box = player.querySelector('.js-exp-yt-always');
            var label = player.querySelector('.exp-yt-always');
            var stop = player.querySelector('.js-exp-yt-stop');
            if (box) {
                box.checked = allowed;
            }
            if (label) {
                label.hidden = allowed;
            }
            if (stop) {
                stop.hidden = !allowed;
            }
        });
    }

    function init(root) {
        var allowed = isAllowed();
        players(root).forEach(function (player) {
            enhance(player);
            if (allowed) {
                load(player, false, true);
            }
        });
        sync();
    }

    /* The one switch behind every way of giving or taking back "always
       allow": the box under a video, "Stop loading YouTube automatically",
       and the "Embedded videos (YouTube)" choice in the cookie banner. On, it
       loads every player on the page; off, it returns the players that loaded
       by themselves to their placeholders. A video the visitor started with
       its own play button keeps playing: that was a choice for that video. */
    function applyAllowed(on) {
        setAllowed(on);
        players().forEach(function (player) {
            if (on) {
                enhance(player);
                load(player, false, true);
            } else if (player.classList.contains('is-automatic')) {
                unload(player);
            }
        });
        sync();
    }

    /* A change made under a video is a change of the same consent the cookie
       banner records, so the banner's record follows it. */
    function tellBanner(on) {
        if (window.ExpCookieConsent && typeof window.ExpCookieConsent.setCategory === 'function') {
            window.ExpCookieConsent.setCategory('youtube', on);
        }
    }

    /* The cookie banner's "Embedded videos (YouTube)" category. The banner
       shows a category only when a handler for it is registered, so the
       choice is offered exactly where this script runs. */
    window.expCookieConsentHandlers = window.expCookieConsentHandlers || {};
    window.expCookieConsentHandlers.youtube = {
        isGranted: isAllowed,
        apply: applyAllowed
    };

    document.addEventListener('click', function (event) {
        var play = event.target.closest ? event.target.closest('button.js-exp-yt-play') : null;
        if (play) {
            var player = play.closest('.js-exp-yt');
            if (player) {
                event.preventDefault();
                load(player, true, false);
            }
            return;
        }
        var stop = event.target.closest ? event.target.closest('.js-exp-yt-stop') : null;
        if (stop) {
            event.preventDefault();
            var own = stop.closest('.js-exp-yt');
            applyAllowed(false);
            tellBanner(false);
            var box = own ? own.querySelector('.js-exp-yt-always') : null;
            if (box) {
                box.focus();
            }
        }
    });

    document.addEventListener('change', function (event) {
        var box = event.target;
        if (!box.classList || !box.classList.contains('js-exp-yt-always')) {
            return;
        }
        applyAllowed(box.checked);
        tellBanner(box.checked);
        if (box.checked) {
            var stop = box.closest('.js-exp-yt') ? box.closest('.js-exp-yt').querySelector('.js-exp-yt-stop') : null;
            if (stop) {
                stop.focus();
            }
        }
    });

    function escapeHtml(value) {
        return String(value).replace(/[&<>"']/g, function (c) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        });
    }

    /* Markup for the video modal: the player straight away when YouTube is
       always allowed (the visitor opened the video), the placeholder otherwise. */
    function modalMarkup(id, title, thumbnail) {
        if (!ID_PATTERN.test(String(id || ''))) {
            return '';
        }
        if (isAllowed()) {
            var wrap = document.createElement('div');
            wrap.className = 'video-youtube iframe-video ratio ratio-16x9';
            wrap.appendChild(createFrame(id, title, true));
            return wrap.outerHTML;
        }
        var label = title ? text('playTitle', 'Play video: %title').replace('%title', title) : text('play', 'Play video');
        var privacy = getConfig().privacyUrl
            ? '<a href="' + escapeHtml(getConfig().privacyUrl) + '">' + escapeHtml(text('privacyLabel', 'Privacy policy')) + '</a>'
            : escapeHtml(text('privacyLabel', 'Privacy policy'));
        var notice = escapeHtml(text('notice', 'Playing this video loads it from YouTube (Google). See our %privacy_link.'))
            .replace('%privacy_link', privacy);
        var thumb = thumbnail || getConfig().placeholder || '';
        return '<div class="exp-yt js-exp-yt exp-yt-modal" data-exp-yt-id="' + escapeHtml(id) + '" data-exp-yt-title="' + escapeHtml(title || '') + '" data-exp-yt-ready="1">' +
            '<div class="exp-yt-frame video-youtube ratio ratio-16x9">' +
            '<button type="button" class="exp-yt-poster js-exp-yt-play" aria-label="' + escapeHtml(label) + '">' +
            (thumb ? '<img src="' + escapeHtml(thumb) + '" alt="" width="480" height="360">' : '') +
            '<span class="exp-yt-play" aria-hidden="true"></span>' +
            (title ? '<span class="exp-yt-title" aria-hidden="true">' + escapeHtml(title) + '</span>' : '') +
            '</button></div>' +
            '<div class="exp-yt-consent"><p class="exp-yt-notice">' + notice + '</p>' +
            '<label class="exp-yt-always"><input type="checkbox" class="js-exp-yt-always"> ' + escapeHtml(text('always', 'Always allow YouTube videos on this site')) + '</label>' +
            '<button type="button" class="exp-yt-stop js-exp-yt-stop" hidden>' + escapeHtml(text('stop', 'Stop loading YouTube automatically')) + '</button>' +
            '</div></div>';
    }

    window.ExpYouTubeConsent = {
        init: init,
        isAllowed: isAllowed,
        setAllowed: applyAllowed,
        modalMarkup: modalMarkup
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function () { init(document); });
    } else {
        init(document);
    }
}());
