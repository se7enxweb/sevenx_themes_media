<header class="site-header site-header-fixed">
    <div class="header-content container">
        {include uri='design:content/parts/site_logo.tpl'}

        <button class="mainnav-toggle" aria-label="{$'ngsite.main_navigation'|trans}" aria-controls="mainNavigation" aria-expanded="false">
            <span class="hamburger" aria-hidden="true"></span>
        </button>

        {include uri='design:pagelayout/header/main_menu.tpl'}
        {include uri='design:pagelayout/header/search_box.tpl'}
        {include uri='design:pagelayout/header/language_selector.tpl'}
    </div>
</header>