{def $ibexa_config = ibexa().configResolver}
{if hasParameter($ibexa_config, 'site_settings.google_tag_manager_code')}
    {def $google_tag_manager_code = getParameter($ibexa_config, 'site_settings.google_tag_manager_code')}

    {if $google_tag_manager_code|count|gt(0)}

        <script>{literal}
            // DataLayer and the gtag function.
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}

            // Get denied or granted from cookie
            window.getCookieStatus = function(cookieName) {
                var cookieValue = document.cookie.replace(new RegExp("(?:(?:^|.*;\\s*)" + cookieName + "\\s*=\\s*([^;]*).*$)|^.*$"), "$1");
                return cookieValue === undefined ? 'denied' : cookieValue === '1' ? 'granted' : 'denied';
            }

            // Set global status for dynamic handling
            window.lastAnalyticsStatus = getCookieStatus('ng-cc-analytics');
            window.lastMarketingStatus = getCookieStatus('ng-cc-marketing');

            // Set default consent based on cookie status
            gtag('consent', 'default', {
                'ad_storage': getCookieStatus('ng-cc-marketing'),
                'ad_user_data': getCookieStatus('ng-cc-marketing'),
                'ad_personalization': getCookieStatus('ng-cc-marketing'),
                'analytics_storage': getCookieStatus('ng-cc-analytics')
            });
        {/literal}</script>

        <!-- Google Tag Manager -->
        <script>{literal}(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','{/literal}{$google_tag_manager_code|wash}{literal}');{/literal}</script>
        <!-- End Google Tag Manager -->

    {/if}
{/if}
