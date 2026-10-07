{* Scripts for the media design.

   Two groups, deliberately, because these four files do not have the same
   execution rules. runtime.js and index.js are render-blocking and have to run
   in order before the page is drawn; index-noncritical.js and ajax-load-more.js
   carry defer and run after parsing. Packing all four into one tag would force
   a single policy on both halves -- either the deferred pair becomes
   render-blocking, or the critical pair stops running before first paint. So
   they are packed as two bundles rather than one, which is still four requests
   down to two and 535 kB gzipped down to 161 kB.

   ezscript_load for the blocking group: like ezcss_load it merges in whatever
   a content template asked for with ezscript_require during the render, and
   emits it. Those requirements were being dropped before this template called
   anything.

   ezscriptfiles with ignore_loaded for the deferred group: it returns the
   packed URL instead of a tag, so the defer attribute can be written here.
   ignore_loaded keeps the two groups independent -- without it the second call
   would diff itself against the first and drop anything they had in common.

   Pack level 2, which concatenates and then runs ezjscJavascriptOptimizer.
   Level 1 would concatenate and stop; it is the fallback if these bundles ever
   start misbehaving again, and it still turns four requests into two.

   The optimizer needed fixing before level 2 was usable here. It strips
   comments with regular expressions, and the pattern eats one whitespace
   character in front of the comment -- which is a line break for a comment on
   its own line and a space for one in the middle of a line. Dropping it broke
   the first shape, always replacing it with a newline broke the second by
   turning "return /* binding */ x" into a return followed by a line break,
   which is an automatic semicolon. Both failures are real and both were seen
   here. Verify with the optimizer's own semantics check and then open the page
   with the console visible; node --check cannot see the second one. *}

{ezscript_load( array( 'runtime.js',
                       'index.js' ), 'text/javascript', '', 'utf-8', 2 )}

{* The words exp-youtube-consent.js needs for a video it draws itself (the
   video modal), in this siteaccess's language, and its privacy policy page.
   The videos drawn by content/parts/youtube_player.tpl carry their own. *}
{def $sc_pp_node = cond( ezini_hasvariable( 'SiteInfo', 'PrivacyPolicyID', 'menu.ini' ),
                         fetch( 'content', 'node',
                                hash( 'node_id', ezini( 'SiteInfo', 'PrivacyPolicyID', 'menu.ini' ) ) ),
                         false() )}
<script type="application/json" id="exp-yt-config">{json_encode( hash(
    'notice', 'Playing this video loads it from YouTube (Google). See our %privacy_link.'|i18n('design/media/video'),
    'privacyLabel', 'Privacy policy'|i18n('design/media/video'),
    'privacyUrl', cond( is_object( $sc_pp_node ), $sc_pp_node|site_url, '' ),
    'play', 'Play video'|i18n('design/media/video'),
    'playTitle', 'Play video: %title'|i18n('design/media/video'),
    'always', 'Always allow YouTube videos on this site'|i18n('design/media/video'),
    'stop', 'Stop loading YouTube automatically'|i18n('design/media/video'),
    'frameTitle', 'YouTube video'|i18n('design/media/video'),
    'placeholder', concat( '/', 'extension/sevenx_themes_media/design/media/images/video-placeholder.svg' )|ezroot(no) ) )}</script>
{undef $sc_pp_node}

{foreach ezscriptfiles( array( 'index-noncritical.js',
                               'ajax-load-more.js',
                               'exp-youtube-consent.js',
                               'exp-cookie-consent.js' ), 2, true() ) as $sc_deferred}
<script defer type="text/javascript" src="{$sc_deferred}"></script>
{/foreach}
