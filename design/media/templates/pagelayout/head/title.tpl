{def $site_title = first_set($site_name, '')}
{if and(is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {def $title_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
    {if and(is_set($title_node), $title_node|count()|gt(0))}
        {if $title_node.name|ne($site_name)}
            {def $site_title = concat($title_node.name, cond($site_title|count()|gt(0), concat(' - ', $site_title), ''))}
        {else}
            {def $site_title = $title_node.name}
        {/if}
    {/if}
{/if}
<title>{$site_title|wash}</title>
