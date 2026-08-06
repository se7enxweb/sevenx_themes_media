{def $site_title = first_set($site_name, '')}
{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {def $title_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
            {if $title_node}
                {def $title_meta = metadata($title_node.node_id)}
                {def $title_text = $title_node.name}
                {if $title_meta}
                    {if $title_meta.title|ne('')}
                        {set $title_text = $title_meta.title}
                    {/if}
                {/if}
                {if $title_text|ne($site_name)}
                    {set $site_title = concat($title_text, cond($site_title|count|gt(0), concat(' - ', $site_title), ''))}
                {else}
                    {set $site_title = $title_text}
                {/if}
                {undef $title_text}
                {undef $title_meta}
            {/if}
        {/if}
    {/if}
{/if}
<title>{$site_title|wash}</title>
