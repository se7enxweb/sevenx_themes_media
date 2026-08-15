<div id="ng-cc">
    <div class="ng-cc-overlay"></div>

    <div class="ng-cc-modal js-focus-trap" role="region" tabindex="-1" aria-label="Cookie settings">
        <div class="ng-cc-content">
            <div class="wrapper">
                <p>To make this website run properly and to improve your experience, we use cookies. For more detailed information, please check our <a href="/cookie-policy">Cookie Policy</a>.</p>
            </div>

            <div class="ng-cc-actions">
                <a href="#" class="optional-list-toggle">
                    <span>Customize settings</span>
                    <span class="cookie-angle-up"></span>
                </a>
                <button id="ng-cc-accept" class="btn btn-primary ng-cc-btn-close">
                    <span>Accept all</span>
                </button>
            </div>
        </div>
        <div class="ng-cc-optional-list">
            <ul>
                <li>
                    <input type="checkbox" class="ng-cc-optional-checkbox" id="ng-cc-necessary" data-name="necessary" checked disabled />
                    <label for="ng-cc-necessary">
                        <i class="ng-cc-checkbox-icon">
                            <span class="on ng-cc-on">Accepted</span>
                            <span class="off ng-cc-off">Not accepted</span>
                        </i>
                        <span>Necessary cookies</span>
                    </label>
                    <p>Necessary cookies enable core functionality. The website cannot function properly without these cookies, and can only be disabled by changing your browser preferences.</p>
                </li>
            </ul>
            <div class="ng-cc-optional-actions clearfix">
                <button id="ng-cc-optional-save" class="btn btn-outline-primary ng-cc-btn-close">
                    <span>Save and close</span>
                </button>
            </div>
        </div>
    </div>
</div>

{literal}<script>
    window.__ngCcConfig = {
        options: {
            lifetime: 30,
        },
        optionalCookies: [
            {
                name: 'analytics',
                label: 'Analytics cookies',
                description: '<p>Analytics cookies help us to improve our website by collecting and reporting information on its usage.</p>',
                onAccept: function() {},
                onRevoke: function() {},
            },
            {
                name: 'marketing',
                label: 'Marketing cookies',
                description: '<p>We use marketing cookies to help us improve the relevancy of advertising campaigns you receive.</p>',
                onAccept: function() {},
                onRevoke: function() {},
            },
        ],
    };
</script>{/literal}
