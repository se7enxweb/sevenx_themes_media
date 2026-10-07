/*
 * The cookie banner (media design): pagelayout/cookie_control.tpl draws it,
 * this script runs it.
 *
 * What it records: one first-party cookie, ng-cc-consent, holding the
 * visitor's actual choice and the version of the cookie policy it was made
 * under:
 *
 *   v<version>.rejected          only what the site needs ("Reject all", or
 *                                saved with every optional category off)
 *   v<version>.<name>[+<name>]   the optional categories accepted, by name
 *                                ("Accept all" accepts every one offered)
 *
 * e.g. "v1.rejected" or "v1.youtube". It lives for six months (Max-Age),
 * on Path=/ with SameSite=Lax, and Secure whenever the page is on https. A
 * script reads it, so it cannot be HttpOnly. Nothing is stored before the
 * visitor chooses. When the version in the cookie differs from the page's
 * (menu.ini [SiteInfo] CookieConsentVersion), the banner asks again.
 *
 * Optional categories: a category is shown only when a handler for it is
 * registered, so the banner never offers a choice that does nothing. A
 * handler is { isGranted(): boolean, apply(granted: boolean) }, registered
 * either before this script runs:
 *
 *   window.expCookieConsentHandlers = window.expCookieConsentHandlers || {};
 *   window.expCookieConsentHandlers.<name> = { isGranted: ..., apply: ... };
 *
 * or later with ExpCookieConsent.register(name, handler). The category also
 * needs its row in cookie_control.tpl (data-exp-cc-category="<name>"), which
 * carries the translated label and description. Today the only one is
 * "youtube" (exp-youtube-consent.js), which is the localStorage key
 * exp-youtube-always: the same switch as "Always allow YouTube videos on this
 * site" under each video.
 *
 * Every saved choice also fires a "exp:cookie-consent" event on document,
 * detail { version, categories: [...], rejected: boolean }, for anything that
 * has to react (parts/google_tag_manager_code_script.tpl listens for it).
 *
 * The banner of the earlier library wrote ng-cc-accepted ("accepted" even on
 * refusal), ng-cc-analytics and ng-cc-marketing for two categories that never
 * existed. Those are deleted on sight. The questions changed, so a visitor who
 * had answered the old banner is asked again; their YouTube choice, which
 * was given at a video and lives in localStorage, is kept and shown preset.
 *
 * Reopening: any element with class js-open-ng-cc or js-exp-cc-open, any link
 * to "#cookie-settings" (on this page or another one), and a page opened with
 * that hash. Without JavaScript the banner stays hidden and nothing is stored.
 */
