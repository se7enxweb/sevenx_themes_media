{* The wish list (shop/wishlist) in the media design, like the basket and the order pages: the design's page
   header, the products in the shop table with their count and a box to remove them, the selected options, and
   the buttons. The form, ProductItemIDList[], ProductItemCountList[], RemoveProductItemDeleteList[],
   StoreChangesButton and RemoveProductItemButton are those of the kernel view; strings of the ezwebin design. *}
<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Wish list'|i18n( 'design/ezwebin/shop/wishlist' )}</h1>
    </div>
</header>

<div class="full-form-content shop-checkout acc-content">
    <div class="container acc shop-wishlist">
        <form method="post" action={'/shop/wishlist/'|ezurl}>
{if $wish_list.items|count}
            <div class="shop-table-wrap">
                <table class="shop-table">
                    <tr>
                        <th>{'Product'|i18n( 'design/ezwebin/shop/wishlist' )}</th>
                        <th>{'Count'|i18n( 'design/ezwebin/shop/wishlist' )}</th>
                        <th><span class="mp-sr">{'Remove items'|i18n( 'design/ezwebin/shop/wishlist' )}</span></th>
                    </tr>
    {foreach $wish_list.items as $item sequence array( 'bglight', 'bgdark' ) as $style}
                    <tr class="{$style}">
                        <td>
                            <input type="hidden" name="ProductItemIDList[]" value="{$item.id}" />
                            <a href={concat( '/content/view/full/', $item.node_id, '/' )|ezurl}>{$item.object_name|wash}</a>
        {if $item.item_object.option_list}
                            <ul class="shop-wishlist-options" aria-label="{'Selected options'|i18n( 'design/ezwebin/shop/wishlist' )|wash}">
            {foreach $item.item_object.option_list as $option}
                                <li>{$option.name|wash}: {$option.value|wash}{if $option.price|ne( 0 )} ({$option.price|l10n( currency )}){/if}</li>
            {/foreach}
                            </ul>
        {/if}
                        </td>
                        <td><input class="form-control shop-qty" type="text" name="ProductItemCountList[]" value="{$item.item_count}" size="5" aria-label="{'Count'|i18n( 'design/ezwebin/shop/wishlist' )|wash}" /></td>
                        <td><input type="checkbox" name="RemoveProductItemDeleteList[]" value="{$item.id}" aria-label="{'Remove items'|i18n( 'design/ezwebin/shop/wishlist' )|wash}: {$item.object_name|wash}" /></td>
                    </tr>
    {/foreach}
                </table>
            </div>
            <div class="buttonblock acc-actions">
                <input class="btn btn-primary" type="submit" name="StoreChangesButton" value="{'Store'|i18n( 'design/ezwebin/shop/wishlist' )}" />
                <input class="btn btn-secondary" type="submit" name="RemoveProductItemButton" value="{'Remove items'|i18n( 'design/ezwebin/shop/wishlist' )}" />
                <a class="btn btn-outline" href={'shop/basket'|ezurl}>{'Shopping basket'|i18n( 'design/ezwebin/shop/basket' )}</a>
            </div>
{else}
            <div class="full-form-response">
                <h2>{'Empty wish list'|i18n( 'design/ezwebin/shop/wishlist' )}</h2>
            </div>
            <div class="acc-actions">
                <a class="btn btn-secondary" href={'shop/basket'|ezurl}>{'Shopping basket'|i18n( 'design/ezwebin/shop/basket' )}</a>
            </div>
{/if}
        </form>
    </div>
</div>
