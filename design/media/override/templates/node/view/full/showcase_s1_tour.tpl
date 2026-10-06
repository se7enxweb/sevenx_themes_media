{* The tour of the demo content (/exponential-live): the page whose object has the remote id showcase-s1-tour. Its
   children (ng_shortcut) are the stops, in priority order: title = headline, teaser_title = where it is,
   teaser_intro = why it matters (first paragraph) and the "try it" links (second paragraph), image = screenshot.
   The speed card after the Velocity stop reads showcase/speed (the last measurement, made by an administrator); it
   is shown only where that module exists, which a default installation does not have. *}
{def $stops = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                              'class_filter_type', 'include', 'class_filter_array', array( 'ng_shortcut' ),
                                              'sort_by', array( 'priority', true() ) ) )
     $speed = ezmodule( 'showcase/speed' )
     $stop_map = false()
     $img = false()
     $no = 0}
<div class="view-type view-type-full exp-tour">
<style>
.exp-tour{ldelim}--t-ink:#111;--t-text:#212529;--t-muted:#5c5c5c;--t-yellow:#FED82F;--t-yellow-soft:#fff7d1;--t-card:#F8F9FC;--t-line:#dee2e6;--t-radius:1rem;--t-ok:#146c43;color:var(--t-text){rdelim}
.exp-tour *{ldelim}box-sizing:border-box{rdelim}
.exp-tour-hero{ldelim}padding:3.5rem 0 2.5rem;background:linear-gradient(180deg,var(--t-yellow-soft),#fff){rdelim}
.exp-tour-eyebrow{ldelim}display:inline-block;font-size:.8rem;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--t-ink);background:var(--t-yellow);border-radius:999px;padding:.3rem .8rem;margin:0 0 1rem{rdelim}
.exp-tour-hero h1{ldelim}font-size:clamp(2rem,4.6vw,3.4rem);line-height:1.08;font-weight:800;color:var(--t-ink);margin:0 0 1rem;max-width:18ch{rdelim}
.exp-tour-lead{ldelim}font-size:1.2rem;line-height:1.55;max-width:46rem;margin:0 0 1.5rem{rdelim}
.exp-tour-facts{ldelim}display:flex;flex-wrap:wrap;gap:.6rem;list-style:none;padding:0;margin:0 0 1.75rem{rdelim}
.exp-tour-facts li{ldelim}background:#fff;border:1px solid var(--t-line);border-radius:999px;padding:.35rem .9rem;font-size:.92rem{rdelim}
.exp-tour-facts strong{ldelim}color:var(--t-ink){rdelim}
.exp-tour-actions{ldelim}display:flex;flex-wrap:wrap;gap:.75rem{rdelim}
.exp-tour-btn,.exp-tour-text p+p a{ldelim}display:inline-flex;align-items:center;min-height:44px;padding:.55rem 1.1rem;border-radius:999px;border:2px solid var(--t-ink);color:var(--t-ink);background:#fff;font-weight:600;text-decoration:none;line-height:1.2;transition:background .15s{rdelim}
.exp-tour-btn:hover,.exp-tour-text p+p a:hover{ldelim}background:var(--t-ink);color:#fff;text-decoration:none{rdelim}
.exp-tour-btn.is-primary,.exp-tour-text p+p a:first-child{ldelim}background:var(--t-yellow);border-color:var(--t-yellow){rdelim}
.exp-tour-btn.is-primary:hover,.exp-tour-text p+p a:first-child:hover{ldelim}background:var(--t-ink);border-color:var(--t-ink);color:#fff{rdelim}
.exp-tour-index{ldelim}border-top:1px solid var(--t-line);border-bottom:1px solid var(--t-line);background:#fff;padding:1rem 0{rdelim}
.exp-tour-index ol{ldelim}display:grid;grid-template-columns:repeat(auto-fill,minmax(15rem,1fr));gap:.35rem 1.5rem;list-style:none;margin:0;padding:0;counter-reset:t{rdelim}
.exp-tour-index li{ldelim}counter-increment:t{rdelim}
.exp-tour-index a{ldelim}display:flex;gap:.6rem;align-items:baseline;padding:.3rem 0;color:var(--t-text);text-decoration:none;font-size:.95rem{rdelim}
.exp-tour-index a::before{ldelim}content:counter(t,decimal-leading-zero);font-weight:700;font-variant-numeric:tabular-nums;color:var(--t-muted);min-width:1.6rem{rdelim}
.exp-tour-index a:hover{ldelim}text-decoration:underline{rdelim}
.exp-tour-stops{ldelim}padding-top:1rem;padding-bottom:2rem{rdelim}
.exp-tour-stop{ldelim}display:grid;grid-template-columns:minmax(0,7fr) minmax(0,5fr);gap:2.5rem;align-items:center;padding:3rem 0;border-bottom:1px solid var(--t-line);scroll-margin-top:6rem{rdelim}
.exp-tour-stop:nth-child(even) .exp-tour-shot{ldelim}order:2{rdelim}
.exp-tour-shot{ldelim}margin:0{rdelim}
.exp-tour-shot a{ldelim}display:block;border-radius:var(--t-radius);overflow:hidden;border:1px solid var(--t-line);box-shadow:0 18px 40px -22px rgba(0,0,0,.45);background:var(--t-card){rdelim}
.exp-tour-shot img{ldelim}display:block;width:100%;height:auto{rdelim}
.exp-tour-shot.is-empty{ldelim}aspect-ratio:16/10;border-radius:var(--t-radius);background:var(--t-card);border:1px dashed var(--t-line){rdelim}
.exp-tour-no{ldelim}display:inline-flex;align-items:center;justify-content:center;width:2.6rem;height:2.6rem;border-radius:50%;background:var(--t-ink);color:#fff;font-weight:800;font-variant-numeric:tabular-nums;margin-right:.6rem{rdelim}
.exp-tour-where{ldelim}display:inline-block;font-size:.8rem;font-weight:700;letter-spacing:.06em;text-transform:uppercase;color:var(--t-muted);vertical-align:middle{rdelim}
.exp-tour-stop h2{ldelim}font-size:clamp(1.5rem,2.6vw,2.1rem);line-height:1.15;font-weight:800;color:var(--t-ink);margin:1rem 0 .75rem{rdelim}
.exp-tour-text p{ldelim}font-size:1.08rem;line-height:1.6;margin:0 0 1.25rem{rdelim}
.exp-tour-text p+p{ldelim}display:flex;flex-wrap:wrap;gap:.6rem;margin:0{rdelim}
.exp-tour-speed{ldelim}margin:0 0 1rem;padding:1.75rem;border-radius:var(--t-radius);background:var(--t-ink);color:#fff{rdelim}
.exp-tour-speed h2{ldelim}color:#fff;font-size:1.5rem;margin:0 0 .35rem{rdelim}
.exp-tour-speed p{ldelim}color:#d7d7d7;margin:0 0 1.25rem;line-height:1.5{rdelim}
.exp-tour-speed table{ldelim}width:100%;border-collapse:collapse;font-variant-numeric:tabular-nums{rdelim}
.exp-tour-speed th,.exp-tour-speed td{ldelim}text-align:left;padding:.65rem .5rem;border-top:1px solid #333;vertical-align:middle{rdelim}
.exp-tour-speed th{ldelim}font-size:.78rem;letter-spacing:.06em;text-transform:uppercase;color:#bdbdbd;font-weight:600;border-top:0{rdelim}
.exp-tour-speed td.num{ldelim}white-space:nowrap;width:1%;text-align:right{rdelim}
.exp-tour-bar{ldelim}display:block;height:.55rem;border-radius:999px;background:#555;margin-top:.3rem;min-width:3px{rdelim}
.exp-tour-bar.is-v{ldelim}background:var(--t-yellow){rdelim}
.exp-tour-factor{ldelim}display:inline-block;background:var(--t-yellow);color:var(--t-ink);border-radius:999px;padding:.1rem .55rem;font-weight:700;font-size:.85rem{rdelim}
.exp-tour-speed-sub{ldelim}color:#fff;font-size:1.05rem;font-weight:700;margin:1.5rem 0 .25rem{rdelim}
.exp-tour-speed p.exp-tour-speed-note{ldelim}font-size:.92rem;margin:0 0 .5rem{rdelim}
.exp-tour-factor.is-a{ldelim}background:#e6e6e6{rdelim}
.exp-tour-speed small{ldelim}display:block;color:#a9a9a9;margin-top:1rem;line-height:1.5{rdelim}
.exp-tour-speed a{ldelim}color:var(--t-yellow){rdelim}.exp-tour-speed-out{ldelim}overflow-x:auto{rdelim}
.exp-tour-end{ldelim}padding:3rem 0 4rem;text-align:center{rdelim}
.exp-tour-end h2{ldelim}font-size:2rem;font-weight:800;color:var(--t-ink);margin:0 0 .75rem{rdelim}
.exp-tour-end p{ldelim}max-width:40rem;margin:0 auto 1.5rem;font-size:1.08rem;line-height:1.6{rdelim}
.exp-tour-end .exp-tour-actions{ldelim}justify-content:center{rdelim}
@media (max-width:991px){ldelim}.exp-tour-stop{ldelim}grid-template-columns:1fr;gap:1.25rem;padding:2.25rem 0{rdelim}.exp-tour-stop:nth-child(even) .exp-tour-shot{ldelim}order:0{rdelim}{rdelim}
@media (max-width:575px){ldelim}.exp-tour-hero{ldelim}padding:2.25rem 0 1.75rem{rdelim}.exp-tour-lead{ldelim}font-size:1.08rem{rdelim}.exp-tour-speed{ldelim}padding:1.25rem 1rem{rdelim}.exp-tour-speed th.bar,.exp-tour-speed td.bar,.exp-tour-factor .w{ldelim}display:none{rdelim}.exp-tour-speed th,.exp-tour-speed td{ldelim}padding:.5rem .3rem;font-size:.92rem{rdelim}.exp-tour-btn,.exp-tour-text p+p a{ldelim}width:100%;justify-content:center{rdelim}{rdelim}
</style>

    <header class="exp-tour-hero">
        <div class="container">
            <p class="exp-tour-eyebrow">Exponential, live</p>
            <h1>See Exponential at its best, live on this server</h1>
            <div class="exp-tour-lead">{if $node.data_map.teaser_intro.has_content}{attribute_view_gui attribute=$node.data_map.teaser_intro}{else}<p>A guided tour of Exponential 6 on this server: twelve stops, ten to fifteen minutes, real features and real speed. Every screenshot below is this installation, and every button opens the real thing.</p>{/if}</div>
            <ul class="exp-tour-facts">
                <li><strong>{$stops|count}</strong> stops</li>
                <li><strong>10 to 15</strong> minutes</li>
                <li>Exponential <strong>{fetch( 'setup', 'version' )|wash}</strong></li>
                <li>PHP <strong>8.0 to 8.5</strong></li>
                <li>No mock-ups</li>
            </ul>
            <div class="exp-tour-actions">
                {if $stops|count}<a class="exp-tour-btn is-primary" href="#stop-1">Start the tour</a>{/if}
                {if $speed}<a class="exp-tour-btn" href="#exp-tour-speed">Compare the speed</a>
                {/if}<a class="exp-tour-btn" href="/admin/content/dashboard">Open the admin</a>
            </div>
        </div>
    </header>

    {if $stops|count}
    <nav class="exp-tour-index" aria-label="Stops of the tour">
        <div class="container">
            <ol>
            {foreach $stops as $stop}
                {set $no = $no|inc}
                <li><a href="#stop-{$no}">{$stop.data_map.title.content|wash}</a></li>
            {/foreach}
            </ol>
        </div>
    </nav>
    {/if}

    <div class="container exp-tour-stops">
    {set $no = 0}
    {foreach $stops as $stop}
        {set $no = $no|inc
             $stop_map = $stop.data_map
             $img = false()}
        <section class="exp-tour-stop" id="stop-{$no}" aria-labelledby="stop-{$no}-title">
            {if $stop_map.image.has_content}
                {set $img = $stop_map.image.content}
                <figure class="exp-tour-shot">
                    <a href={$img.original.url|ezroot} target="_blank" rel="noopener" title="Open the screenshot at full size">
                        <img src={$img.i770.url|ezroot}
                             srcset="{$img.i770.url|ezroot( 'no' )} {$img.i770.width}w, {$img.i1320.url|ezroot( 'no' )} {$img.i1320.width}w, {$img.original.url|ezroot( 'no' )} {$img.original.width}w"
                             sizes="(max-width: 991px) 100vw, 58vw"
                             width="{$img.i770.width}" height="{$img.i770.height}"
                             loading="{if $no|le(2)}eager{else}lazy{/if}" alt="Screenshot: {$stop.data_map.title.content|wash}" />
                    </a>
                </figure>
            {else}
                <div class="exp-tour-shot is-empty" aria-hidden="true"></div>
            {/if}
            <div class="exp-tour-body">
                <span class="exp-tour-no" aria-hidden="true">{$no}</span>
                <span class="exp-tour-where">{$stop_map.teaser_title.content|wash}</span>
                <h2 id="stop-{$no}-title">{$stop.data_map.title.content|wash}</h2>
                <div class="exp-tour-text">{attribute_view_gui attribute=$stop_map.teaser_intro}</div>
            </div>
        </section>
        {if and( $speed, $stop.object.remote_id|eq( 'showcase-s1-stop-04' ) )}
        <section class="exp-tour-speed" id="exp-tour-speed" aria-labelledby="exp-tour-speed-title">
            <h2 id="exp-tour-speed-title">The same pages, Apache and Velocity</h2>
            <p>The same pages of this site, measured on this server through Apache with PHP-FPM and through Exponential Velocity: the median time until the page arrives, once from the cache and once rendered.</p>
            <div class="exp-tour-speed-out" aria-live="polite"><p>Loading the last measurement...</p></div>
            <small>Measured from the server itself on demand of an administrator, never by your visit. Both servers run the same installation, the same database and the same caches.</small>
        </section>
        {/if}
    {/foreach}
    </div>

    <footer class="exp-tour-end">
        <div class="container">
            <h2>That was Exponential 6</h2>
            <p>Everything on this tour is the shipped product on an ordinary server: open source, installed in one command, and documented.</p>
            <div class="exp-tour-actions">
                <a class="exp-tour-btn is-primary" href="https://github.com/se7enxweb/exponential" rel="noopener">Exponential on GitHub</a>
                <a class="exp-tour-btn" href="https://latest.demo.exponential.earth/" rel="noopener">A fresh demo, rebuilt every two hours</a>
                <a class="exp-tour-btn" href="#stop-1">Back to the start</a>
            </div>
        </div>
    </footer>
