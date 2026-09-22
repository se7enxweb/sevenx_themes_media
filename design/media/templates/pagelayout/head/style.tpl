{* Stylesheets for the media design.

   These go through ezjscore's packer rather than out as five separate <link>
   tags. The packer concatenates them, strips the whitespace webpack left in,
   and writes one file to var/<site>/cache/public/stylesheets/, which takes the
   five files from 225 kB gzipped to 51 kB and five requests to one.

   ezcss_load, not ezcss: _load merges this list with everything a content
   template asked for with ezcss_require during the render, and emits the lot.
   That is how ezstarrating and anything else that declares its own stylesheet
   finally reaches the page -- before this, nothing in the design emitted those
   requirements and they were silently dropped.

   Order matters and is preserved: ezcss_load puts its own array first and the
   required files after, so the theme's base styles load before whatever a
   content template added, and shop.css still comes last of ours so it can
   widen the content area for the pages carrying tables without fighting
   index.css on specificity.

   Paths are design-relative: the packer resolves them through the design
   fallback chain, so 'index.css' finds design/media/stylesheets/index.css here
   and 'explayouts_standard/grid.css' finds it in the explayouts extension's
   design/standard.

   Inter is served from here, so it packs with everything else.

   It used to be a raw third-party tag, and it was the first render-blocking
   thing on the page. That cost two origins before any CSS arrived: a DNS
   lookup, a TCP connect and a TLS handshake for fonts.googleapis.com, and
   then the same three again for fonts.gstatic.com, which its stylesheet
   points at. Measured against this installation, the round trip to a real
   browser is about 13ms, so those handshakes were on the order of 100ms
   during which the page could not paint text -- against 11ms for the document
   itself. The preconnect hints went with them; there is nothing left to
   preconnect to.

   In the bundle it costs no request at all: it is packed into the same file
   the page already fetches. Only the woff2 files are separate, and they are
   fetched once and then cached for a year like any other static asset.

   inter.css comes first so the @font-face rules are defined before anything
   sets font-family on them.

   Regenerate with ai/bin/one/selfhost_google_fonts_into_media_theme.py, which
   re-downloads from Google and rewrites the paths. *}

{ezcss_load( array( 'inter.css',
                    'explayouts_standard/grid.css',
                    'index.css',
                    'index-noncritical.css',
                    'explayouts.css',
                    'shop.css' ) )}
