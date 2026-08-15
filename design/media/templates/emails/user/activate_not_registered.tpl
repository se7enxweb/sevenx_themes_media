{set-block scope=root variable=email_title}<a href="{concat('https://', ezini('SiteSettings','SiteURL'), '/')}" style="color:#212529; text-decoration:none;">{ezini('SiteSettings','SiteName')}</a>{/set-block}

{set-block scope=root variable=email_content}
<p style="margin:0 0 16px 0;">{$'ngsite.user.activate.not_registered.text'|trans}</p>
{/set-block}

{include uri='design:emails/user/layout.tpl'}
