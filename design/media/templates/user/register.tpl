{* eZ Publish compatible register.tpl for the media design *}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{"Register user"|i18n("design/standard/user")}</h1>
    </div>
</header>

<div class="full-form-content">
    <div class="container">
        {if and( is_set( $checkErrNodeId ), $checkErrNodeId )}
            <div class="alert alert-danger">
                <h2>{$errMsg}</h2>
            </div>
        {/if}

        {if $validation.processed}
            {if count( $validation.attributes )|gt( 0 )}
                <div class="alert alert-danger">
                    <h2>{"Input did not validate"|i18n("design/standard/user")}</h2>
                    <ul>
                        {foreach $validation.attributes as $validationAttribute}
                            <li>{$validationAttribute.name}: {$validationAttribute.description}</li>
                        {/foreach}
                    </ul>
                </div>
            {else}
                <div class="alert alert-success">
                    <h2>{"Input was stored successfully"|i18n("design/standard/user")}</h2>
                </div>
            {/if}
        {/if}

        {if count( $content_attributes )|gt( 0 )}
            <form enctype="multipart/form-data" action={"/user/register/"|ezurl} method="post" name="Register" class="embed-form">
                <div class="form-wrapper">
                    {foreach $content_attributes as $attribute}
                        {if or( $attribute.contentclass_attribute_identifier|eq( 'first_name' ), $attribute.contentclass_attribute_identifier|eq( 'last_name' ), $attribute.contentclass_attribute_identifier|eq( 'user_account' ) )}
                            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                            {if $attribute.contentclass_attribute_identifier|ne( 'user_account' )}
                                <div class="form-group">
                                    <label for="ezcoa-{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="form-label">
                                        {if $attribute.contentclass_attribute.name|ne( '' )}
                                            {$attribute.contentclass_attribute.name|wash}
                                        {else}
                                            {if $attribute.contentclass_attribute_identifier|eq( 'first_name' )}
                                                {'First name'|i18n('design/standard/user')}
                                            {elseif $attribute.contentclass_attribute_identifier|eq( 'last_name' )}
                                                {'Last name'|i18n('design/standard/user')}
                                            {else}
                                                {$attribute.contentclass_attribute_identifier|wash}
                                            {/if}
                                        {/if}
                                    </label>
                                    {attribute_edit_gui attribute=$attribute}
                                </div>
                            {else}
                                <div class="form-group">
                                    {attribute_edit_gui attribute=$attribute}
                                </div>
                            {/if}
                        {/if}
                    {/foreach}

                    <div class="form-group">
                        <p class="text-muted">{"Please note that your browser must use and support cookies to register a new user."|i18n("design/standard/user")}</p>
                    </div>

                    <div class="buttonblock clearfix">
                        {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
                            <input class="btn btn-primary" type="submit" id="PublishButton" name="PublishButton" value="{'Register'|i18n('design/standard/user','Button')}" />
                        {else}
                            <input class="btn btn-primary" type="submit" id="PublishButton" name="PublishButton" disabled="disabled" value="{'Register'|i18n('design/standard/user','Button')}" />
                        {/if}
                        <input class="btn btn-secondary" type="submit" id="CancelButton" name="CancelButton" value="{'Discard'|i18n('design/standard/user','Button')}" />
                    </div>
                </div>
            </form>
        {else}
            <div class="alert alert-danger">
                <h2>{"Unable to register new user"|i18n("design/standard/user")}</h2>
            </div>
            <div class="buttonblock">
                <form method="post" action={"/"|ezurl}>
                    <input class="btn btn-secondary" type="submit" value="{'Back'|i18n('design/standard/user')}" />
                </form>
            </div>
        {/if}
    </div>
</div>

{literal}
<script type="text/javascript">
    function disableButtons()
    {
        var publishButton = document.getElementById( 'PublishButton' );
        var cancelButton = document.getElementById( 'CancelButton' );
        if ( publishButton ) publishButton.disabled = true;
        if ( cancelButton ) cancelButton.disabled = true;
    }
    var registerForm = document.forms['Register'];
    if ( registerForm )
    {
        registerForm.addEventListener( 'submit', disableButtons );
    }
</script>
{/literal}
