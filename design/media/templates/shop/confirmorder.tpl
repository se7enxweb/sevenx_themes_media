{* Checkout step 3, styled to match shop/userregister.tpl and user/register.tpl
   in this design: full-page-header + full-form-content + form-group/btn.

   The i18n contexts are kept as design/ezwebin/shop/confirmorder so the
   existing translations still resolve. The two tables are wrapped in a
   scrolling container so they do not force the page sideways on a phone. *}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{"Confirm order"|i18n("design/ezwebin/shop/confirmorder")}</h1>
        <ol class="checkout-steps">
            <li>1. {"Shopping basket"|i18n("design/ezwebin/shop/confirmorder")}</li>
            <li>2. {"Account information"|i18n("design/ezwebin/shop/confirmorder")}</li>
            <li class="selected active">3. {"Confirm order"|i18n("design/ezwebin/shop/confirmorder")}</li>
        </ol>
    </div>
</header>

<div class="full-form-content shop-checkout">
    <div class="container">

        <form method="post" action={"/shop/confirmorder/"|ezurl} name="ConfirmOrder" class="embed-form">

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

            <h2 class="form-section-title">{"Product items"|i18n("design/ezwebin/shop/confirmorder")}</h2>

            <div class="shop-table-wrap">
                <table class="shop-table">
                    <tr>
                        <th>{"Count"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"VAT"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"Price inc. VAT"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"Discount"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"Total price ex. VAT"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"Total price inc. VAT"|i18n("design/ezwebin/shop/confirmorder")}</th>
                    </tr>
                    {section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
                        <tr class="bglight">
                            <td colspan="6">
                                <input type="hidden" name="ProductItemIDList[]" value="{$ProductItem:item.id}" />
                                <a href={concat("/content/view/full/",$ProductItem:item.node_id,"/")|ezurl}>{$ProductItem:item.object_name|wash}</a>
                            </td>
                        </tr>
                        <tr class="bgdark">
                            <td>{$ProductItem:item.item_count}</td>
                            <td>{$ProductItem:item.vat_value} %</td>
                            <td>{$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$ProductItem:item.discount_percent}%</td>
                            <td>{$ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                        </tr>
                        {section show=$ProductItem:item.item_object.option_list}
                            <tr>
                                <td colspan="6" style="padding:0;">
                                    <table class="shop-options-table" style="width:100%;">
                                        <tr>
                                            <td colspan="3">{"Selected options"|i18n("design/ezwebin/shop/confirmorder")}</td>
                                        </tr>
                                        {section name=Options loop=$ProductItem:item.item_object.option_list}
                                            <tr>
                                                <td style="width:33%;">{$ProductItem:Options:item.name|wash}</td>
                                                <td style="width:33%;">{$ProductItem:Options:item.value|wash}</td>
                                                <td style="width:33%;">{$ProductItem:Options:item.price|l10n( 'currency', $locale, $symbol )}</td>
                                            </tr>
                                        {/section}
                                    </table>
                                </td>
                            </tr>
                        {/section}
                    {/section}
                </table>
            </div>

            <h2 class="form-section-title">{"Order summary"|i18n("design/ezwebin/shop/confirmorder")}</h2>

            <div class="shop-table-wrap">
                <table class="shop-table">
                    <tr>
                        <th>{"Summary"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"Total ex. VAT"|i18n("design/ezwebin/shop/confirmorder")}</th>
                        <th>{"Total inc. VAT"|i18n("design/ezwebin/shop/confirmorder")}</th>
                    </tr>
                    <tr class="bglight">
                        <td>{"Subtotal of items"|i18n("design/ezwebin/shop/confirmorder")}:</td>
                        <td>{$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                        <td>{$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                    </tr>
                    {section name=OrderItem loop=$order.order_items show=$order.order_items sequence=array(bgdark,bglight)}
                        <tr class="{$OrderItem:sequence}">
                            <td>{$OrderItem:item.description|wash}:</td>
                            <td>{$OrderItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                        </tr>
                    {/section}
                    <tr class="bgdark">
                        <td><strong>{"Order total"|i18n("design/ezwebin/shop/confirmorder")}:</strong></td>
                        <td><strong>{$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                        <td><strong>{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                    </tr>
                </table>
            </div>

            <div class="buttonblock clearfix">
                <input class="btn btn-primary" type="submit" id="ConfirmOrderButton" name="ConfirmOrderButton" value="{'Confirm'|i18n('design/ezwebin/shop/confirmorder')}" />
                <input class="btn btn-secondary" type="submit" id="CancelButton" name="CancelButton" value="{'Cancel'|i18n('design/ezwebin/shop/confirmorder')}" />
            </div>

            {undef $currency $locale $symbol}
        </form>
    </div>
</div>

{literal}
<script type="text/javascript">
    function disableConfirmOrderButtons()
    {
        var confirmButton = document.getElementById( 'ConfirmOrderButton' );
        var cancelButton = document.getElementById( 'CancelButton' );
        if ( confirmButton ) confirmButton.disabled = true;
        if ( cancelButton ) cancelButton.disabled = true;
    }
    var confirmOrderForm = document.forms['ConfirmOrder'];
    if ( confirmOrderForm )
    {
        // Disabled on the next tick, never inside the submit handler: a submit
        // button disabled while the event is still running is left out of the
        // posted data, so the module would never see ConfirmOrderButton.
        confirmOrderForm.addEventListener( 'submit', function()
        {
            window.setTimeout( disableConfirmOrderButtons, 0 );
        } );
    }
</script>
{/literal}
