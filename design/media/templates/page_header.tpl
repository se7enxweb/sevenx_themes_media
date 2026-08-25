<header class="site-header">
    <div class="header-content container">
        <a class="site-logo" href={"/"|ezurl()} title="Fit &amp; Healthy">
            <img src="/var/site/storage/original/image/e88a83ca0b5484f343458f434a3daf11.svg" alt="">
        </a>

        <button class="mainnav-toggle" aria-label="Main navigation" aria-controls="mainNavigation" aria-expanded="false">
            <span class="hamburger" aria-hidden="true"></span>
        </button>

        <nav class="main-navigation" id="mainNavigation" role="navigation">
            {def $mm_ids = ezini('SiteInfo','MainMenuID','menu.ini')|unique}
            {def $mm_nexus_ids = ezini('SiteInfo','NexusMainMenuID','menu.ini')|unique}
            {def $mm_last = count($mm_ids)|sub(1)}
            {def $mm_node = false()}
            {def $mm_display_id = false()}
            {if $mm_ids|count|gt(0)}
            <ul class="nav navbar-nav">
                {foreach $mm_ids as $mm_index => $mm_id}
                    {set $mm_node = fetch('content','node',hash('node_id',$mm_id))}
                    {set $mm_display_id = $mm_id}
                    {if and( is_set($mm_nexus_ids[$mm_index]), $mm_nexus_ids[$mm_index]|ne('') )}
                        {set $mm_display_id = $mm_nexus_ids[$mm_index]}
                    {/if}
                    {if is_object($mm_node)}
                <li id="menu-item-main_menu-location-id-{$mm_display_id}" class="{if $mm_index|eq(0)}firstli{elseif $mm_index|eq($mm_last)}lastli{/if}" data-location-id="{$mm_display_id}"><a href={$mm_node.url_alias|ezurl()}>{$mm_node.name|wash}</a></li>
                    {/if}
                {/foreach}
            </ul>
            {/if}
        </nav>

        <div class="header-search">
            <a class="searchbox-toggle" href={"/content/search"|ezurl()} title="Search" aria-expanded="false" aria-controls="site-wide-search">
                <i class="icon-search" aria-hidden="true"></i>
                <span class="sr-only">Search</span>
            </a>

            <form class="navbar-search" method="get" action={"/content/search"|ezurl()} id="site-wide-search">
                <label for="site-wide-search-field" class="sr-only">Search</label>
                <input class="search-query" type="search" name="SearchText" id="site-wide-search-field" placeholder="Search">
                <button type="submit" class="search-submit">Go</button>
            </form>
        </div>
    </div>
</header>
