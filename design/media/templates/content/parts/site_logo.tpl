{def $si = fetch('content','object',hash('object_id',false(),'remote_id', ezini('SiteInfo','RemoteID','menu.ini')))}
{def $site_name_text = ezini('SiteSettings','SiteName','site.ini')}
{def $logo_url = ''}

{if and(is_object($si), $si.data_map.site_logo.has_content)}
    {set $logo_url = $si.data_map.site_logo.content.filepath}
{/if}

{if $logo_url|eq('')}
    {set $logo_url = 'images/site-logo.svg'|ezdesign(no)}
{/if}

<a class="site-logo" href={'/'|ezurl()} title="{$site_name_text|wash}">
    <img src={$logo_url|ezroot} alt="{$site_name_text|wash}" />
</a>

{undef $si}
{undef $site_name_text}
{undef $logo_url}