(function () {
    'use strict';

    var COOKIE = 'ng-cc-consent';
    var OLD_COOKIES = ['ng-cc-accepted', 'ng-cc-analytics', 'ng-cc-marketing'];
    var MAX_AGE = 180 * 24 * 60 * 60;
    var NAME_PATTERN = /^[a-z][a-z0-9_-]{0,31}$/;
    var OPEN_HASH = '#cookie-settings';

    var banner = null;
    var panel = null;
    var settingsButton = null;
    var config = { version: '1' };
    var handlers = {};
    var returnFocus = null;

    /* --- the cookie ------------------------------------------------------ */

    function readCookie(name) {
        var parts = (document.cookie || '').split(';');
        for (var i = 0; i < parts.length; i++) {
            var part = parts[i].replace(/^\s+/, '');
            if (part.indexOf(name + '=') === 0) {
                return part.substring(name.length + 1);
            }
        }
        return null;
    }

    function attributes(maxAge) {
        var value = '; Path=/; SameSite=Lax; Max-Age=' + maxAge;
        if (maxAge > 0) {
            value += '; Expires=' + new Date(Date.now() + maxAge * 1000).toUTCString();
        } else {
            value += '; Expires=Thu, 01 Jan 1970 00:00:00 GMT';
        }
        if (window.location.protocol === 'https:') {
            value += '; Secure';
        }
        return value;
    }

    function dropOldCookies() {
        OLD_COOKIES.forEach(function (name) {
            if (readCookie(name) !== null) {
                document.cookie = name + '=' + attributes(0);
            }
        });
    }

    /* The stored choice, or null when there is none for this version. */
    function stored() {
        var raw = readCookie(COOKIE);
        if (!raw) {
            return null;
        }
        var match = /^v([0-9A-Za-z_-]+)\.([a-z0-9_+-]+)$/.exec(raw);
        if (!match || match[1] !== String(config.version)) {
            return null;
        }
        var categories = match[2] === 'rejected' ? [] : match[2].split('+').filter(function (name) {
            return NAME_PATTERN.test(name) && name !== 'rejected';
        });
        return { version: match[1], categories: categories, rejected: categories.length === 0 };
    }

    function write(categories) {
        var list = categories.filter(function (name, index) {
            return NAME_PATTERN.test(name) && categories.indexOf(name) === index;
        }).sort();
        var value = 'v' + config.version + '.' + (list.length ? list.join('+') : 'rejected');
        document.cookie = COOKIE + '=' + value + attributes(MAX_AGE);
        var detail = { version: String(config.version), categories: list, rejected: list.length === 0 };
        var event;
        try {
            event = new CustomEvent('exp:cookie-consent', { detail: detail });
        } catch (e) {
            event = document.createEvent('CustomEvent');
            event.initCustomEvent('exp:cookie-consent', false, false, detail);
        }
        document.dispatchEvent(event);
        return detail;
    }

    /* --- categories ------------------------------------------------------ */

    function collectHandlers() {
        var queued = window.expCookieConsentHandlers || {};
        Object.keys(queued).forEach(function (name) {
            register(name, queued[name], true);
        });
    }

    function register(name, handler, quiet) {
        if (!NAME_PATTERN.test(name) || !handler || typeof handler.apply !== 'function' || typeof handler.isGranted !== 'function') {
            return false;
        }
        handlers[name] = handler;
        if (!quiet) {
            showCategories();
        }
        return true;
    }

    /* The rows of the settings layer that have a handler; the others stay
       hidden, because choosing them would change nothing. */
    function categoryRows() {
        return banner ? Array.prototype.slice.call(banner.querySelectorAll('[data-exp-cc-category]')) : [];
    }

    function available() {
        return categoryRows().map(function (row) {
            return row.getAttribute('data-exp-cc-category');
        }).filter(function (name) {
            return Object.prototype.hasOwnProperty.call(handlers, name);
        });
    }

    function showCategories() {
        categoryRows().forEach(function (row) {
            row.hidden = !Object.prototype.hasOwnProperty.call(handlers, row.getAttribute('data-exp-cc-category'));
        });
    }

    function box(name) {
        return banner ? banner.querySelector('[data-exp-cc-category="' + name + '"] input[type="checkbox"]') : null;
    }

    /* The switches show what is in force: the stored choice when there is
       one, otherwise what the category itself says (YouTube allowed at a
       video before the banner was answered). */
    function fillBoxes() {
        var choice = stored();
        available().forEach(function (name) {
            var input = box(name);
            if (input) {
                input.checked = choice ? choice.categories.indexOf(name) !== -1 : !!handlers[name].isGranted();
            }
        });
    }

    function save(accepted) {
        var names = available();
        names.forEach(function (name) {
            var on = accepted.indexOf(name) !== -1;
            if (!!handlers[name].isGranted() !== on) {
                handlers[name].apply(on);
            }
        });
        write(accepted.filter(function (name) {
            return names.indexOf(name) !== -1;
        }));
    }

    /* A category changed outside the banner (the box under a video). Only an
       existing record follows it: the banner is not answered by that. */
    function setCategory(name, on) {
        var choice = stored();
        if (!choice) {
            return;
        }
        var list = choice.categories.filter(function (item) {
            return item !== name;
        });
        if (on) {
            list.push(name);
        }
        write(list);
        var input = box(name);
        if (input) {
            input.checked = !!on;
        }
    }

    /* With a stored choice, the record and the category agree; where they do
       not (site data partly cleared), the refusal wins on both sides. */
    function reconcile(choice) {
        var drift = false;
        available().forEach(function (name) {
            var recorded = choice.categories.indexOf(name) !== -1;
            var actual = !!handlers[name].isGranted();
            if (actual && !recorded) {
                handlers[name].apply(false);
            } else if (recorded && !actual) {
                drift = true;
            }
        });
        if (drift) {
            write(choice.categories.filter(function (name) {
                return !Object.prototype.hasOwnProperty.call(handlers, name) || handlers[name].isGranted();
            }));
        }
    }

    /* --- the banner ------------------------------------------------------ */

    function setPanel(open) {
        if (!panel || !settingsButton) {
            return;
        }
        panel.hidden = !open;
        settingsButton.setAttribute('aria-expanded', open ? 'true' : 'false');
        banner.classList.toggle('is-expanded', open);
        var saveButton = banner.querySelector('[data-exp-cc-action="save"]');
        if (saveButton) {
            saveButton.hidden = !open;
        }
    }

    function open(withSettings, trigger) {
        if (!banner) {
            return;
        }
        returnFocus = trigger || (document.activeElement !== document.body ? document.activeElement : null);
        fillBoxes();
        setPanel(!!withSettings);
        banner.classList.toggle('has-choice', stored() !== null);
        banner.hidden = false;
        document.documentElement.classList.add('exp-cc-open');
        window.requestAnimationFrame(function () {
            banner.classList.add('is-open');
        });
        try {
            banner.focus({ preventScroll: true });
        } catch (e) {
            banner.focus();
        }
    }

    function close() {
        if (!banner || banner.hidden) {
            return;
        }
        banner.classList.remove('is-open');
        banner.hidden = true;
        document.documentElement.classList.remove('exp-cc-open');
        var target = returnFocus;
        returnFocus = null;
        if (target && document.contains(target) && typeof target.focus === 'function') {
            target.focus();
        } else if (banner.contains(document.activeElement)) {
            document.activeElement.blur();
        }
        if (window.location.hash === OPEN_HASH && window.history && window.history.replaceState) {
            window.history.replaceState(null, '', window.location.pathname + window.location.search);
        }
    }

    function onAction(action) {
        if (action === 'accept') {
            save(available());
            close();
        } else if (action === 'reject') {
            save([]);
            close();
        } else if (action === 'save') {
            save(available().filter(function (name) {
                var input = box(name);
                return input && input.checked;
            }));
            close();
        } else if (action === 'settings') {
            var opening = panel.hidden;
            setPanel(opening);
            if (opening) {
                var first = panel.querySelector('[data-exp-cc-category]:not([hidden]) input:not([disabled])');
                if (first) {
                    first.focus();
                }
            }
        } else if (action === 'close') {
            close();
        }
    }

    function isOpener(element) {
        if (!element || !element.closest) {
            return null;
        }
        var opener = element.closest('.js-open-ng-cc, .js-exp-cc-open');
        if (opener) {
            return opener;
        }
        var link = element.closest('a[href]');
        if (link && link.hash === OPEN_HASH && link.pathname === window.location.pathname) {
            return link;
        }
        return null;
    }

    function bind() {
        banner.addEventListener('click', function (event) {
            var button = event.target.closest ? event.target.closest('[data-exp-cc-action]') : null;
            if (button && banner.contains(button)) {
                event.preventDefault();
                onAction(button.getAttribute('data-exp-cc-action'));
            }
        });

        /* Escape never traps: it folds the settings back first, and closes
           the banner when there is a choice in force to fall back on. Before
           the first choice there is none, so the banner stays; Tab still
           leaves it freely. */
        banner.addEventListener('keydown', function (event) {
            if (event.key !== 'Escape' && event.key !== 'Esc') {
                return;
            }
            if (panel && !panel.hidden && stored() === null) {
                setPanel(false);
                settingsButton.focus();
                event.preventDefault();
            } else if (stored() !== null) {
                close();
                event.preventDefault();
            }
        });

        document.addEventListener('click', function (event) {
            var opener = isOpener(event.target);
            if (opener) {
                event.preventDefault();
                open(true, opener);
            }
        });

        window.addEventListener('hashchange', function () {
            if (window.location.hash === OPEN_HASH) {
                open(true, null);
            }
        });

        /* The links are drawn for readers without JavaScript (they lead to
           the cookie policy); with it they open the banner, and say so. */
        Array.prototype.slice.call(document.querySelectorAll('.js-open-ng-cc, .js-exp-cc-open')).forEach(function (link) {
            link.setAttribute('aria-haspopup', 'dialog');
            link.setAttribute('aria-controls', banner.id);
        });
    }

    function readConfig() {
        var node = document.getElementById('exp-cc-config');
        if (node) {
            try {
                var parsed = JSON.parse(node.textContent) || {};
                if (parsed.version !== undefined && /^[0-9A-Za-z_-]{1,16}$/.test(String(parsed.version))) {
                    config.version = String(parsed.version);
                }
            } catch (e) {
                /* keep the default version */
            }
        }
    }

    function init() {
        banner = document.getElementById('exp-cc');
        dropOldCookies();
        readConfig();
        collectHandlers();
        if (!banner) {
            return;
        }
        panel = document.getElementById('exp-cc-panel');
        settingsButton = banner.querySelector('[data-exp-cc-action="settings"]');
        showCategories();
        bind();

        var choice = stored();
        if (choice) {
            reconcile(choice);
        }
        if (!choice) {
            open(false, null);
        } else if (window.location.hash === OPEN_HASH) {
            open(true, null);
        }
    }

    window.ExpCookieConsent = {
        open: function () { open(true, null); },
        close: close,
        get: stored,
        has: function (name) {
            var choice = stored();
            return !!choice && choice.categories.indexOf(name) !== -1;
        },
        register: register,
        setCategory: setCategory
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
}());
