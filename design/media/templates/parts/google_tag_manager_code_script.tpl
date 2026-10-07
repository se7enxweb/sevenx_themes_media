{def $exp_config = exponential().configResolver}
{if hasParameter($exp_config, 'site_settings.google_tag_manager_code')}
    {def $google_tag_manager_code = getParameter($exp_config, 'site_settings.google_tag_manager_code')}

    {if $google_tag_manager_code|count|gt(0)}

        <script>{literal}
            // DataLayer and the gtag function.
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}

            // Granted or denied for a category of the cookie banner. The banner
            // (exp-cookie-consent.js) keeps the visitor's choice in one cookie,
            // ng-cc-consent = "v<version>.rejected" or "v<version>.<name>+<name>".
            // The banner offers "analytics" and "marketing" only once they are
            // added to it with a handler; until then both stay denied here.
            window.getCookieStatus = function(category) {
                var match = document.cookie.match(/(?:^|;\s*)ng-cc-consent=v[^.;]*\.([^;]*)/);
                var accepted = match && match[1] !== 'rejected' ? match[1].split('+') : [];
                return accepted.indexOf(category) !== -1 ? 'granted' : 'denied';
            }

            // Set default consent based on the stored choice
            gtag('consent', 'default', {
                'ad_storage': getCookieStatus('marketing'),
                'ad_user_data': getCookieStatus('marketing'),
                'ad_personalization': getCookieStatus('marketing'),
                'analytics_storage': getCookieStatus('analytics')
            });

            // Follow a choice made on this page
            document.addEventListener('exp:cookie-consent', function () {
                gtag('consent', 'update', {
                    'ad_storage': getCookieStatus('marketing'),
                    'ad_user_data': getCookieStatus('marketing'),
                    'ad_personalization': getCookieStatus('marketing'),
                    'analytics_storage': getCookieStatus('analytics')
                });
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
