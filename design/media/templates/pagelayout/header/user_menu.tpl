{* The header's user button and its menu (menu.ini [HeaderUserMenu]), beside the search button, on phones and
   desktops alike.

   A disclosure, the pattern of the administration's user menu: a button with aria-expanded, aria-controls and a
   name, and a panel of links that javascript/exp-header-menu.js opens. Escape closes it and gives the focus back to
   the button, the arrow keys, Home and End move between the links, a click outside closes it, and opening it closes
   the header search (and the search closes it): one header menu at a time. Without the script the panel stays
   hidden and the page works as before.

   Signed out: Sign in, Register (ShowRegister, and only while the anonymous user may register), the basket
   (ShowBasket), the sitemap and the tag cloud. Signed in: the user's name, My profile, Edit profile (when the user
   may edit the own account), Change password, the basket, the administration (AdminSiteAccessList: the first one
   the user may log in to), the sitemap, the tag cloud and Sign out. Every entry is checked against the user's
   policies with fetch( 'user', 'can_open' ), so the menu never offers a page that answers "access denied".

   Every link carries data-exp-um, the name of the entry, for the script and the browser checks. *}
{if ezini( 'HeaderUserMenu', 'UserMenu', 'menu.ini' )|ne( 'disabled' )}
{def $hu_user = fetch( 'user', 'current_user' )
     $hu_root = ezini( 'NodeSettings', 'RootNode', 'content.ini' )
     $hu_signed_in = $hu_user.is_logged_in
     $hu_label = 'User menu'|i18n( 'design/media/pagelayout' )
     $hu_basket = and( ezini( 'HeaderUserMenu', 'ShowBasket', 'menu.ini' )|ne( 'disabled' ), fetch( 'user', 'can_open', hash( 'uri', 'shop/basket' ) ) )
     $hu_admin_url = ''}
{if $hu_signed_in}
    {set $hu_label = 'User menu (%name)'|i18n( 'design/media/pagelayout',, hash( '%name', $hu_user.contentobject.name ) )}
    {foreach ezini( 'HeaderUserMenu', 'AdminSiteAccessList', 'menu.ini' ) as $hu_sa}
        {if and( $hu_admin_url|eq( '' ), $hu_sa|ne( '' ), exp_can_login_to_siteaccess( $hu_sa ) )}
            {set $hu_admin_url = siteaccess_href( concat( '/', $hu_sa, '/' ) )}
            {if $hu_admin_url|eq( '' )}{set $hu_admin_url = siteaccess_url( $hu_sa )}{/if}
        {/if}
    {/foreach}
{/if}
<div class="header-user" id="header-user">
    <button type="button" class="header-user-toggle" id="header-user-toggle" aria-expanded="false" aria-controls="header-user-menu" title="{$hu_label|wash}">
        <i class="icon-user" aria-hidden="true"></i>
        <span class="sr-only">{$hu_label|wash}</span>
    </button>
    <div class="header-user-menu" id="header-user-menu" hidden>
    {if $hu_signed_in}
        <p class="header-user-name">{$hu_user.contentobject.name|wash}</p>
        <ul class="header-user-links">
            {if fetch( 'user', 'can_open', hash( 'uri', 'user/edit' ) )}
            <li><a href={'/user/edit'|ezurl} data-exp-um="profile">{'My profile'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $hu_user.contentobject.can_edit}
            <li><a href={concat( '/content/edit/', $hu_user.contentobject_id, '/' )|ezurl} data-exp-um="edit">{'Edit profile'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if fetch( 'user', 'can_open', hash( 'uri', 'user/password' ) )}
            <li><a href={'/user/password'|ezurl} data-exp-um="password">{'Change password'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $hu_basket}
            <li><a href={'/shop/basket'|ezurl} data-exp-um="basket">{'Cart'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $hu_admin_url|ne( '' )}
            <li><a href="{$hu_admin_url|wash}" data-exp-um="admin">{'Administration'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
        </ul>
    {else}
        <ul class="header-user-links">
            <li><a href={'/user/login'|ezurl} data-exp-um="login">{'Sign in'|i18n( 'design/media/pagelayout' )}</a></li>
            {if and( ezini( 'HeaderUserMenu', 'ShowRegister', 'menu.ini' )|ne( 'disabled' ), fetch( 'user', 'can_open', hash( 'uri', 'user/register' ) ) )}
            <li><a href={'/user/register'|ezurl} data-exp-um="register">{'Register'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $hu_basket}
            <li><a href={'/shop/basket'|ezurl} data-exp-um="basket">{'Cart'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
        </ul>
    {/if}
    {if or( ezini( 'HeaderUserMenu', 'ShowSitemap', 'menu.ini' )|eq( 'enabled' ), ezini( 'HeaderUserMenu', 'ShowTagCloud', 'menu.ini' )|eq( 'enabled' ) )}
        <ul class="header-user-links header-user-site">
            {if ezini( 'HeaderUserMenu', 'ShowSitemap', 'menu.ini' )|eq( 'enabled' )}
            <li><a href={concat( '/content/view/sitemap/', $hu_root )|ezurl} data-exp-um="sitemap">{'Sitemap'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if ezini( 'HeaderUserMenu', 'ShowTagCloud', 'menu.ini' )|eq( 'enabled' )}
            <li><a href={concat( '/content/view/tagcloud/', $hu_root )|ezurl} data-exp-um="tagcloud">{'Tag cloud'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
        </ul>
    {/if}
    {if $hu_signed_in}
        <ul class="header-user-links header-user-session">
            <li><a href={'/user/logout'|ezurl} data-exp-um="logout">{'Sign out'|i18n( 'design/media/pagelayout' )}</a></li>
        </ul>
    {/if}
    </div>
</div>
{undef $hu_user $hu_root $hu_signed_in $hu_label $hu_basket $hu_admin_url}
{/if}
