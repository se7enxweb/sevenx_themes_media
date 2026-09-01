<div class="header-search">
    <a class="searchbox-toggle" href={"/content/search"|ezurl} title="{'Search'|i18n('ngsite')}" aria-expanded="false" aria-controls="site-wide-search">
        <i class="icon-search" aria-hidden="true"></i>
        <span class="sr-only">{'Search'|i18n('ngsite')}</span>
    </a>

    <form class="navbar-search" method="get" action={"/content/search"|ezurl} id="site-wide-search">
        <label for="site-wide-search-field" class="sr-only">{'Search'|i18n('ngsite')}</label>
        <input class="search-query" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('ngsite')}">
        <button type="submit" class="search-submit">{'Search'|i18n('ngsite')}</button>
    </form>
</div>
