{* A placed order, styled to match the rest of the checkout in this design:
   full-page-header + full-form-content, with the three tables wrapped so they
   scroll rather than stretching the page on a narrow screen.

   i18n contexts stay as design/ezwebin/shop/orderview so existing
   translations keep resolving. There is no form here - the order is already
   placed - so this page has no buttons and no submit script. *}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Order %order_id'|i18n( 'design/ezwebin/shop/orderview',,
             hash( '%order_id', $order.order_nr ) )}</h1>
        <p class="order-status">{$order.status_name|wash}</p>
    </div>
</header>

<div class="full-form-content shop-checkout">
    <div class="container">

        <div class="form-group">
            {shop_account_view_gui view=html order=$order}
        </div>

        {def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
             $locale = false()
             $symbol = false()}

        {if $currency}
            {set locale = $currency.locale
                 symbol = $currency.symbol}
        {/if}

        <h2 class="form-section-title">{'Product items'|i18n( 'design/ezwebin/shop/orderview' )}</h2>

        <div class="shop-table-wrap">
            <table class="shop-table">
                <tr>
                    <th>{'Product'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Count'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'VAT'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Price inc. VAT'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Discount'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Total price ex. VAT'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Total price inc. VAT'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                </tr>
                {if $order.product_items|count()}
                    {foreach $order.product_items as $product_item sequence array( 'bglight', 'bgdark' ) as $style}
                        <tr class="{$style}">
                            <td><a href={concat( "/content/view/full/", $product_item.node_id )|ezurl}>{$product_item.object_name|wash}</a></td>
                            <td>{$product_item.item_count}</td>
                            <td>{$product_item.vat_value} %</td>
                            <td>{$product_item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$product_item.discount_percent}%</td>
                            <td>{$product_item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$product_item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                        </tr>
                    {/foreach}
                {/if}
            </table>
        </div>

        <h2 class="form-section-title">{'Order summary'|i18n( 'design/ezwebin/shop/orderview' )}</h2>

        <div class="shop-table-wrap">
            <table class="shop-table">
                <tr>
                    <th>{'Summary'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Total price ex. VAT'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Total price inc. VAT'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                </tr>
                <tr class="bglight">
                    <td>{'Subtotal of items'|i18n( 'design/ezwebin/shop/orderview' )}:</td>
                    <td>{$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                    <td>{$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                </tr>
                {if $order.order_items|count()}
                    {foreach $order.order_items as $order_item sequence array( 'bglight', 'bgdark' ) as $style}
                        <tr class="{$style}">
                            <td>{$order_item.description|wash}:</td>
                            <td>{$order_item.price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$order_item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                        </tr>
                    {/foreach}
                {/if}
                <tr class="bgdark">
                    <td><strong>{'Order total'|i18n( 'design/ezwebin/shop/orderview' )}</strong></td>
                    <td><strong>{$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                    <td><strong>{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                </tr>
            </table>
        </div>

        <h2 class="form-section-title">{'Order history'|i18n( 'design/ezwebin/shop/orderview' )}</h2>

        <div class="shop-table-wrap">
            <table class="shop-table">
                <tr>
                    <th>{'Date'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                    <th>{'Order status'|i18n( 'design/ezwebin/shop/orderview' )}</th>
                </tr>
                {def $order_status_history = fetch( 'shop', 'order_status_history', hash( 'order_id', $order.order_nr ) )}
                {if $order_status_history|count()}
                    {foreach $order_status_history as $history sequence array( 'bglight', 'bgdark' ) as $style}
                        <tr class="{$style}">
                            <td class="date">{$history.modified|l10n( 'shortdatetime' )}</td>
                            <td>{$history.status_name|wash}</td>
                        </tr>
                    {/foreach}
                {/if}
                {undef $order_status_history}
            </table>
        </div>

        {undef $currency $locale $symbol}
    </div>
</div>
