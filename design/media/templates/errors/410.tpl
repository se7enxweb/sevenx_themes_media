{* EXTENDS design:$nglayouts.layoutTemplate *}



{def $site_title = 'ngsite.errors.410.title'|trans}

{* BLOCK content *}
    <div class="container container-narrow">
        <div class="site-error text-center">
            <h1 class="site-error-title">{$'ngsite.errors.410.title'|trans}</h1>
            <p class="site-error-message">{$'ngsite.errors.410.message'|trans}</p>
        </div>
        <div class="site-error-buttons text-center">
            <a href="{ibexa_path($ibexa.rootLocation)}" class="btn btn-primary">{$'ngsite.errors.button.back'|trans}</a>
        </div>
    </div>
{* ENDBLOCK content *}