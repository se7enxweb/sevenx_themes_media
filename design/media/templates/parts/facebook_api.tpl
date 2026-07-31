{if and(hasParameter($ibexa.configResolver, 'site_settings.facebook_api', 'ngsite'), hasParameter($ibexa.configResolver, 'facebook_app_id', 'netgen_open_graph'))}
    {def $facebook_api = getParameter($ibexa.configResolver, 'site_settings.facebook_api', 'ngsite')}

    {if $facebook_api}
        {def $facebook_app_id = getParameter($ibexa.configResolver, 'facebook_app_id', 'netgen_open_graph')}
        {def $facebook_locale = 'en_US'}
        {if hasParameter($ibexa.configResolver, 'site_settings.facebook_locale', 'ngsite')}
            {def $facebook_locale = parameter($ibexa.configResolver, 'site_settings.facebook_locale', 'ngsite')}
        {/if}

        {if and(not(($facebook_app_id|count()|eq(0))), not(($facebook_locale|count()|eq(0))))}
            <script>
              window.fbAsyncInit = function() {
                FB.init({
                  appId            : '{$facebook_app_id|wash('js')}',
                  autoLogAppEvents : true,
                  xfbml            : true,
                  version          : 'v2.12'
                });
              };

              (function(d, s, id){
                 var js, fjs = d.getElementsByTagName(s)[0];
                 if (d.getElementById(id)) {return;}
                 js = d.createElement(s); js.id = id;
                 js.src = "https://connect.facebook.net/{$facebook_locale|wash('js')}/sdk.js";
                 fjs.parentNode.insertBefore(js, fjs);
               }(document, 'script', 'facebook-jssdk'));
            </script>
        {/if}
    {/if}
{/if}