</div>
<script>
(function () {ldelim}
    // "Open the admin in dark/light mode": the admin keeps its mode in this browser (localStorage exp-admin4-theme)
    document.querySelectorAll('.exp-tour a[href*="/admin/"]').forEach(function (a) {ldelim}
        var m = a.getAttribute('href').match(/#(dark|light)$/);
        if (!m) return;
        a.addEventListener('click', function () {ldelim}
            try {ldelim} localStorage.setItem('exp-admin4-theme', m[1]); {rdelim} catch (e) {ldelim}{rdelim}
        {rdelim});
    {rdelim});
    var out = document.querySelector('.exp-tour-speed-out');
    if (!out || !window.fetch) return;
    function esc(s) {ldelim} return String(s).replace(/[&<>"]/g, function (c) {ldelim} return {ldelim}'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'{rdelim}[c]; {rdelim}); {rdelim}
    function ago(t) {ldelim}
        var s = Math.max(0, Math.round(Date.now() / 1000 - t));
        if (s < 90) return s + ' seconds ago';
        if (s < 5400) return Math.round(s / 60) + ' minutes ago';
        if (s < 129600) return Math.round(s / 3600) + ' hours ago';
        return Math.round(s / 86400) + ' days ago';
    {rdelim}
    function ms(v) {ldelim} return v === null || v === undefined ? '-' : (v < 10 ? v.toFixed(1) : Math.round(v)) + ' ms'; {rdelim}
    fetch({'showcase/speed'|ezurl}, {ldelim} credentials: 'same-origin', cache: 'no-store' {rdelim})
        .then(function (r) {ldelim} return r.json(); {rdelim})
        .then(function (d) {ldelim}
            if (!d.ok || !d.result) {ldelim} out.innerHTML = '<p>No measurement yet. An administrator starts one from the admin dashboard.</p>'; return; {rdelim}
            var r = d.result, html = '';
            function table(rows, title, note) {ldelim}
                var max = 1, h = '';
                rows = rows.filter(function (p) {ldelim} return p.apache.server_ms !== null && p.velocity.server_ms !== null; {rdelim});
                if (!rows.length) return '';
                rows.forEach(function (p) {ldelim} [p.apache.server_ms, p.velocity.server_ms].forEach(function (v) {ldelim} if (v > max) max = v; {rdelim}); {rdelim});
                h += '<h3 class="exp-tour-speed-sub">' + esc(title) + '</h3><p class="exp-tour-speed-note">' + esc(note) + '</p>';
                h += '<table><thead><tr><th>Page</th><th class="num">Apache</th><th class="num">Velocity</th><th class="bar">Median time to answer</th><th class="num">Faster</th></tr></thead><tbody>';
                rows.forEach(function (p) {ldelim}
                    var a = p.apache.server_ms, v = p.velocity.server_ms, f = a / v, win = '';
                    if (f >= 1.1) win = '<span class="exp-tour-factor"><span class="w">Velocity </span>' + f.toFixed(1) + 'x</span>';
                    else if (f <= 0.91) win = '<span class="exp-tour-factor is-a"><span class="w">Apache </span>' + (1 / f).toFixed(1) + 'x</span>';
                    else win = 'even';
                    h += '<tr><td><a data-path="' + esc(p.path) + '">' + esc(p.label) + '</a></td>'
                       + '<td class="num">' + ms(a) + '</td><td class="num">' + ms(v) + '</td>'
                       + '<td class="bar"><span class="exp-tour-bar" style="width:' + Math.max(1, 100 * a / max) + '%"></span>'
                       + '<span class="exp-tour-bar is-v" style="width:' + Math.max(1, 100 * v / max) + '%"></span></td>'
                       + '<td class="num">' + win + '</td></tr>';
                {rdelim});
                return h + '</tbody></table>';
            {rdelim}
            html += table(r.pages, 'Returning visitors: pages from the cache', 'What most requests are. Velocity answers from its in-memory response cache; Apache from the view cache on disk.');
            if (r.cold && r.cold.length)
                html += table(r.cold, 'Rendered for the request: past every cache', 'A query string no cache has seen, so both servers run Exponential for each request. Here the two are close, and Apache is often a little ahead: honest numbers, not a benchmark trick.');
            html += '<small>Measured ' + esc(ago(r.measured)) + ' (' + esc(new Date(r.measured * 1000).toLocaleString()) + ') with ' + esc(r.method === 'curl' ? 'curl' : './console exp:benchmark')
                 + ', ' + esc(r.rounds) + ' requests per page and server' + (r.cold && r.cold.length ? ' (' + esc(r.cold_rounds) + ' rendered)' : '') + ', two at a time, PHP ' + esc(r.php) + '. Grey: Apache with PHP-FPM; yellow: Velocity.</small>';
            out.innerHTML = html;
            // the page links get their address here, not in the HTML text above: a crawler reading the script
            // as HTML would take the concatenation for an address
            out.querySelectorAll('a[data-path]').forEach(function (a) {ldelim} a.setAttribute('href', a.getAttribute('data-path')); {rdelim});
        {rdelim})
        .catch(function () {ldelim} out.innerHTML = '<p>The measurement could not be loaded right now.</p>'; {rdelim});
{rdelim})();
</script>
{undef $stops $speed $stop_map $img $no}
