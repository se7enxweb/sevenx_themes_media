{* EXTENDS design:emails/user/layout.tpl *}



{* BLOCK title *}
    <a href="{ibexa_url($ibexa.rootLocation)}">{$ngsite.siteInfoContent.fields.site_name.value.text|trim}</a>
{* ENDBLOCK title *}

{* BLOCK content *}
    {$'ngsite.user.forgot_password.disabled.text'|trans}

    <br>

    {$'ngsite.user.account_information'|trans}

    <br>

    {$'ngsite.user.username'|trans}: {$user.login}

    <br>

    {$'ngsite.user.email'|trans}: {$user.email}

    <br><br>

    <a href="{ibexa_url($ibexa.rootLocation)}">{$ngsite.siteInfoContent.fields.site_name.value.text|trim}</a>
{* ENDBLOCK content *}