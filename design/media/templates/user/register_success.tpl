{* EXTENDS design:$nglayouts.layoutTemplate *}



{* BLOCK content *}
    <header class="full-page-header text-center no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{$'ngsite.user.register.success.title'|trans}</h1>
        </div>
    </header>

    <div class="full-form-content">
        <div class="container">
            <div class="full-form-response">
                <p>{$'ngsite.user.register.success.text'|trans(hash('%link%', path('login')))}</p>
            </div>
        </div>
    </div>
{* ENDBLOCK content *}