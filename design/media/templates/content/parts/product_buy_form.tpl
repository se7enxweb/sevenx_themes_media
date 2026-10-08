{* The buy form of a product: price, options, quantity and the basket button.

   Shared by the product full view (node/view/full/full_product.tpl) and the
   product card of the "Product highlight" layouts block
   (content/views/product_card/product.tpl), so a product is put in the basket
   the same way wherever it is offered.

   The form is the one the shop module expects. content/action reads
   ActionAddToBasket and hands off to shop/basket, which reads ContentObjectID,
   an optional Quantity (defaults to 1) and eZOption[] - so the multioption
   attribute has to render inside this form, and the hidden fields have to keep
   their names. ezformtoken adds its token to the form on the way out, as it
   does for every post form of the site.

   Parameters:
     node         the product's tree node (required)
     show_options whether the additional options are offered (default true)
     show_wish    whether logged in users get "Add to wish list" (default true)
     field_id     the id of the quantity field, unique on the page
                  (default 'Quantity'; the card passes one per node)

   i18n: 'Add to basket' and 'Add to wish list' stay in
   design/ezwebin/full/product, which already carries their German
   translations. *}

{def $pbf_map      = $node.object.data_map
     $pbf_price    = false()
     $pbf_field_id = first_set( $field_id, 'Quantity' )}
{if and( is_set( $pbf_map.price ), $pbf_map.price.has_content )}
    {set $pbf_price = $pbf_map.price.content}
{/if}

<form method="post" action={'content/action'|ezurl} class="product-buy-form">

    {if $pbf_price}
    <div class="product-price">
        {if $pbf_price.has_discount}
            <p class="product-price-was"><s>{$pbf_price.inc_vat_price|l10n('currency')}</s></p>
            <p class="product-price-now">{$pbf_price.discount_price_inc_vat|l10n('currency')}</p>
            <p class="product-price-save">{'Save %percent'|i18n( 'ngsite',, hash( '%percent', concat( $pbf_price.discount_percent, '%' ) ) )}</p>
        {else}
            <p class="product-price-now">{$pbf_price.inc_vat_price|l10n('currency')}</p>
        {/if}
        {* The headline figure is always inc_vat_price, whichever way the
           price is stored, so the note is only about whether VAT applies
           at all. With no VAT type set vat_percent is 0 and inc == ex,
           and a note either way would be noise. *}
        {if $pbf_price.vat_percent|gt(0)}
        <p class="product-price-vat">
            {'Includes %percent% VAT'|i18n( 'ngsite',, hash( '%percent', $pbf_price.vat_percent ) )}
        </p>
        {/if}
    </div>
    {/if}

    {if and( first_set( $show_options, true() ), is_set( $pbf_map.additional_options ), $pbf_map.additional_options.has_content )}
    <div class="product-options">
        {attribute_view_gui attribute=$pbf_map.additional_options}
    </div>
    {/if}

    <div class="product-qty">
        <label for="{$pbf_field_id|wash}">{'Quantity'|i18n('ngsite')}</label>
        <input id="{$pbf_field_id|wash}" class="form-control" type="number" name="Quantity"
               value="1" min="1" step="1" inputmode="numeric" />
    </div>

    <div class="product-actions">
        <input type="submit" class="btn btn-primary" name="ActionAddToBasket"
               value="{'Add to basket'|i18n('design/ezwebin/full/product')}" />
        {if and( first_set( $show_wish, true() ), fetch( 'user', 'current_user' ).is_logged_in )}
        <input type="submit" class="btn btn-secondary" name="ActionAddToWishList"
               value="{'Add to wish list'|i18n('design/ezwebin/full/product')}" />
        {/if}
    </div>

    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
    <input type="hidden" name="ViewMode" value="full" />
</form>

{undef $pbf_map $pbf_price $pbf_field_id}
