<header class="site-header">
    <div class="header-content container">
        {include uri='design:content/parts/site_logo.tpl'}

        <button class="mainnav-toggle" aria-label="{'Menu'|i18n('design/media/pagelayout')}" aria-controls="mainNavigation" aria-expanded="false">
            <span class="hamburger" aria-hidden="true"></span>
        </button>

        {include uri='design:pagelayout/header/main_menu.tpl'}
        {include uri='design:pagelayout/header/color_mode.tpl'}
        {include uri='design:pagelayout/header/search_box.tpl'}
        {* inside the pagelayout's cached layout, the user menu is filled in after the cache (see pagelayout.tpl) *}
        {if and( is_set( $#exp_dynamic_parts ), eq( $#exp_dynamic_parts, '1' ) )}<!--exp-dynamic:user_menu-->{else}{include uri='design:pagelayout/header/user_menu.tpl'}{/if}
        {include uri='design:pagelayout/header/language_selector.tpl'}
    </div>
</header>