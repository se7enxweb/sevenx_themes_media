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

   account.css draws the account pages: the e-mail preferences, the notification
   settings, the user profile and the public edit form (see its header).

   error-page.css draws the error pages and their search form.

   exp-header-menu.css draws the header's user menu and the header search on phones;
   it comes last because it builds on index.css.

   exp-advanced-search.css draws content/advancedsearch; exp-page-parts.css holds the
   rules that used to sit in <style> blocks and style="" attributes of the page
   templates (sitemap, tag cloud, tour, product stars, lists, maps, basket).

   exp-mobile-layout.css comes last: the phone, tablet and 200% zoom fixes of the
   crawl in #514 (tap targets, input sizes, squeezed images, the generic full view).

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

{* exp-color-mode.css comes after everything of the theme: the dark and darker color modes answer the colors the
   other stylesheets set (see its header). Its script, exp-color-mode.js, runs first, before any stylesheet: it sets
   the mode on <html> from the visitor's choice, so the page is drawn in that mode from the first paint, without a
   flash of the light page. A file of its own, packed like the others, so it runs under a Content Security Policy
   without 'unsafe-inline'. *}
{ezscript( array( 'exp-color-mode.js' ) )}

{* After the theme's own list: what other extensions add to design.ini
   [StylesheetSettings] CSSFileList[] and FrontendCSSFileList[], in that
   order, each file once. Entries the media design replaces (the simple
   theme's base styles and the theme's retired files) are named in
   MediaReplacedCSSFileList[] and left out, as are files already in the
   theme's list. They go into the same packed bundle, after the theme's
   files, so an extension can build on the theme's styles. *}
{def $media_css_own = array( 'inter.css',
                             'explayouts_standard/grid.css',
                             'index.css',
                             'index-noncritical.css',
                             'explayouts.css',
                             'shop.css',
                             'account.css',
                             'error-page.css',
                             'zoom-support.css',
                             'exp-youtube-consent.css',
                             'exp-cookie-consent.css',
                             'exp-header-menu.css',
                             'exp-advanced-search.css',
                             'exp-page-parts.css',
                             'exp-mobile-layout.css',
                             'exp-color-mode.css' )
     $media_css_skip = cond( ezini_hasvariable( 'StylesheetSettings', 'MediaReplacedCSSFileList', 'design.ini' ),
                             ezini( 'StylesheetSettings', 'MediaReplacedCSSFileList', 'design.ini' ),
                             array() )
     $media_css_extra = array()}
{foreach array( 'CSSFileList', 'FrontendCSSFileList' ) as $media_css_setting}
    {if ezini_hasvariable( 'StylesheetSettings', $media_css_setting, 'design.ini' )}
        {foreach ezini( 'StylesheetSettings', $media_css_setting, 'design.ini' ) as $media_css_file}
            {if and( $media_css_file|ne( '' ),
                     $media_css_own|contains( $media_css_file )|not,
                     $media_css_skip|contains( $media_css_file )|not,
                     $media_css_extra|contains( $media_css_file )|not )}
                {set $media_css_extra = $media_css_extra|append( $media_css_file )}
            {/if}
        {/foreach}
    {/if}
{/foreach}
{ezcss_load( $media_css_own|merge( $media_css_extra ) )}
{undef $media_css_own $media_css_skip $media_css_extra}
