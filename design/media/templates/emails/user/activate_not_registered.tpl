{* EXTENDS design:emails/user/layout.tpl *}



{* BLOCK title *}
    <a href="{ibexa_url($ibexa.rootLocation)}">{$ngsite.siteInfoContent.fields.site_name.value.text|trim}</a>
{* ENDBLOCK title *}

{* BLOCK content *}
    {$'ngsite.user.activate.not_registered.text'|trans}

    <br><br>

    <a href="{ibexa_url($ibexa.rootLocation)}">{$ngsite.siteInfoContent.fields.site_name.value.text|trim}</a>
{* ENDBLOCK content *}