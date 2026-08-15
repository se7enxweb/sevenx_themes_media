{set-block scope=root variable=email_title}<a href="{concat('https://', ezini('SiteSettings','SiteURL'), '/')}" style="color:#212529; text-decoration:none;">{ezini('SiteSettings','SiteName')}</a>{/set-block}

{set-block scope=root variable=email_content}
<p style="margin:0 0 16px 0;">{$'ngsite.user.account_information'|trans}</p>
<table border="0" cellpadding="0" cellspacing="0" style="margin:0 0 24px 0; width:100%;">
    <tr>
        <td style="padding:0 20px 8px 0; color:#777777; font-size:14px; white-space:nowrap;">{$'ngsite.user.username'|trans}</td>
        <td style="padding-bottom:8px; font-weight:600;">{$user.login}</td>
    </tr>
    <tr>
        <td style="padding:0 20px 0 0; color:#777777; font-size:14px; white-space:nowrap;">{$'ngsite.user.email'|trans}</td>
        <td style="font-weight:600;">{$user.email}</td>
    </tr>
</table>
{def $activate_user = fetch('content', 'object', hash('object_id', $user.contentobject_id))}
{def $activate_main_node_id = cond($activate_user, $activate_user.main_node_id, 0)}
{def $activate_path = concat('user/activate/', $hash, '/', $activate_main_node_id)|ezurl('no')}
{def $activate_url = concat('https://', ezini('SiteSettings','SiteURL'), $activate_path)}
<p style="margin:0 0 16px 0;">{$'ngsite.user.activate.text'|trans}</p>
<p style="margin:0 0 16px 0;">
    <a href="{$activate_url}" style="color:#212529; text-decoration:underline; font-weight:600; word-break:break-all;">{$activate_url}</a>
</p>
{/set-block}

{include uri='design:emails/user/layout.tpl'}
