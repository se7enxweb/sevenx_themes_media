{* Branded tell-a-friend email — renders through the shared email layout,
   matching the contact and order emails. Variables provided by
   kernel/content/tipafriend.php: your_name, your_email, nodename, node,
   hostname, comment, receivers_name. *}
{set-block scope=root variable=content_type}text/html{/set-block}

{def $site_url = ezini('SiteSettings','SiteURL')
     $page_url = concat('https://', $site_url, $node.url_alias|ezurl('no'))}

{set-block scope=root variable=email_title}<a href="{concat('https://', $site_url, '/')}" style="color:#212529; text-decoration:none;">{ezini('SiteSettings','SiteName')}</a>{/set-block}

{set-block scope=root variable=email_footer}
<p style="margin:0 0 8px 0;">{'Someone shared this page with you from'|i18n('design/sevenx_themes_media/tipafriendmail')} <a href="{concat('https://', $site_url, '/')}" style="color:#777777; text-decoration:underline;">{$site_url}</a>{'. If you were not expecting it, you can ignore this message.'|i18n('design/sevenx_themes_media/tipafriendmail')}</p>
{/set-block}

{set-block scope=root variable=email_content}
<p style="margin:0 0 16px 0; font-size:18px; font-weight:600;">{'A page was recommended to you'|i18n('design/sevenx_themes_media/tipafriendmail')}</p>
<p style="margin:0 0 16px 0;">{'%name thought you would find this page on %site interesting:'|i18n('design/sevenx_themes_media/tipafriendmail',,hash('%name', $your_name|wash, '%site', ezini('SiteSettings','SiteName')))}</p>
<p style="margin:0 0 20px 0;">
    <a href="{$page_url}" style="display:inline-block; padding:12px 20px; background-color:#212529; color:#ffffff; text-decoration:none; border-radius:6px; font-weight:600;">{$nodename|wash}</a>
</p>
{if $comment|trim|ne('')}
<p style="margin:0 0 6px 0; color:#777777; font-size:14px;">{'Their message'|i18n('design/sevenx_themes_media/tipafriendmail')}:</p>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding:14px 16px; background-color:#f6f7f9; border-left:3px solid #FED82F; border-radius:4px;">{$comment|wash|nl2br}</td></tr></table>
{/if}
<p style="margin:20px 0 0 0; font-size:13px; color:#777777;">{'Link'|i18n('design/sevenx_themes_media/tipafriendmail')}: <a href="{$page_url}" style="color:#777777; text-decoration:underline;">{$page_url}</a></p>
{/set-block}

{include uri='design:emails/user/layout.tpl'}
