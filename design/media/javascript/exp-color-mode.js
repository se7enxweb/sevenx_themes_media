/* The media design's color mode: light, dark, darker, or the system's (prefers-color-scheme), the way the
   administration's admin4 design does it (its a4_head.js).

   Loaded in <head>, before the stylesheets, as a file of its own rather than an inline script, so it runs under a
   Content Security Policy without 'unsafe-inline'. It is the one part of the look that cannot wait: a page drawn
   light and then switched would flash.

   html[data-exp-theme]        light|dark|darker  what the stylesheets read (exp-color-mode.css)
   html[data-exp-theme-choice] light|dark|darker|system  what the switch shows

   The choice is kept in this browser: localStorage "exp-media-theme", and a cookie of the same name (a year, the
   whole site), which is read when the storage is blocked or empty. The server does not read the cookie: the header
   is part of the cached layout and pages may come from a full-page cache, so a page rendered for one visitor's mode
   would be served to the next; this script sets the mode before the body is parsed instead, which is as early as a
   server-rendered attribute would be. Without a choice the system's mode is followed (dark for a dark system),
   also when the system changes while the page is open.

   The header's #exp-theme-toggle (pagelayout/header/color_mode.tpl) steps light -> dark -> darker -> system ->
   light and stores the step; its name says the mode in use (data-label-*), and #exp-theme-status announces a press,
   politely. Other open tabs follow through the storage event. Printing uses the light mode. */
(function () {
    var KEY = 'exp-media-theme', COOKIE = 'exp_media_theme', CHOICES = ['light', 'dark', 'darker', 'system'];
    var root = document.documentElement;
    var mq = window.matchMedia ? window.matchMedia('(prefers-color-scheme: dark)') : null;

    function valid(value) { return CHOICES.indexOf(value) >= 0 ? value : ''; }
    function readCookie() {
        var m = document.cookie.match(new RegExp('(?:^|;\\s*)' + COOKIE + '=([a-z]+)'));
        return m ? valid(m[1]) : '';
    }
    function stored() {
        var value = '';
        try { value = valid(window.localStorage.getItem(KEY) || ''); } catch (e) { /* blocked storage */ }
        return value || readCookie() || 'system';
    }
    function save(choice) {
        try { window.localStorage.setItem(KEY, choice); } catch (e) { /* blocked storage: the cookie keeps it */ }
        var secure = window.location.protocol === 'https:' ? '; Secure' : '';
        document.cookie = COOKIE + '=' + choice + '; Max-Age=31536000; Path=/; SameSite=Lax' + secure;
    }
    function apply(value) {
        var choice = valid(value) || 'system';
        var mode = choice === 'system' ? (mq && mq.matches ? 'dark' : 'light') : choice;
        root.setAttribute('data-exp-theme', mode);
        root.setAttribute('data-exp-theme-choice', choice);
        var b = document.getElementById('exp-theme-toggle');
        if (!b) return;
        var text = b.getAttribute('data-label-' + choice) || '';
        var label = b.querySelector('.header-theme-label');
        if (label) label.textContent = text;
        if (text) b.setAttribute('title', text);
        b.setAttribute('data-choice', choice);
    }
    apply(stored());

    if (mq) {
        var follow = function () { if (root.getAttribute('data-exp-theme-choice') === 'system') apply('system'); };
        if (mq.addEventListener) mq.addEventListener('change', follow); else if (mq.addListener) mq.addListener(follow);
    }
    function wire() {
        apply(root.getAttribute('data-exp-theme-choice'));
        var b = document.getElementById('exp-theme-toggle');
        if (!b || b.getAttribute('data-wired')) return;
        b.setAttribute('data-wired', '1');
        b.addEventListener('click', function () {
            var i = CHOICES.indexOf(root.getAttribute('data-exp-theme-choice'));
            var next = CHOICES[(i + 1) % CHOICES.length];
            save(next);
            apply(next);
            var status = document.getElementById('exp-theme-status');
            if (status) status.textContent = b.getAttribute('data-label-' + next) || '';
        });
    }
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', wire); else wire();

    window.addEventListener('storage', function (e) { if (e.key === KEY) apply(e.newValue); });
    // the page restored from the back/forward cache: the choice may have changed in another page meanwhile
    window.addEventListener('pageshow', function (e) { if (e.persisted) apply(stored()); });
    window.addEventListener('beforeprint', function () { root.setAttribute('data-exp-theme', 'light'); });
    window.addEventListener('afterprint', function () { apply(root.getAttribute('data-exp-theme-choice')); });
})();
