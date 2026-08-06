{def $mm_site_info = fetch('content','object',hash('object_id',839))}

<nav class="main-navigation" id="mainNavigation" role="navigation">
{if is_object($mm_site_info)}
{if $mm_site_info.data_map.main_menu.has_content}
    {def $mm_relations = $mm_site_info.data_map.main_menu.content.relation_list}
    {def $mm_last = $mm_relations|count|sub(1)}
    {def $mm_object = false()}
    {def $mm_node = false()}
    <ul class="nav navbar-nav">
    {foreach $mm_relations as $mm_index => $mm_relation}
        {set $mm_object = fetch('content','object',hash('object_id',$mm_relation.contentobject_id))}
        {set $mm_node = false()}
        {if $mm_object}
            {set $mm_node = $mm_object.main_node}
        {/if}
        {if $mm_node}
        <li id="menu-item-main_menu-location-id-{$mm_node.node_id}"{if $mm_index|eq(0)} class="firstli"{elseif $mm_index|eq($mm_last)} class="lastli"{/if} data-location-id="{$mm_node.node_id}">
            <a href={$mm_node.url_alias|ezurl}>{$mm_node.name|wash}</a>
        </li>
        {/if}
    {/foreach}
    </ul>
    {undef $mm_relations}
    {undef $mm_last}
    {undef $mm_object}
    {undef $mm_node}
{/if}
{/if}
</nav>
{undef $mm_site_info}
