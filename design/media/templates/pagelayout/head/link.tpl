{def $lnk_info = fetch('content','object',hash('object_id',false(),'remote_id', ezini('SiteInfo','RemoteID','menu.ini')))}
{def $lnk_site_name = ''}

{if is_object($lnk_info)}
    {if $lnk_info.data_map.site_name.has_content}
        {set $lnk_site_name = $lnk_info.data_map.site_name.content}
    {/if}
{/if}

{def $lnk_canonical = ''}
{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {def $lnk_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
            {if and($lnk_node, $lnk_node.url_alias|ne(''))}
                {set $lnk_canonical = concat('https://', ezini('SiteSettings','SiteURL'), '/', $lnk_node.url_alias)}
            {/if}
            {undef $lnk_node}
        {/if}
    {/if}
{/if}
{if $lnk_canonical|eq('')}
    {set $lnk_canonical = concat('https://', ezini('SiteSettings','SiteURL'), '/')}
{/if}
<link rel="canonical" href="{$lnk_canonical}" />

<link rel="home" href="/" title="{$lnk_site_name|wash} front page" />
<link rel="index" href="/" />
<link rel="search" href="/content/search" title="Search {$lnk_site_name|wash}" />

{def $lnk_icon = false()}
{if is_object($lnk_info)}
    {foreach array('favicon_32x32','favicon_128x128','favicon_192x192') as $lnk_field}
        {if and(is_set($lnk_info.data_map[$lnk_field]), $lnk_info.data_map[$lnk_field].has_content)}
            {set $lnk_icon = $lnk_info.data_map[$lnk_field].content}
            {if is_set($lnk_icon.original)}
<link rel="icon" href={$lnk_icon.original.url|ezroot} sizes="{$lnk_field|ristring('favicon_','')}">
            {/if}
        {/if}
    {/foreach}

    {if and(is_set($lnk_info.data_map.favicon_192x192), $lnk_info.data_map.favicon_192x192.has_content)}
        {set $lnk_icon = $lnk_info.data_map.favicon_192x192.content}
        {if is_set($lnk_icon.original)}
<link rel="shortcut icon" href={$lnk_icon.original.url|ezroot} sizes="192x192">
        {/if}
    {/if}

    {if and(is_set($lnk_info.data_map.favicon_180x180), $lnk_info.data_map.favicon_180x180.has_content)}
        {set $lnk_icon = $lnk_info.data_map.favicon_180x180.content}
        {if is_set($lnk_icon.original)}
<link rel="apple-touch-icon" href={$lnk_icon.original.url|ezroot} sizes="180x180">
        {/if}
    {/if}
{/if}

{if $lnk_icon|not()}
    <link rel="icon" href="/var/site/storage/images/8/2/8/5/5828-38-eng-GB/8cddbccfcd14-fh_32x32.png" sizes="32x32">
    <link rel="icon" href="/var/site/storage/images/9/2/8/5/5829-38-eng-GB/bd7f3164958b-fh_128x128.png" sizes="128x128">
    <link rel="icon" href="/var/site/storage/images/1/3/8/5/5831-38-eng-GB/262435e1068c-fh_192x192.png" sizes="192x192">
    <link rel="shortcut icon" href="/var/site/storage/images/1/3/8/5/5831-38-eng-GB/262435e1068c-fh_192x192.png" sizes="192x192">
    <link rel="apple-touch-icon" href="/var/site/storage/images/0/3/8/5/5830-38-eng-GB/8178913f1645-fh_180x180.png" sizes="180x180">
{/if}

{undef $lnk_icon}
{undef $lnk_canonical}
{undef $lnk_site_name}
{undef $lnk_info}
