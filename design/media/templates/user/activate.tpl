{* EXTENDS design:$nglayouts.layoutTemplate *}





{* BLOCK content *}
    <header class="full-page-header text-center no-breadcrumbs">
        <h1>{$'ngsite.user.activate.title'|trans}</h1>
    </header>

    <p>{$'ngsite.user.activate.text'|trans}</p>

    {form_start($form, hash('attr', hash('class', 'embed-form')))}

    <div class="form-wrapper">
        <div class="form-group">
            {form_row($form.email, hash('label', 'ngsite.user.activate.email.label'))}
        </div>

        <button type="submit" class="btn btn-primary">{$'ngsite.user.activate.submit'|trans}</button>
    </div>

    {form_end($form)}
{* ENDBLOCK content *}