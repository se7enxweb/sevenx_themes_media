{* The user profile (user/edit) in the media design: the design's page header, the e-mail preferences box, the
   account facts, the links to the user's own pages, and the buttons. The form, its action and the button
   names are those of the view (EditButton opens content/edit of the user object, ChangePasswordButton
   user/password, CancelButton goes back to the page the profile was opened from, which RedirectIfDiscarded
   carries). Strings of the ezwebin design, which this page replaces. Drawn by stylesheets/account.css. *}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'User profile'|i18n( 'design/ezwebin/user/edit' )}</h1>
    </div>
</header>

<div class="full-form-content acc-content">
    <div class="container acc">
        {include uri='design:mailpreferences/parts/account_link.tpl' context='profile'}

        <form action={concat( $module.functions.edit.uri, '/', $userID )|ezurl} method="post" name="Edit">
            <div class="acc-card">
                <dl class="acc-facts">
                    <dt>{'Username'|i18n( 'design/ezwebin/user/edit' )}</dt>
                    <dd>{$userAccount.login|wash}</dd>
                    <dt>{'Email'|i18n( 'design/ezwebin/user/edit' )}</dt>
                    <dd>{$userAccount.email|wash}</dd>
                    <dt>{'Name'|i18n( 'design/ezwebin/user/edit' )}</dt>
                    <dd>{$userAccount.contentobject.name|wash}</dd>
                </dl>
                <div class="acc-actions">
                    <input class="btn btn-primary" type="submit" name="EditButton" value="{'Edit profile'|i18n( 'design/ezwebin/user/edit' )}" />
                    <input class="btn btn-secondary" type="submit" name="ChangePasswordButton" value="{'Change password'|i18n( 'design/ezwebin/user/edit' )}" />
                    <input class="btn btn-outline" type="submit" name="CancelButton" value="{'Cancel'|i18n( 'design/standard/user' )}" />
                    <a class="btn btn-outline" href={'user/logout'|ezurl}>{'Logout'|i18n( 'design/standard/layout' )}</a>
                </div>
            </div>
            {if and( is_set( $redirect_if_discarded ), $redirect_if_discarded )}<input type="hidden" name="RedirectIfDiscarded" value="{$redirect_if_discarded|wash}" />{/if}
        </form>

        <ul class="acc-links">
            <li><a href={'mailpreferences/settings'|ezurl}>{'Open my e-mail preferences'|i18n( 'design/standard/mailpreferences' )}</a></li>
            {include uri='design:apikey/parts/account_link.tpl' style='item'}
{if fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'edit' ) )}
            <li><a href={'content/draft'|ezurl}>{'My drafts'|i18n( 'design/ezwebin/user/edit' )}</a></li>
{/if}
{if fetch( 'user', 'has_access_to', hash( 'module', 'shop', 'function', 'administrate' ) )}
            <li><a href={concat( '/shop/customerorderview/', $userID, '/', $userAccount.email )|ezurl}>{'My orders'|i18n( 'design/ezwebin/user/edit' )}</a></li>
{/if}
{if fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'pendinglist' ) )}
            <li><a href={'/content/pendinglist'|ezurl}>{'My pending items'|i18n( 'design/ezwebin/user/edit' )}</a></li>
{/if}
{if fetch( 'user', 'has_access_to', hash( 'module', 'notification', 'function', 'use' ) )}
            <li><a href={'notification/settings'|ezurl}>{'My notification settings'|i18n( 'design/ezwebin/user/edit' )}</a></li>
{/if}
{if fetch( 'user', 'has_access_to', hash( 'module', 'shop', 'function', 'buy' ) )}
    {def $acc_basket_count = 0}
    {foreach fetch( 'shop', 'basket' ).items as $acc_item}{set $acc_basket_count = sum( $acc_basket_count, $acc_item.item_count )}{/foreach}
            <li><a href={'shop/basket'|ezurl}>{'Shopping basket'|i18n( 'design/ezwebin/shop/basket' )}</a>{if $acc_basket_count|gt( 0 )} <span class="acc-count">{$acc_basket_count}</span>{/if}</li>
    {undef $acc_basket_count}
            <li><a href={'/shop/wishlist'|ezurl}>{'My wish list'|i18n( 'design/ezwebin/user/edit' )}</a></li>
{/if}
        </ul>
    </div>
</div>
