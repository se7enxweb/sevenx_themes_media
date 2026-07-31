{* EXTENDS design:$nglayouts.layoutTemplate *}



{* BLOCK content *}
    <header class="full-page-header text-center no-breadcrumbs">
        <h1>{$'ngsite.user.activate.done.title'|trans}</h1>
    </header>

    {if is_set($error)}
        {if $error|eq('hash_expired')}
            <div class="alert alert-danger">
                {$'ngsite.user.activate.done.error.hash_expired'|trans(hash('%link%', path('ngsite_resend_activation_mail')))}
            </div>
        {else}
            <div class="alert alert-danger">{$'ngsite.user.activate.done.error.other'|trans}</div>
        {/if}
    {else}
        <p>{$'ngsite.user.activate.done.text'|trans(hash('%link%', path('login')))}</p>
    {/if}
{* ENDBLOCK content *}