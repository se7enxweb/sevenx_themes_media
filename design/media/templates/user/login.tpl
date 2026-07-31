{* EXTENDS design:$nglayouts.layoutTemplate *}



{* BLOCK content *}

    <header class="full-page-header text-center no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{$'ngsite.user.login.title'|trans}</h1>
        </div>
    </header>

    {* BLOCK login_content *}
        <div class="full-form-content">
            <div class="container">
                {if $error}
                    <div class="alert alert-danger">{$error.message|trans}</div>
                {/if}

                <form name="loginform" action="{path('login_check')}" method="post" role="form" class="embed-form">
                    {* BLOCK login_fields *}
                        <div class="form-wrapper">
                            <div class="form-group">
                                <label for="username" class="form-label required">{$'ngsite.user.login.username.label'|trans}:</label>
                                <input type="text" id="username" class="form-control" name="_username" value="{$last_username}" required="required" autofocus="autofocus" autocomplete="on" placeholder="{$'ngsite.user.login.username.placeholder'|trans}" />
                            </div>
                            <div class="form-group{if $error} has-error{/if}">
                                <label for="password" class="form-label required">{$'ngsite.user.login.password.label'|trans}:</label>
                                <input type="password" id="password" class="form-control" name="_password" required="required" placeholder="{$'ngsite.user.login.password.placeholder'|trans}" />
                            </div>

                            {if get($app.request.attributes, 'csrf_enabled')}
                                <input type="hidden" name="_csrf_token" value="{csrf_token('authenticate')}" />
                            {/if}

                            
                            <button name="login" type="submit" class="btn btn-primary">{$'ngsite.user.login.submit'|trans}</button>
                            <div class="float-right">{$'ngsite.user.login.forgot_password_link'|trans(hash('%link%', path('ngsite_user_forgot_password')))}</div>
                        </div>
                    {* ENDBLOCK login_fields *}
                </form>

                <p class="text-center note mt-5">{$'ngsite.user.login.register_text'|trans} {$'ngsite.user.login.register_link'|trans(hash('%link%', path('ngsite_user_register')))}</p>
            </div>
        </div>
    {* ENDBLOCK login_content *}
{* ENDBLOCK content *}