{def $mm_ids = ezini('SiteInfo','MainMenuID','menu.ini')|unique}
{def $mm_nexus_ids = ezini('SiteInfo','NexusMainMenuID','menu.ini')|unique}
{def $mm_last = count($mm_ids)|sub(1)}
{def $mm_node = false()}
{def $mm_display_id = false()}
{def $mm_current_node = false()}
{if and(is_set($node), is_object($node))}
    {set $mm_current_node = $node}
{elseif and(is_set($module_result), is_set($module_result.content_info), is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {set $mm_current_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
{/if}

<nav class="main-navigation" id="mainNavigation" role="navigation">
{if $mm_ids|count|gt(0)}
    <ul class="nav navbar-nav">
    {foreach $mm_ids as $mm_index => $mm_id}
        {set $mm_node = fetch('content','node',hash('node_id',$mm_id))}
        {set $mm_display_id = $mm_id}
        {if and( is_set($mm_nexus_ids[$mm_index]), $mm_nexus_ids[$mm_index]|ne('') )}
            {set $mm_display_id = $mm_nexus_ids[$mm_index]}
        {/if}
        {if is_object($mm_node)}
        {def $mm_item_class = ''}
        {if $mm_index|eq(0)}{set $mm_item_class = concat($mm_item_class, 'firstli ')}{/if}
        {if $mm_index|eq($mm_last)}{set $mm_item_class = concat($mm_item_class, 'lastli ')}{/if}
        {if and($mm_current_node, $mm_current_node.path_array|contains($mm_node.node_id))}{set $mm_item_class = concat($mm_item_class, 'active ')}{/if}
        <li id="menu-item-main_menu-location-id-{$mm_display_id}"{if $mm_item_class|ne('')} class="{$mm_item_class|trim}"{/if} data-location-id="{$mm_display_id}">
            <a href={$mm_node.url_alias|ezurl}>{$mm_node.name|wash}</a>
        </li>
        {undef $mm_item_class}
        {/if}
    {/foreach}
    </ul>
{/if}
</nav>
