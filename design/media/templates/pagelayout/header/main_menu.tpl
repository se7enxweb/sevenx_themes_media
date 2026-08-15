{def $mm_ids = ezini('SiteInfo','MainMenuID','menu.ini')|unique}
{def $mm_nexus_ids = ezini('SiteInfo','NexusMainMenuID','menu.ini')|unique}
{def $mm_last = count($mm_ids)|sub(1)}
{def $mm_node = false()}
{def $mm_display_id = false()}

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
        <li id="menu-item-main_menu-location-id-{$mm_display_id}"{if $mm_index|eq(0)} class="firstli"{elseif $mm_index|eq($mm_last)} class="lastli"{/if} data-location-id="{$mm_display_id}">
            <a href={$mm_node.url_alias|ezurl}>{$mm_node.name|wash}</a>
        </li>
        {/if}
    {/foreach}
    </ul>
{/if}
</nav>
