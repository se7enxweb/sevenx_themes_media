{* The mail of collected information for the forms of the media design.

   On an Exponential kernel with the HTML mail layout (notification.ini [MailSettings] HTMLLayout is the setting that
   came with it) the mail is the kernel's: an HTML part and a plain-text part from content/collectedinfomail_body.tpl,
   in the look of design:mail/layout.tpl (the media design's) and design:mail/layout_text.tpl. Every answer is its
   "info" view, as on the result page. The contact form (ng_contact_form) keeps its own subject and heading and sets
   the reply address to the address the visitor typed. Below the answers, both mails say which page sent them
   (mail_outro) and name the form, the object, the node, the collection and the time (mail_footer): plain text that
   the layouts escape, passed through content/collectedinfomail_body.tpl, which includes the layouts in this
   template's namespace.
   On an older kernel the mail stays what it was: the contact form an HTML mail in emails/user/layout.tpl, every
   other form plain text. *}
{def $stm_html_mail = ezini_hasvariable( 'MailSettings', 'HTMLLayout', 'notification.ini' )}
{if $stm_html_mail}
{def $stm_site_url = ezini( 'SiteSettings', 'SiteURL' )
     $stm_form_url = concat( 'https://', $stm_site_url, $node.url_alias|ezurl( 'no' ) )
     $stm_contact = $object.class_identifier|eq( 'ng_contact_form' )
     $stm_context = cond( $stm_contact, 'design/sevenx_themes_media/collectedinfomail', 'design/standard/content/edit' )}
{* The subject and the reply address are mail headers, text: the object's name and the address as they are *}
{if $stm_contact}
{set-block scope=root variable=subject}{"New contact form submission from %1"|i18n("design/sevenx_themes_media/collectedinfomail",,array($collection.object.name))}{/set-block}
{foreach $collection.attributes as $stm_attribute}
{if and( $stm_attribute.contentclass_attribute.data_type_string|eq( 'ezemail' ), $stm_attribute.data_text|ne( '' ) )}
{set-block scope=root variable=email_reply_to}{$stm_attribute.data_text}{/set-block}
{/if}
{/foreach}
{else}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name))}{/set-block}
{/if}
{include uri='design:content/collectedinfomail_body.tpl' collection=$collection ci_gui=true()
         ci_title=cond( $stm_contact, 'New contact form submission'|i18n( 'design/sevenx_themes_media/collectedinfomail' ),
                        "Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name)) )
         ci_intro=cond( $stm_contact, $collection.object.name, "The following information was collected"|i18n("design/standard/content/edit") )
         mail_outro=array( array( hash( 'text', concat( cond( $stm_contact, 'Sent from the contact form on'|i18n( $stm_context ), 'Sent from'|i18n( $stm_context ) ), ' ' ) ),
                                  hash( 'url', $stm_form_url, 'text', cond( $stm_contact, $stm_site_url, $stm_form_url ) ) ) )
         mail_footer=concat( 'Form'|i18n( $stm_context ), ': ', $collection.object.name,
                             ' · ', 'Object ID'|i18n( $stm_context ), ': ', $object.id,
                             ' · ', 'Node ID'|i18n( $stm_context ), ': ', $node.node_id,
                             ' · ', 'Collection ID'|i18n( $stm_context ), ': ', $collection.id,
                             ' · ', $collection.created|l10n( 'shortdatetime' ) )}
{undef $stm_site_url $stm_form_url $stm_contact $stm_context}
{elseif $object.class_identifier|eq('ng_contact_form')}
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
{undef $stm_html_mail}
