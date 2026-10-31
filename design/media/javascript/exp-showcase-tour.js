/*
 * The tour of the demo content (node/view/full/showcase_s1_tour.tpl, media design).
 *
 *   - "Open the admin in dark/light mode": a link to /admin/...#dark or #light
 *     stores that mode where the admin keeps it in this browser (localStorage
 *     exp-admin4-theme);
 *   - the speed card (.exp-tour-speed-out, data-exp-speed-url = showcase/speed)
 *     is filled with the last measurement.
 *
 * Printed by the template after the tour (no inline script, so the page runs
 * under a script-src 'self' policy); it sets itself up once.
 */
(function () {
    'use strict';
    if (window.expShowcaseTourSetUp) return;
    window.expShowcaseTourSetUp = true;
    // "Open the admin in dark/light mode": the admin keeps its mode in this browser (localStorage exp-admin4-theme)
    document.querySelectorAll('.exp-tour a[href*="/admin/"]').forEach(function (a) {
        var m = a.getAttribute('href').match(/#(dark|light)$/);
        if (!m) return;
        a.addEventListener('click', function () {
            try { localStorage.setItem('exp-admin4-theme', m[1]); } catch (e) {}
        });
    });
    var out = document.querySelector('.exp-tour-speed-out');
    if (!out || !window.fetch) return;
    function esc(s) { return String(s).replace(/[&<>"]/g, function (c) { return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]; }); }
    function ago(t) {
        var s = Math.max(0, Math.round(Date.now() / 1000 - t));
        if (s < 90) return s + ' seconds ago';
        if (s < 5400) return Math.round(s / 60) + ' minutes ago';
        if (s < 129600) return Math.round(s / 3600) + ' hours ago';
        return Math.round(s / 86400) + ' days ago';
    }
    function ms(v) { return v === null || v === undefined ? '-' : (v < 10 ? v.toFixed(1) : Math.round(v)) + ' ms'; }
    fetch(out.getAttribute('data-exp-speed-url') || '/showcase/speed', { credentials: 'same-origin', cache: 'no-store' })
        .then(function (r) { return r.json(); })
        .then(function (d) {
            if (!d.ok || !d.result) { out.innerHTML = '<p>No measurement yet. An administrator starts one from the admin dashboard.</p>'; return; }
            var r = d.result, html = '';
            function table(rows, title, note) {
                var max = 1, h = '';
                rows = rows.filter(function (p) { return p.apache.server_ms !== null && p.velocity.server_ms !== null; });
                if (!rows.length) return '';
                rows.forEach(function (p) { [p.apache.server_ms, p.velocity.server_ms].forEach(function (v) { if (v > max) max = v; }); });
                h += '<h3 class="exp-tour-speed-sub">' + esc(title) + '</h3><p class="exp-tour-speed-note">' + esc(note) + '</p>';
                h += '<table><thead><tr><th>Page</th><th class="num">Apache</th><th class="num">Velocity</th><th class="bar">Median time to answer</th><th class="num">Faster</th></tr></thead><tbody>';
                rows.forEach(function (p) {
                    var a = p.apache.server_ms, v = p.velocity.server_ms, f = a / v, win = '';
                    if (f >= 1.1) win = '<span class="exp-tour-factor"><span class="w">Velocity </span>' + f.toFixed(1) + 'x</span>';
                    else if (f <= 0.91) win = '<span class="exp-tour-factor is-a"><span class="w">Apache </span>' + (1 / f).toFixed(1) + 'x</span>';
                    else win = 'even';
                    h += '<tr><td><a data-path="' + esc(p.path) + '">' + esc(p.label) + '</a></td>'
                       + '<td class="num">' + ms(a) + '</td><td class="num">' + ms(v) + '</td>'
                       + '<td class="bar"><span class="exp-tour-bar" data-w="' + Math.max(1, 100 * a / max) + '"></span>'
                       + '<span class="exp-tour-bar is-v" data-w="' + Math.max(1, 100 * v / max) + '"></span></td>'
                       + '<td class="num">' + win + '</td></tr>';
                });
                return h + '</tbody></table>';
            }
            html += table(r.pages, 'Returning visitors: pages from the cache', 'What most requests are. Velocity answers from its in-memory response cache; Apache from the view cache on disk.');
            if (r.cold && r.cold.length)
                html += table(r.cold, 'Rendered for the request: past every cache', 'A query string no cache has seen, so both servers run Exponential for each request: honest numbers, not a benchmark trick.');
            html += '<small>Measured ' + esc(ago(r.measured)) + ' (' + esc(new Date(r.measured * 1000).toLocaleString()) + ') with ' + esc(r.method === 'curl' ? 'curl' : './console exp:benchmark')
                 + ', ' + esc(r.rounds) + ' requests per page and server' + (r.cold && r.cold.length ? ' (' + esc(r.cold_rounds) + ' rendered)' : '') + (r.runs > 1 ? ', the median of ' + esc(r.runs) + ' runs' : '') + ', two at a time, PHP ' + esc(r.php) + '. Grey: Apache with PHP-FPM; yellow: Velocity.</small>';
            out.innerHTML = html;
            // the page links get their address here, not in the HTML text above: a crawler reading the script
            // as HTML would take the concatenation for an address
            out.querySelectorAll('a[data-path]').forEach(function (a) { a.setAttribute('href', a.getAttribute('data-path')); });
            // each bar's length is its measurement (exp-page-parts.css has the rest of the bar)
            out.querySelectorAll('.exp-tour-bar[data-w]').forEach(function (b) { b.style.width = b.getAttribute('data-w') + '%'; });
        })
        .catch(function () { out.innerHTML = '<p>The measurement could not be loaded right now.</p>'; });
})();
