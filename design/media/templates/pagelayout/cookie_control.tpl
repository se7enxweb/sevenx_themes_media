{def $cookie_policy_link = concat('<a href="', '/bold_ger/cookie-richtlinie'|ezurl('no'), '">', 'Cookie Policy'|i18n('design/media/pagelayout'), '</a>')}

<div id="ng-cc">
    <div class="ng-cc-overlay"></div>

    <div class="ng-cc-modal js-focus-trap" role="region" tabindex="-1" aria-label="{'Cookie settings'|i18n('design/media/pagelayout')}">
        <div class="ng-cc-content">
            <div class="wrapper">
                <p>{'To make this website run properly and to improve your experience, we use cookies. For more detailed information, please check our %cookie_link.'|i18n('design/media/pagelayout', '', hash('%cookie_link', $cookie_policy_link))}</p>
            </div>

            <div class="ng-cc-actions">
                <a href="#" class="optional-list-toggle">
                    <span>{'Customize settings'|i18n('design/media/pagelayout')}</span>
                    <span class="cookie-angle-up"></span>
                </a>
                <button id="ng-cc-accept" class="btn btn-primary ng-cc-btn-close">
                    <span>{'Accept all'|i18n('design/media/pagelayout')}</span>
                </button>
            </div>
        </div>
        <div class="ng-cc-optional-list">
            <ul>
                <li>
                    <input type="checkbox" class="ng-cc-optional-checkbox" id="ng-cc-necessary" data-name="necessary" checked disabled />
                    <label for="ng-cc-necessary">
                        <i class="ng-cc-checkbox-icon">
                            <span class="on ng-cc-on">{'Accepted'|i18n('design/media/pagelayout')}</span>
                            <span class="off ng-cc-off">{'Not accepted'|i18n('design/media/pagelayout')}</span>
                        </i>
                        <span>{'Necessary cookies'|i18n('design/media/pagelayout')}</span>
                    </label>
                    <p>{'Necessary cookies enable core functionality. The website cannot function properly without these cookies, and can only be disabled by changing your browser preferences.'|i18n('design/media/pagelayout')}</p>
                </li>
            </ul>
            <div class="ng-cc-optional-actions clearfix">
                <button id="ng-cc-optional-save" class="btn btn-outline-primary ng-cc-btn-close">
                    <span>{'Save and close'|i18n('design/media/pagelayout')}</span>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    window.__ngCcConfig = {ldelim}
        options: {ldelim}
            lifetime: 30,
        {rdelim},
        optionalCookies: [
            {ldelim}
                name: 'analytics',
                label: "{'Analytics cookies'|i18n('design/media/pagelayout')}",
                description: "{'Analytics cookies help us to improve our website by collecting and reporting information on its usage.'|i18n('design/media/pagelayout')}",
                onAccept: function() {ldelim}{rdelim},
                onRevoke: function() {ldelim}{rdelim},
            {rdelim},
            {ldelim}
                name: 'marketing',
                label: "{'Marketing cookies'|i18n('design/media/pagelayout')}",
                description: "{'We use marketing cookies to help us improve the relevancy of advertising campaigns you receive.'|i18n('design/media/pagelayout')}",
                onAccept: function() {ldelim}{rdelim},
                onRevoke: function() {ldelim}{rdelim},
            {rdelim},
        ],
    {rdelim};
</script>

{undef $cookie_policy_link}
