{* A customer's orders (shop/customerorderview/<user>/<e-mail>) in the media design, like the order view: the
   customer, the orders with their totals and a link to each order, and what was bought. Needs
   shop/administrate (the kernel view). Strings of the ezwebin design. *}
{def $currency = false()
     $locale = false()
     $symbol = false()}
<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Order list'|i18n( 'design/ezwebin/shop/customerorderview' )}</h1>
    </div>
</header>

<div class="full-form-content shop-checkout acc-content">
    <div class="container acc shop-customerorderview">
{if $order_list}
        <h2 class="form-section-title">{'Customer information'|i18n( 'design/ezwebin/shop/customerorderview' )}</h2>
        <div class="form-group">
            {shop_account_view_gui view=html order=$order_list[0]}
        </div>

        <h2 class="form-section-title">{'Order list'|i18n( 'design/ezwebin/shop/customerorderview' )}</h2>
        <div class="shop-table-wrap">
            <table class="shop-table">
                <tr>
                    <th>{'ID'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th>{'Date'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th>{'Total ex. VAT'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th>{'Total inc. VAT'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th><span class="mp-sr">{'view'|i18n( 'design/ezwebin/shop/customerorderview' )}</span></th>
                </tr>
    {foreach $order_list as $order sequence array( 'bglight', 'bgdark' ) as $style}
        {set $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )}
        {if $currency}{set $locale = $currency.locale $symbol = $currency.symbol}{else}{set $locale = false() $symbol = false()}{/if}
                <tr class="{$style}">
                    <td>{$order.order_nr}</td>
                    <td>{$order.created|l10n( shortdatetime )}</td>
                    <td>{$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                    <td><strong>{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                    <td><a href={concat( '/shop/orderview/', $order.id, '/' )|ezurl}>{'view'|i18n( 'design/ezwebin/shop/customerorderview' )}</a></td>
                </tr>
    {/foreach}
            </table>
        </div>
{else}
        <div class="full-form-response">
            <h2>{'The order list is empty'|i18n( 'design/ezwebin/shop/orderlist' )}</h2>
        </div>
{/if}

{if $product_list}
        <h2 class="form-section-title">{'Purchase list'|i18n( 'design/ezwebin/shop/customerorderview' )}</h2>
        <div class="shop-table-wrap">
            <table class="shop-table">
                <tr>
                    <th>{'Product'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th>{'Amount'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th>{'Total ex. VAT'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                    <th>{'Total inc. VAT'|i18n( 'design/ezwebin/shop/customerorderview' )}</th>
                </tr>
    {foreach $product_list as $product sequence array( 'bglight', 'bgdark' ) as $style}
                <tr class="{$style}">
                    <td>{content_view_gui view=text_linked content_object=$product.product}</td>
                    <td>{foreach $product.product_info as $info}{$info.sum_count}{delimiter}<br />{/delimiter}{/foreach}</td>
                    <td>{foreach $product.product_info as $currency_code => $info}{if $currency_code}{set $currency = fetch( 'shop', 'currency', hash( 'code', $currency_code ) )}{else}{set $currency = false()}{/if}{if $currency}{set $locale = $currency.locale $symbol = $currency.symbol}{else}{set $locale = false() $symbol = false()}{/if}{$info.sum_ex_vat|l10n( 'currency', $locale, $symbol )}{delimiter}<br />{/delimiter}{/foreach}</td>
                    <td>{foreach $product.product_info as $currency_code => $info}{if $currency_code}{set $currency = fetch( 'shop', 'currency', hash( 'code', $currency_code ) )}{else}{set $currency = false()}{/if}{if $currency}{set $locale = $currency.locale $symbol = $currency.symbol}{else}{set $locale = false() $symbol = false()}{/if}{$info.sum_inc_vat|l10n( 'currency', $locale, $symbol )}{delimiter}<br />{/delimiter}{/foreach}</td>
                </tr>
    {/foreach}
            </table>
        </div>
{/if}
    </div>
</div>
{undef $currency $locale $symbol}
