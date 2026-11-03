{* The header search: a button (aria-expanded, aria-controls) that opens the search form. The design's header script
   opens and closes it; javascript/exp-header-menu.js adds Escape (closes it and gives the focus back to the button)
   and keeps one header menu open at a time (the search or the user menu, pagelayout/header/user_menu.tpl). On phones
   the open form takes the full width below the header bar (exp-header-menu.css). *}
<div class="header-search">
    <button type="button" class="searchbox-toggle" title="{'Search'|i18n('ngsite')}" aria-expanded="false" aria-controls="site-wide-search">
        <i class="icon-search" aria-hidden="true"></i>
        <span class="sr-only">{'Search'|i18n('ngsite')}</span>
    </button>

    <form class="navbar-search" method="post" action={"/content/search"|ezurl} id="site-wide-search" role="search">
        <label for="site-wide-search-field" class="sr-only">{'Search'|i18n('ngsite')}</label>
        <input class="search-query" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('ngsite')}">
        <button type="submit" class="search-submit">{'Search'|i18n('ngsite')}</button>
        {include uri='design:parts/front_search_suggest.tpl'}
    </form>
</div>
