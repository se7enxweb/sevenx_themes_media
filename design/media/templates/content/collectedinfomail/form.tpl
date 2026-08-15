{if $object.class_identifier|eq('ng_contact_form')}
{set-block scope=root variable=subject}{"New contact form submission from %1"|i18n("design/sevenx_themes_media/collectedinfomail",,array($collection.object.name|wash))}{/set-block}
{set-block scope=root variable=content_type}text/html{/set-block}
{def $site_url = ezini('SiteSettings','SiteURL')
     $form_url = concat('https://', $site_url, $node.url_alias|ezurl('no'))}
{set-block scope=root variable=email_title}<a href="{concat('https://', ezini('SiteSettings','SiteURL'), '/')}" style="color:#212529; text-decoration:none;">{ezini('SiteSettings','SiteName')}</a>{/set-block}

{set-block scope=root variable=email_footer}
<p style="margin:0 0 8px 0;">{'Sent from the contact form on'|i18n('design/sevenx_themes_media/collectedinfomail')} <a href="{$form_url}" style="color:#777777; text-decoration:underline;">{$site_url}</a></p>
<p style="margin:0;">{'Form'|i18n('design/sevenx_themes_media/collectedinfomail')}: {$collection.object.name|wash} &middot; {'Object ID'|i18n('design/sevenx_themes_media/collectedinfomail')}: {$object.id} &middot; {'Node ID'|i18n('design/sevenx_themes_media/collectedinfomail')}: {$node.node_id} &middot; {'Collection ID'|i18n('design/sevenx_themes_media/collectedinfomail')}: {$collection.id} &middot; {$collection.created|l10n('shortdatetime')}</p>
{/set-block}

{set-block scope=root variable=email_content}
<p style="margin:0 0 16px 0; font-size:18px; font-weight:600;">{'New contact form submission'|i18n('design/sevenx_themes_media/collectedinfomail')}</p>
<p style="margin:0 0 16px 0;">{$collection.object.name|wash}</p>
<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
{foreach $collection.attributes as $attr}
{if or($attr.contentclass_attribute.data_type_string|eq('ezboolean'),$attr.data_text|ne(''))}
    <tr>
        <td style="padding:0 20px 12px 0; color:#777777; font-size:14px; vertical-align:top; white-space:nowrap;">{$attr.contentclass_attribute_name|wash}</td>
        <td style="padding-bottom:12px; font-weight:600; vertical-align:top;">
            {if $attr.contentclass_attribute.data_type_string|eq('ezboolean')}
                {$attr.data_int|choose("No"|i18n("design/standard/content/datatype"),"Yes"|i18n("design/standard/content/datatype"))}
            {elseif $attr.contentclass_attribute.data_type_string|eq('eztext')}
                {$attr.data_text|wash|nl2br}
            {elseif $attr.contentclass_attribute.data_type_string|eq('ezemail')}
                {if $attr.data_text|ne('')}
                    {set-block scope=root variable=email_reply_to}{$attr.data_text|wash}{/set-block}
                    <a href="mailto:{$attr.data_text|wash}" style="color:#212529; text-decoration:underline;">{$attr.data_text|wash}</a>
                {/if}
            {else}
                {$attr.data_text|wash}
            {/if}
        </td>
    </tr>
{/if}
{/foreach}
</table>
{/set-block}

{include uri='design:emails/user/layout.tpl'}
{else}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name|wash))}{/set-block}
{'The following information was collected'|i18n('design/standard/content/edit')}:
{foreach $collection.attributes as $attr}
{if or($attr.contentclass_attribute.data_type_string|eq('ezboolean'),$attr.data_text|ne(''))}
{$attr.contentclass_attribute_name|wash}: {if $attr.contentclass_attribute.data_type_string|eq('ezboolean')}{$attr.data_int|choose("No"|i18n("design/standard/content/datatype"),"Yes"|i18n("design/standard/content/datatype"))}{else}{$attr.data_text|wash}{/if}
{/if}
{/foreach}

---
{'Sent from'|i18n('design/standard/content/edit')} {concat('https://', ezini('SiteSettings','SiteURL'), $node.url_alias|ezurl('no'))}
{'Form'|i18n('design/standard/content/edit')}: {$collection.object.name|wash} | {'Object ID'|i18n('design/standard/content/edit')}: {$object.id} | {'Node ID'|i18n('design/standard/content/edit')}: {$node.node_id} | {'Collection ID'|i18n('design/standard/content/edit')}: {$collection.id} | {$collection.created|l10n('shortdatetime')}
{/if}
