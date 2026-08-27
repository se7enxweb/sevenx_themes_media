{* Mirrors templates/themes/app/pagelayout/breadcrumbs.html.twig:
   root item with home icon, linked/no-link middle items, current page as
   no-link with aria-current. Hidden until the path is deeper than 2.

   When this template is rendered from a twig_block inside an Exponential layout,
   $path_array may not be inherited from pagelayout.tpl, so build it from the
   current node if needed. *}
{def $bc_path_array = false()}
{if is_set($path_array)}
    {set $bc_path_array = $path_array}
{else}
    {def $bc_node = false()}
    {if and(is_set($node), is_object($node))}
        {set $bc_node = $node}
    {elseif and(is_set($module_result), is_set($module_result.content_info), is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
        {set $bc_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
    {/if}
    {if $bc_node}
        {def $bc_items = array()}
        {foreach $bc_node.path as $bc_path_node}
            {if $bc_path_node.depth|gt(1)}
                {set $bc_items = $bc_items|append(hash('text', $bc_path_node.name, 'url', $bc_path_node.url_alias))}
            {/if}
        {/foreach}
        {set $bc_items = $bc_items|append(hash('text', $bc_node.name, 'url', false()))}
        {set $bc_path_array = $bc_items}
        {undef $bc_items}
    {/if}
    {undef $bc_node}
{/if}
{if not(is_set($show_path))}
    {def $show_path = true()}
{/if}

{if and($show_path, $bc_path_array, gt($bc_path_array|count,2))}
    <nav class="breadcrumb-wrapper" aria-label="breadcrumbs">
        <ol>
            <li class="breadcrumb-item">
                <a href={$bc_path_array[0].url|ezurl}>
                    <i class="icon-home" aria-hidden="true"></i>
                    <span>{$bc_path_array[0].text|wash}</span>
                </a>
            </li>
            {foreach $bc_path_array as $bc_index => $path_item}
                {if $bc_index|gt(0)}
                    {if not($path_item.url)}
                    <li class="breadcrumb-item breadcrumb-item--no-link"><span{if $bc_index|eq($bc_path_array|count|sub(1))} aria-current="location"{/if}>{$path_item.text|wash}</span></li>
                    {else}
                    <li class="breadcrumb-item breadcrumb-item--link"><a href={$path_item.url|ezurl}{if $bc_index|eq($bc_path_array|count|sub(1))} aria-current="location"{/if}><span>{$path_item.text|wash}</span></a></li>
                    {/if}
                {/if}
            {/foreach}
        </ol>
    </nav>
{/if}
