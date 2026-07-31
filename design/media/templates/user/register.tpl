{* EXTENDS design:$nglayouts.layoutTemplate *}





{* BLOCK content *}
    <header class="full-page-header text-center no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{$'ngsite.user.register.title'|trans}</h1>
        </div>
    </header>

    <div class="full-form-content">
        <div class="container">
            {if is_set($error)}
                {if $error|eq('email_in_use')}
                    <div class="alert alert-danger">{$'ngsite.user.register.error.email_in_use'|trans}</div>
                {elseif $error|eq('username_taken')}
                    <div class="alert alert-danger">{$'ngsite.user.register.error.username_taken'|trans}</div>
                {else}
                    <div class="alert alert-danger">{$'ngsite.user.register.error.other'|trans}</div>
                {/if}
            {/if}

            {form_start($form, hash('attr', hash('class', 'embed-form')))}

            <div class="form-wrapper">
                {foreach $form.children as $form_child}
                    {form_row($form_child, hash('attr', hash('class', 'form-control')))}
                {/foreach}

                <button type="submit" class="btn btn-primary">{$'ngsite.user.register.submit'|trans}</button>
            </div>

            {form_end($form)}
        </div>
    </div>
{* ENDBLOCK content *}