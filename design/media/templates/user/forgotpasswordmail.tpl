{* Forgotten-password email, branded through the shared email layout like the
   contact, order and tell-a-friend emails. The kernel (kernel/user/forgotpassword.php)
   asks for user/forgotpasswordmail.tpl and sends it twice:
     1. $link true  -- the link to click, with $hash_key;
     2. $link false -- after the link was clicked, the new $password.
   emails/user/forgot_password.tpl beside the layout is an unconverted port
   and is never loaded. *}
{set-block scope=root variable=content_type}text/html{/set-block}
{def $site_url = ezini( 'SiteSettings', 'SiteURL' )
     $site_name = ezini( 'SiteSettings', 'SiteName' )}
{set-block scope=root variable=subject}{if $link}{'Set a new password for %site'|i18n( 'design/sevenx_themes_media/forgotpasswordmail', '', hash( '%site', $site_name ) )}{else}{'Your new password for %site'|i18n( 'design/sevenx_themes_media/forgotpasswordmail', '', hash( '%site', $site_name ) )}{/if}{/set-block}

{set-block scope=root variable=email_title}<a href="{concat( 'https://', $site_url, '/' )}" style="color:#212529; text-decoration:none;">{$site_name|wash}</a>{/set-block}

{set-block scope=root variable=email_footer}
{if $link}
<p style="margin:0 0 8px 0;">{'You are getting this because someone asked to reset the password for this account on %site. If it was not you, ignore this email: your password stays as it is, and nobody can change it without this email.'|i18n( 'design/sevenx_themes_media/forgotpasswordmail', '', hash( '%site', $site_url ) )}</p>
{else}
<p style="margin:0 0 8px 0;">{'The password for this account on %site was reset from the link we emailed. If that was not you, sign in with the password above and change it at once.'|i18n( 'design/sevenx_themes_media/forgotpasswordmail', '', hash( '%site', $site_url ) )}</p>
{/if}
{/set-block}

{set-block scope=root variable=email_content}
{if $link}
    {def $reset_url = concat( 'user/forgotpassword/', $hash_key, '/' )|ezurl( 'no', 'full' )}
<p style="margin:0 0 16px 0; font-size:18px; font-weight:600;">{'Set a new password'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</p>
<p style="margin:0 0 20px 0;">{'Click the button to confirm it is you. We will then email you a new password straight away.'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</p>
<p style="margin:0 0 20px 0;">
    <a href="{$reset_url}" style="display:inline-block; padding:12px 20px; background-color:#212529; color:#ffffff; text-decoration:none; border-radius:6px; font-weight:600;">{'Confirm and send my new password'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</a>
</p>
<p style="margin:0 0 16px 0; font-size:14px; color:#555555;">{'The link works once. If the button does not work, copy this address into your browser:'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}<br><a href="{$reset_url}" style="color:#555555; text-decoration:underline; word-break:break-all;">{$reset_url}</a></p>
    {undef $reset_url}
{else}
<p style="margin:0 0 16px 0; font-size:18px; font-weight:600;">{'Here is your new password'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</p>
<table role="presentation" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 20px 0;"><tr><td style="padding:14px 18px; background-color:#f6f7f9; border-left:3px solid #FED82F; border-radius:4px; font-family:Consolas, Menlo, monospace; font-size:18px; letter-spacing:.05em;">{$password|wash}</td></tr></table>
<p style="margin:0 0 20px 0;">{'Sign in with it, then change it to one of your own from your account page.'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</p>
<p style="margin:0 0 20px 0;">
    <a href="{'user/login'|ezurl( 'no', 'full' )}" style="display:inline-block; padding:12px 20px; background-color:#212529; color:#ffffff; text-decoration:none; border-radius:6px; font-weight:600;">{'Sign in'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</a>
</p>
{/if}
<table role="presentation" cellpadding="0" cellspacing="0" border="0" style="margin:8px 0 0 0; font-size:14px; color:#777777;">
    <tr><td style="padding:0 16px 4px 0;">{'Username'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</td><td style="padding-bottom:4px; color:#212529; font-weight:600;">{$user.login|wash}</td></tr>
    <tr><td style="padding:0 16px 0 0;">{'Email'|i18n( 'design/sevenx_themes_media/forgotpasswordmail' )}</td><td style="color:#212529; font-weight:600;">{$user.email|wash}</td></tr>
</table>
{/set-block}

{include uri='design:emails/user/layout.tpl'}
{undef $site_url $site_name}
