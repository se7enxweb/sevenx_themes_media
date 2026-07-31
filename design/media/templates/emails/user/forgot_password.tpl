{* EXTENDS design:emails/user/layout.tpl *}



{* BLOCK title *}
    <a href="{ibexa_url($ibexa.rootLocation)}">{$ngsite.siteInfoContent.fields.site_name.value.text|trim}</a>
{* ENDBLOCK title *}

{* BLOCK content *}
    {$'ngsite.user.account_information'|trans}

    <br>

    {$'ngsite.user.username'|trans}: {$user.login}

    <br>

    {$'ngsite.user.email'|trans}: {$user.email}

    <br><br>

    {$'ngsite.user.forgot_password.text'|trans} <a href="{url('ngsite_user_reset_password', hash('hash', $hash))}">{url('ngsite_user_reset_password', hash('hash', $hash))}</a>
{* ENDBLOCK content *}