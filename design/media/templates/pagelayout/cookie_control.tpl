{* The cookie banner. javascript/exp-cookie-consent.js runs it; the comment at
   the top of that file describes the cookie it writes.

   What it offers is what the site has:
   - Strictly necessary: always on, explained, no switch.
   - Embedded videos (YouTube): the same choice as "Always allow YouTube videos
     on this site" under each video (localStorage exp-youtube-always). Off, a
     video still plays when its own play button is pressed.
   The first layer has "Reject all" and "Accept all", drawn the same, and
   "Settings", which unfolds the categories and "Save my choice".

   Adding a category later: a row below with data-exp-cc-category="<name>",
   its label and description, and a handler registered in JavaScript (see
   exp-cookie-consent.js). A row without a handler is never shown, so a
   category that does nothing cannot appear.

   The banner is hidden until the script decides to show it, so without
   JavaScript nothing is shown and nothing is stored; the "Cookie settings"
   link in the footer then leads to the cookie policy instead.

   The policy page is the one named per siteaccess in menu.ini
   ([SiteInfo] CookiePolicyID), addressed through site_url so another site's
   prefix reaches it. [SiteInfo] CookieConsentVersion is the policy version the
   choice is recorded under (default 1): raise it and every visitor is asked
   again. Keep it the same on every siteaccess of one host, because the
   consent cookie is shared by all of them (Path=/). *}
{def $cc_node = cond( ezini_hasvariable( 'SiteInfo', 'CookiePolicyID', 'menu.ini' ),
                      fetch( 'content', 'node',
                             hash( 'node_id', ezini( 'SiteInfo', 'CookiePolicyID', 'menu.ini' ) ) ),
                      false() )}
{def $cc_policy_link = cond( is_object( $cc_node ),
                             concat( '<a href="', $cc_node|site_url|wash, '">',
                                     'Cookie Policy'|i18n('design/media/pagelayout'), '</a>' ),
                             'Cookie Policy'|i18n('design/media/pagelayout') )}
{def $cc_version = cond( ezini_hasvariable( 'SiteInfo', 'CookieConsentVersion', 'menu.ini' ),
                         ezini( 'SiteInfo', 'CookieConsentVersion', 'menu.ini' ),
                         '1' )}

<script type="application/json" id="exp-cc-config">{json_encode( hash( 'version', $cc_version ) )}</script>

<section id="exp-cc" class="exp-cc" role="dialog" aria-modal="false" tabindex="-1"
         aria-labelledby="exp-cc-title" aria-describedby="exp-cc-text" hidden>
    <div class="exp-cc-inner">
        <div class="exp-cc-head">
            <h2 id="exp-cc-title" class="exp-cc-title">{'Cookies on this website'|i18n('design/media/cookieconsent')}</h2>
            <button type="button" class="exp-cc-close" data-exp-cc-action="close"
                    aria-label="{'Close without changes'|i18n('design/media/cookieconsent')}">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div class="exp-cc-body">
            <p id="exp-cc-text" class="exp-cc-text">{'This website stores only what it needs to work: a session cookie when you sign in, and copies of the pages you visit, kept in your browser so they open faster. YouTube videos load only when you press play. "Accept all" lets them load as soon as a page opens; YouTube (Google) may then store data in your browser. Your choice is kept in a cookie for 6 months. Details are in our %cookie_link.'|i18n('design/media/cookieconsent', '', hash('%cookie_link', $cc_policy_link))}</p>

            <div class="exp-cc-actions">
                <button type="button" class="btn btn-primary exp-cc-btn" data-exp-cc-action="reject">{'Reject all'|i18n('design/media/cookieconsent')}</button>
                <button type="button" class="btn btn-primary exp-cc-btn" data-exp-cc-action="accept">{'Accept all'|i18n('design/media/cookieconsent')}</button>
                <button type="button" class="btn btn-outline-primary exp-cc-btn exp-cc-btn-settings" data-exp-cc-action="settings"
                        aria-expanded="false" aria-controls="exp-cc-panel">{'Settings'|i18n('design/media/cookieconsent')}</button>
            </div>
        </div>

        <div id="exp-cc-panel" class="exp-cc-panel" hidden>
            <ul class="exp-cc-categories">
                <li class="exp-cc-category">
                    <div class="exp-cc-category-head">
                        <input type="checkbox" id="exp-cc-cat-necessary" checked disabled aria-describedby="exp-cc-cat-necessary-text">
                        <label for="exp-cc-cat-necessary">{'Strictly necessary'|i18n('design/media/cookieconsent')}</label>
                        <span class="exp-cc-always">{'Always on'|i18n('design/media/cookieconsent')}</span>
                    </div>
                    <p id="exp-cc-cat-necessary-text">{'The session cookie for signing in and for forms, the cookie that keeps this choice, and the copies of pages you visited that let them open faster. They stay on because the website needs them; you can delete them in your browser settings at any time.'|i18n('design/media/cookieconsent')}</p>
                </li>
                <li class="exp-cc-category" data-exp-cc-category="youtube" hidden>
                    <div class="exp-cc-category-head">
                        <input type="checkbox" id="exp-cc-cat-youtube" aria-describedby="exp-cc-cat-youtube-text">
                        <label for="exp-cc-cat-youtube">{'Embedded videos (YouTube)'|i18n('design/media/cookieconsent')}</label>
                    </div>
                    <p id="exp-cc-cat-youtube-text">{'Load YouTube videos as soon as a page opens, from www.youtube-nocookie.com. YouTube (Google) may then store data in your browser. When this is off, each video shows a picture and loads only when you press its play button. This is the same as "Always allow YouTube videos on this site" under a video.'|i18n('design/media/cookieconsent')}</p>
                </li>
            </ul>
            <div class="exp-cc-panel-actions">
                <button type="button" class="btn btn-outline-primary exp-cc-btn" data-exp-cc-action="save" hidden>{'Save my choice'|i18n('design/media/cookieconsent')}</button>
            </div>
        </div>
    </div>
</section>

{undef $cc_node $cc_policy_link $cc_version}
