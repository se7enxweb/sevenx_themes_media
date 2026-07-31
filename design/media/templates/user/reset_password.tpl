{* EXTENDS design:$nglayouts.layoutTemplate *}





{* BLOCK content *}
    <div class="page-header full-page-header text-center no-breadcrumbs">
        <h1>{$'ngsite.user.reset_password.title'|trans}</h1>
    </div>

    <p>{$'ngsite.user.reset_password.text'|trans}</p>

    {form_start($form, hash('attr', hash('class', 'embed-form')))}

    <div class="form-wrapper">
        <div class="form-group">
            {form_row($form.password.first, hash('label', 'ngsite.user.reset_password.first.label'))}
        </div>

        <div class="form-group">
            {form_row($form.password.second, hash('label', 'ngsite.user.reset_password.second.label'))}
        </div>

        <button type="submit" class="btn btn-primary">{$'ngsite.user.reset_password.submit'|trans}</button>
    </div>

    {form_end($form)}
{* ENDBLOCK content *}