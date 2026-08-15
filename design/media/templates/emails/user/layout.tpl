<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">

    {literal}
    <style type="text/css">
        body {-webkit-text-size-adjust:none; -ms-text-size-adjust:none; margin:0; padding:0; background-color:#F8F9FC;}
        table {border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;}
        img {-ms-interpolation-mode:bicubic; border:0; height:auto; line-height:100%; outline:none; text-decoration:none;}
    </style>
    {/literal}
</head>
<body style="margin:0; padding:0; background-color:#F8F9FC;">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#F8F9FC;">
    <tr>
        <td align="center" style="padding:40px 10px;">
            <table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" style="max-width:600px; width:100%; background-color:#ffffff; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.05); font-family:Arial, Helvetica, sans-serif; font-size:16px; line-height:1.5; color:#212529;">
                <tr>
                    <td style="padding:30px; background-color:#FED82F; border-radius:8px 8px 0 0; color:#212529;">
                        <h1 style="margin:0; font-size:22px; font-weight:600; color:#212529; line-height:1.2;">{first_set($email_title, 'Notification')}</h1>
                    </td>
                </tr>
                <tr>
                    <td style="padding:30px;">
                        {first_set($email_content, '')}
                    </td>
                </tr>
                <tr>
                    <td style="padding:20px 30px; border-top:1px solid #eeeeee; background-color:#fafafa; border-radius:0 0 8px 8px; font-size:12px; color:#777777; line-height:1.5;">
                        {def $email_footer_value = first_set($email_footer, '')}
                        {if $email_footer_value|ne('')}
                            {$email_footer_value}
                        {else}
                            <p style="margin:0;">
                                <a href="{concat('https://', ezini('SiteSettings','SiteURL'), '/')}" style="color:#777777; text-decoration:underline;">{ezini('SiteSettings','SiteName')}</a>
                            </p>
                        {/if}
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
