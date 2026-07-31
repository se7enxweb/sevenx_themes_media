{* EXTENDS design:$nglayouts.layoutTemplate *}



{* BLOCK content *}
    <header class="full-page-header text-center no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{$'ngsite.user.forgot_password.sent.title'|trans}</h1>
        </div>
    </header>

    <div class="full-form-content">
        <div class="container">
            <div class="full-form-response">
                <p>{$'ngsite.user.forgot_password.sent.text'|trans(hash('%link%', path('ngsite_user_forgot_password')))}</p>
            </div>
        </div>
    </div>
{* ENDBLOCK content *}