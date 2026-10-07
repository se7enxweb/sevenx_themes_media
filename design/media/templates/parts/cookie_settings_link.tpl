{* "Cookie settings": reopens the cookie banner (exp-cookie-consent.js binds
   js-open-ng-cc) so a visitor can change their choice. Without JavaScript it
   is a plain link to the cookie policy page named in menu.ini, and the
   #cookie-settings hash opens the banner there once scripts run. *}
{def $csl_node = cond( ezini_hasvariable( 'SiteInfo', 'CookiePolicyID', 'menu.ini' ),
                       fetch( 'content', 'node',
                              hash( 'node_id', ezini( 'SiteInfo', 'CookiePolicyID', 'menu.ini' ) ) ),
                       false() )}
<a href="{if is_object( $csl_node )}{$csl_node|site_url|wash}{/if}#cookie-settings" class="js-open-ng-cc d-block my-2">{'Cookie settings'|i18n('design/media/pagelayout')}</a>
{undef $csl_node}
