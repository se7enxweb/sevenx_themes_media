{def $exp_config = exponential().configResolver}
{if hasParameter($exp_config, 'site_settings.google_tag_manager_code')}
    {def $google_tag_manager_code = getParameter($exp_config, 'site_settings.google_tag_manager_code')}

    {if $google_tag_manager_code|count|gt(0)}
        <noscript><iframe aria-hidden="true" src="https://www.googletagmanager.com/ns.html?id={$google_tag_manager_code|wash}"
        height="0" width="0" style="display:none;visibility:hidden" title=""></iframe></noscript>
    {/if}
{/if}
