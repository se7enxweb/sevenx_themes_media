{if hasParameter($ibexa.configResolver, 'site_settings.google_tag_manager_code', 'ngsite')}
    {def $google_tag_manager_code = getParameter($ibexa.configResolver, 'site_settings.google_tag_manager_code', 'ngsite')}

    {if not(($google_tag_manager_code|count()|eq(0)))}
        <noscript><iframe aria-hidden="true" src="https://www.googletagmanager.com/ns.html?id={$google_tag_manager_code|wash('url')}"
        height="0" width="0" style="display:none;visibility:hidden" title=""></iframe></noscript>
    {/if}
{/if}