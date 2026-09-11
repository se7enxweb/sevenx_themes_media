{* The customer and address block shown on confirmorder and orderview.

   Three things differ from design/standard's version:

   - The labels match the fields. The shipped template labels street1 as
     "Company" and street2 as "Street", so an address entered normally came
     out as "Company: 1 Compiler Road" with an empty "Street:".
   - The address line is read from 'city', falling back to 'place' for orders
     stored before that rename. eZUserShopAccountHandler returns both.
   - Phone is shown when the handler provides it.

   Everything is guarded with is_set so a handler that does not supply a field
   (ezdefault, ezsimple) simply omits the line rather than erroring. *}

{def $account = $order.account_information}

<div class="order-account row" style="display:flex;flex-wrap:wrap;gap:2rem;">

    <div class="order-account-customer" style="flex:1 1 16rem;">
        <p><strong>{"Customer"|i18n("design/standard/shop")}</strong></p>
        <p>
            {'Name'|i18n('design/standard/shop')}: {$account.first_name|wash} {$account.last_name|wash}<br />
            {'Email'|i18n('design/standard/shop')}: {$account.email|wash}<br />
            {if and( is_set( $account.phone ), $account.phone )}
                {'Phone'|i18n('design/standard/shop')}: {$account.phone|wash}<br />
            {/if}
        </p>
    </div>

    <div class="order-account-address" style="flex:1 1 16rem;">
        <p><strong>{"Address"|i18n("design/standard/shop")}</strong></p>
        <p>
            {if $account.street1}
                {'Address line 1'|i18n('design/standard/shop')}: {$account.street1|wash}<br />
            {/if}
            {if $account.street2}
                {'Address line 2'|i18n('design/standard/shop')}: {$account.street2|wash}<br />
            {/if}
            {'Zip'|i18n('design/standard/shop')}: {$account.zip|wash}<br />
            {'City'|i18n('design/standard/shop')}: {if and( is_set( $account.city ), $account.city )}{$account.city|wash}{else}{$account.place|wash}{/if}<br />
            {if $account.state}
                {'State'|i18n('design/standard/shop')}: {$account.state|wash}<br />
            {/if}
            {'Country/region'|i18n('design/standard/shop')}: {$account.country|wash}<br />
        </p>
    </div>

</div>

{if $account.comment}
    <p><strong>{'Comment'|i18n( 'design/standard/shop' )}</strong></p>
    <p>{$account.comment|wash|nl2br}</p>
{/if}

{undef $account}
