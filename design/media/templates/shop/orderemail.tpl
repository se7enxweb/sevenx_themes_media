{* Branded HTML order confirmation, rendered through the shared email layout
   (design:emails/user/layout.tpl), matching the contact-form and user-account
   emails. Overrides the plain-text design/standard/templates/shop/orderemail.tpl.

   Variables come from the shop order-email flow: $order with order_nr,
   link_url, account_information, product_items, order_items and the totals. *}

{set-block scope=root variable=subject}{"Order"|i18n("design/sevenx_themes_media/orderemail")} #{$order.order_nr}{/set-block}
{set-block scope=root variable=content_type}text/html{/set-block}
{set-block scope=root variable=email_title}<a href="{concat('https://', ezini('SiteSettings','SiteURL'), '/')}" style="color:#212529; text-decoration:none;">{ezini('SiteSettings','SiteName')}</a>{/set-block}

{set-block scope=root variable=email_footer}
<p style="margin:0 0 8px 0;">{'Thank you for your order at'|i18n('design/sevenx_themes_media/orderemail')} <a href="{concat('https://', ezini('SiteSettings','SiteURL'), '/')}" style="color:#777777; text-decoration:underline;">{ezini('SiteSettings','SiteName')}</a></p>
<p style="margin:0;">{'Order'|i18n('design/sevenx_themes_media/orderemail')} #{$order.order_nr} &middot; {'Order ID'|i18n('design/sevenx_themes_media/orderemail')}: {$order.id} &middot; {$order.created|l10n('shortdatetime')}</p>
{/set-block}

{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
     $locale = false()
     $symbol = false()
     $account = $order.account_information}
{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}

{set-block scope=root variable=email_content}
<p style="margin:0 0 16px 0; font-size:18px; font-weight:600;">{'Order'|i18n('design/sevenx_themes_media/orderemail')} #{$order.order_nr}</p>
<p style="margin:0 0 24px 0;">{'Thank you, your order has been received. A summary is below.'|i18n('design/sevenx_themes_media/orderemail')}</p>

{if $order.link_url|begins_with( '/shop/orderreceipt/' )}
<table role="presentation" border="0" cellpadding="0" cellspacing="0" style="margin:0 0 24px 0;">
    <tr><td style="border-radius:6px; background-color:#212529;">
        <a href="{$order.link_url|ezurl( 'no', 'full' )}" style="display:inline-block; padding:12px 22px; font-size:15px; font-weight:600; color:#ffffff; text-decoration:none; border-radius:6px;">{'View your receipt'|i18n('design/sevenx_themes_media/orderemail')}</a>
    </td></tr>
</table>
<p style="margin:-14px 0 24px 0; font-size:13px; color:#777777;">{'Sign in to view it; the address does not expire.'|i18n('design/sevenx_themes_media/orderemail')}</p>
{/if}

<table role="presentation" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:0 0 8px 0;">
    <tr>
        <td style="padding:0 0 8px 0; border-bottom:2px solid #eeeeee; color:#777777; font-size:13px; text-transform:uppercase; letter-spacing:0.03em;">{'Item'|i18n('design/sevenx_themes_media/orderemail')}</td>
        <td style="padding:0 0 8px 0; border-bottom:2px solid #eeeeee; color:#777777; font-size:13px; text-transform:uppercase; letter-spacing:0.03em; text-align:right; white-space:nowrap;">{'Total'|i18n('design/sevenx_themes_media/orderemail')}</td>
    </tr>
    {section name=ProductItem loop=$order.product_items show=$order.product_items}
    <tr>
        <td style="padding:12px 12px 12px 0; vertical-align:top; border-bottom:1px solid #f0f0f0;">
            <span style="font-weight:600;">{$ProductItem:item.item_count}&times; {$ProductItem:item.object_name|wash}</span><br />
            <span style="font-size:13px; color:#777777;">{$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )} {'each'|i18n('design/sevenx_themes_media/orderemail')}</span>
        </td>
        <td style="padding:12px 0; vertical-align:top; border-bottom:1px solid #f0f0f0; text-align:right; white-space:nowrap; font-weight:600;">{$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
    </tr>
    {/section}
    <tr>
        <td style="padding:12px 12px 4px 0; text-align:right; color:#777777;">{'Subtotal'|i18n('design/sevenx_themes_media/orderemail')}</td>
        <td style="padding:12px 0 4px 0; text-align:right; white-space:nowrap;">{$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
    </tr>
    {section name=OrderItem loop=$order.order_items show=$order.order_items}
    <tr>
        <td style="padding:2px 12px 2px 0; text-align:right; color:#777777;">{$OrderItem:item.description|wash}</td>
        <td style="padding:2px 0; text-align:right; white-space:nowrap;">{$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
    </tr>
    {/section}
    <tr>
        <td style="padding:12px 12px 0 0; text-align:right; font-size:18px; font-weight:700; border-top:2px solid #eeeeee;">{'Order total'|i18n('design/sevenx_themes_media/orderemail')}</td>
        <td style="padding:12px 0 0 0; text-align:right; white-space:nowrap; font-size:18px; font-weight:700; border-top:2px solid #eeeeee;">{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
    </tr>
</table>

<table role="presentation" border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:28px 0 0 0;">
    <tr>
        <td style="vertical-align:top; padding:0 16px 0 0; width:50%;">
            <p style="margin:0 0 8px 0; font-size:13px; text-transform:uppercase; letter-spacing:0.03em; color:#777777;">{'Customer'|i18n('design/sevenx_themes_media/orderemail')}</p>
            <p style="margin:0; line-height:1.6;">
                {$account.first_name|wash} {$account.last_name|wash}<br />
                <a href="mailto:{$account.email|wash}" style="color:#212529; text-decoration:underline;">{$account.email|wash}</a>
                {if and( is_set( $account.phone ), $account.phone )}<br />{$account.phone|wash}{/if}
            </p>
        </td>
        <td style="vertical-align:top; padding:0; width:50%;">
            <p style="margin:0 0 8px 0; font-size:13px; text-transform:uppercase; letter-spacing:0.03em; color:#777777;">{'Shipping address'|i18n('design/sevenx_themes_media/orderemail')}</p>
            <p style="margin:0; line-height:1.6;">
                {if $account.street1}{$account.street1|wash}<br />{/if}
                {if $account.street2}{$account.street2|wash}<br />{/if}
                {$account.zip|wash} {if and( is_set( $account.city ), $account.city )}{$account.city|wash}{else}{$account.place|wash}{/if}<br />
                {if $account.state}{$account.state|wash}<br />{/if}
                {$account.country|wash}
            </p>
        </td>
    </tr>
</table>

{if $account.comment}
<p style="margin:24px 0 4px 0; font-size:13px; text-transform:uppercase; letter-spacing:0.03em; color:#777777;">{'Comment'|i18n('design/sevenx_themes_media/orderemail')}</p>
<p style="margin:0; line-height:1.6;">{$account.comment|wash|nl2br}</p>
{/if}
{/set-block}

{undef $currency $locale $symbol $account}

{include uri='design:emails/user/layout.tpl'}
