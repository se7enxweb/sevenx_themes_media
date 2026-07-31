<header class="site-header">
    <div class="header-content container">
        <a class="site-logo" href={"/"|ezurl()} title="Fit &amp; Healthy">
            <img src="/var/site/storage/original/image/e88a83ca0b5484f343458f434a3daf11.svg" alt="">
        </a>

        <button class="mainnav-toggle" aria-label="Main navigation" aria-controls="mainNavigation" aria-expanded="false">
            <span class="hamburger" aria-hidden="true"></span>
        </button>

        <nav class="main-navigation" id="mainNavigation" role="navigation">
            <ul class="nav navbar-nav">
                <li id="menu-item-main_menu-location-id-721" class="firstli" data-location-id="721"><a href={"/fitness"|ezurl()}>Fitness</a></li>
                <li id="menu-item-main_menu-location-id-722" data-location-id="722"><a href={"/healthy-eating"|ezurl()}>Healthy eating</a></li>
                <li id="menu-item-main_menu-location-id-744" data-location-id="744"><a href={"/recipes"|ezurl()}>Recipes</a></li>
                <li id="menu-item-main_menu-location-id-749" data-location-id="749"><a href={"/running"|ezurl()}>Running</a></li>
                <li id="menu-item-main_menu-location-id-752" class="lastli" data-location-id="752"><a href={"/video"|ezurl()}>Video</a></li>
            </ul>
        </nav>

        <div class="header-search">
            <a class="searchbox-toggle" href={"/content/search"|ezurl()} title="Search" aria-expanded="false" aria-controls="site-wide-search">
                <i class="icon-search" aria-hidden="true"></i>
                <span class="sr-only">Search</span>
            </a>

            <form class="navbar-search" method="get" action={"/content/search"|ezurl()} id="site-wide-search">
                <label for="site-wide-search-field" class="sr-only">Search</label>
                <input class="search-query" type="search" name="searchText" id="site-wide-search-field" placeholder="Search">
                <button type="submit" class="search-submit">Go</button>
            </form>
        </div>
    </div>
</header>
