{def $site_title = first_set($site_name, '')}
{def $page_title = ''}
{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {def $title_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
            {if $title_node}
                {def $title_meta = metadata($title_node.node_id)}
                {set $page_title = $title_node.name}
                {if $title_meta}
                    {if $title_meta.title|ne('')}
                        {set $page_title = $title_meta.title}
                    {/if}
                {/if}
                {undef $title_meta}
            {/if}
        {/if}
    {/if}
{/if}
{* A module view - a tag page, for instance - has no node to take a name
   from, so the title fell back to the site name alone and every one of them
   was headed "Fit & Healthy". What such a page is about is in the module
   result path, and its last element is the page itself. *}
{if $page_title|eq('')}
    {if is_array($module_result.path)}
        {foreach $module_result.path as $title_path_element}
            {if is_set($title_path_element.text)}
                {if $title_path_element.text|ne('')}
                    {set $page_title = $title_path_element.text}
                {/if}
            {/if}
        {/foreach}
    {/if}
{/if}
{if $page_title|ne('')}
    {if $page_title|ne($site_name)}
        {set $site_title = concat($page_title, cond($site_title|count|gt(0), concat(' - ', $site_title), ''))}
    {else}
        {set $site_title = $page_title}
    {/if}
{/if}
<title>{$site_title|wash}</title>
{undef $page_title}
