{* The shop basket, styled to match the rest of the checkout in this design:
   full-page-header + full-form-content, form-control inputs and btn buttons.

   The form action follows the view name the module resolved from shop.ini
   [BasketSettings] BasketViewName - basket, cart, or any other name
   configured. basket.php sets basket_view_name; the fallback covers a design
   rendering this template outside the module.

   Update and Remove are rendered once below the table rather than repeated in
   every item row. They are form-level actions - Update stores every quantity
   box, Remove deletes whatever is ticked - so one of each is both correct and
   far less cluttered than a pair per line.

   i18n contexts stay as design/ezwebin/shop/basket so existing translations
   keep resolving. *}

{def $basket_page_name = cond( is_set( $basket_view_name ), $basket_view_name, 'basket' )}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{if $basket_page_name|eq('cart')}{"Cart"|i18n("design/ezwebin/shop/basket")}{else}{"Basket"|i18n("design/ezwebin/shop/basket")}{/if}</h1>
        <ol class="checkout-steps">
            <li class="selected active">1. {"Shopping basket"|i18n("design/ezwebin/shop/basket")}</li>
            <li>2. {"Account information"|i18n("design/ezwebin/shop/basket")}</li>
            <li>3. {"Confirm order"|i18n("design/ezwebin/shop/basket")}</li>
        </ol>
    </div>
</header>

