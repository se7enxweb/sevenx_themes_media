{if hasParameter($ibexa.configResolver, 'site_settings.google_tag_manager_code', 'ngsite')}
    {def $google_tag_manager_code = getParameter($ibexa.configResolver, 'site_settings.google_tag_manager_code', 'ngsite')}

    {if not(($google_tag_manager_code|count()|eq(0)))}

        <script>
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
        </script>

        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','{$google_tag_manager_code|wash('js')}');</script>
        <!-- End Google Tag Manager -->

    {/if}
{/if}