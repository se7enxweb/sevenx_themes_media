{* BLOCK subject *}{* FILTER $None|spaceless *}
    {set-block scope=root variable=subject}{ezini('SiteSettings','SiteName')} – {$content.name|wash} [{$collected_fields.sender_email.value}]{/set-block}
{* ENDFILTER *}{* ENDBLOCK subject *}

{* BLOCK recipient *}{$content.data_map.recipient.content}{* ENDBLOCK recipient *}

{* BLOCK email *}
{set-block scope=root variable=email_title}{$content.name|wash}{/set-block}

{set-block scope=root variable=email_content}
<p style="margin:0 0 16px 0;">{$'ngsite.collected_info.information_collected'|trans}:</p>

<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
{foreach $collected_fields as $collected_field => $collected_field_value}
    <tr>
        <td width="40%" style="padding:0 20px 12px 0; color:#777777; font-size:14px; vertical-align:top;">{if $content.data_map.$collected_field}{$content.data_map.$collected_field.contentclass_attribute_name|wash}{else}{$collected_field|wash}{/if}</td>
        <td width="60%" style="padding-bottom:12px; font-weight:600; vertical-align:top;">{$collected_field_value.value}</td>
    </tr>
{/foreach}
</table>
{/set-block}

{include uri='design:emails/user/layout.tpl'}
{* ENDBLOCK email *}