<div class="full-form-content shop-checkout">
    <div class="container">

        {section show=$removed_items}
            <div class="alert alert-warning">
                <h2>{"The following items were removed from your basket because the products were changed."|i18n("design/ezwebin/shop/basket",,)}</h2>
                <ul>
                    {section name=RemovedItem loop=$removed_items}
                        <li>{$:item.name|wash}</li>
                    {/section}
                </ul>
            </div>
        {/section}

        {if not( $vat_is_known )}
            <div class="alert alert-warning">
                <h2>{'VAT is unknown'|i18n( 'design/ezwebin/shop/basket' )}</h2>
                <p>
                    {'VAT percentage is not yet known for some of the items being purchased.'|i18n( 'design/ezwebin/shop/basket' )}
                    {'This probably means that some information about you is not yet available and will be obtained during checkout.'|i18n( 'design/ezwebin/shop/basket' )}
                </p>
            </div>
        {/if}

        {section show=$error}
            {section show=$error|eq(1)}
                <div class="alert alert-danger">
                    <h2>{"Attempted to add object without price to basket."|i18n("design/ezwebin/shop/basket",,)}</h2>
                </div>
            {/section}
            {section show=eq($error, "aborted")}
                <div class="alert alert-danger">
                    <h2>{"Your payment was aborted."|i18n("design/ezwebin/shop/basket",,)}</h2>
                </div>
            {/section}
        {/section}

        <form method="post" name="Basket" class="embed-form" action={concat('/shop/',$basket_page_name,'/')|ezurl}>

            {def $currency = fetch( 'shop', 'currency', hash( 'code', $basket.productcollection.currency_code ) )
                 $locale = false()
                 $symbol = false()}

            {if $currency}
                {set locale = $currency.locale
                     symbol = $currency.symbol}
            {/if}

            {section name=Basket show=$basket.items}

                <div class="shop-table-wrap">
                    <table class="shop-table">
                        <tr>
                            <th>{"Product"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Count"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"VAT"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Price inc. VAT"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Discount"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Total price ex. VAT"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Total price inc. VAT"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Remove"|i18n("design/ezwebin/shop/basket")}</th>
                        </tr>

                        {section name=ProductItem loop=$basket.items sequence=array(bgdark, bglight)}
                            <tr class="{$Basket:ProductItem:sequence}">
                                <td>
                                    <input type="hidden" name="ProductItemIDList[]" value="{$Basket:ProductItem:item.id}" />
                                    <a href={concat("/content/view/full/",$Basket:ProductItem:item.node_id,"/")|ezurl}>{$Basket:ProductItem:item.object_name|wash}</a>
                                </td>
                                <td>
                                    <input class="form-control shop-qty" type="text" name="ProductItemCountList[]" value="{$Basket:ProductItem:item.item_count}" size="5" />
                                </td>
                                <td>
                                    {if ne( $Basket:ProductItem:item.vat_value, -1 )}
                                        {$Basket:ProductItem:item.vat_value} %
                                    {else}
                                        {'Unknown'|i18n( 'design/ezwebin/shop/basket' )}
                                    {/if}
                                </td>
                                <td>{$Basket:ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                                <td>{$Basket:ProductItem:item.discount_percent}%</td>
                                <td>{$Basket:ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                                <td>{$Basket:ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                                <td>
                                    <input type="checkbox" name="RemoveProductItemDeleteList[]" value="{$Basket:ProductItem:item.id}" />
                                </td>
                            </tr>

                            {section show=$Basket:ProductItem:item.item_object.option_list}
                                <tr>
                                    <td colspan="8">
                                        <table class="shop-options-table" style="width:100%;">
                                            <tr>
                                                <td colspan="3">{"Selected options"|i18n("design/ezwebin/shop/basket")}</td>
                                            </tr>
                                            {section name=Options loop=$Basket:ProductItem:item.item_object.option_list sequence=array(bglight, bgdark)}
                                                <tr>
                                                    <td style="width:33%;">{$Basket:ProductItem:Options:item.name|wash}</td>
                                                    <td style="width:33%;">{$Basket:ProductItem:Options:item.value|wash}</td>
                                                    <td style="width:33%;">{$Basket:ProductItem:Options:item.price|l10n( 'currency', $locale, $symbol )}</td>
                                                </tr>
                                            {/section}
                                        </table>
                                    </td>
                                </tr>
                            {/section}
                        {/section}
                    </table>
                </div>

                <div class="basket-actions buttonblock clearfix shop-actions">
                    <input class="btn btn-secondary" type="submit" name="StoreChangesButton" value="{'Update'|i18n('design/ezwebin/shop/basket')}" />
                    <input class="btn btn-secondary" type="submit" name="RemoveProductItemButton" value="{'Remove'|i18n('design/ezwebin/shop/basket')}" />
                </div>

                <h2 class="form-section-title">{"Basket summary"|i18n("design/ezwebin/shop/basket")}</h2>

                <div class="shop-table-wrap">
                    <table class="shop-table">
                        <tr>
                            <th>{"Summary"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Total price ex. VAT"|i18n("design/ezwebin/shop/basket")}</th>
                            <th>{"Total price inc. VAT"|i18n("design/ezwebin/shop/basket")}</th>
                        </tr>
                        <tr class="bglight">
                            <td>{"Subtotal of items"|i18n("design/ezwebin/shop/basket")}:</td>
                            <td>{$basket.total_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
                            <td>{$basket.total_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
                        </tr>

                        {if is_set( $shipping_info )}
                            <tr class="bgdark">
                                <td>
                                    <a href={$shipping_info.management_link|ezurl}>{'Shipping'|i18n( 'design/ezwebin/shop/basket' )}{if $shipping_info.description} ({$shipping_info.description}){/if}</a>:
                                </td>
                                <td>{$shipping_info.cost|l10n( 'currency', $locale, $symbol )}</td>
                                <td>{$shipping_info.cost|l10n( 'currency', $locale, $symbol )}</td>
                            </tr>
                            <tr class="bglight">
                                <td><strong>{'Order total'|i18n( 'design/ezwebin/shop/basket' )}:</strong></td>
                                <td><strong>{$total_inc_shipping_ex_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                                <td><strong>{$total_inc_shipping_inc_vat|l10n( 'currency', $locale, $symbol )}</strong></td>
                            </tr>
                        {/if}
                    </table>
                </div>

                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" id="CheckoutButton" name="CheckoutButton" value="{'Checkout'|i18n('design/ezwebin/shop/basket')}" />
                    <input class="btn btn-secondary" type="submit" name="ContinueShoppingButton" value="{'Continue shopping'|i18n('design/ezwebin/shop/basket')}" />
                </div>

            {section-else}

                <div class="alert alert-info">
                    <h2>{"You have no products in your basket."|i18n("design/ezwebin/shop/basket")}</h2>
                </div>

                <div class="buttonblock clearfix">
                    <input class="btn btn-secondary" type="submit" name="ContinueShoppingButton" value="{'Continue shopping'|i18n('design/ezwebin/shop/basket')}" />
                </div>

            {/section}

            {undef $currency $locale $symbol}
        </form>
    </div>
</div>

{undef $basket_page_name}
