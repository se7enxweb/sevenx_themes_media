{* Media design edit view for ezuser datatype, used in public forms such as registration. *}
{default attribute_base=ContentObjectAttribute}

{if ne( $attribute_base, 'ContentObjectAttribute' )}
    {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{else}
    {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{/if}

<div class="user-account-fields">
    <div class="form-group">
        <label for="{$id_base}_login" class="form-label">{'Username'|i18n( 'design/standard/content/datatype' )}:</label>
        {if $attribute.content.has_stored_login}
            <input id="{$id_base}_login" class="form-control" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}_stored_login" size="16" value="{$attribute.content.login|wash()}" disabled="disabled" />
            <input id="{$id_base}_login_hidden" type="hidden" name="{$attribute_base}_data_user_login_{$attribute.id}" value="{$attribute.content.login|wash()}" />
        {else}
            <input id="{$id_base}_login" class="form-control" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}" size="16" value="{$attribute.content.login|wash()}" />
        {/if}
    </div>

    <div class="form-group">
        <label for="{$id_base}_password" class="form-label">{'Password'|i18n( 'design/standard/content/datatype' )}:</label>
        <input id="{$id_base}_password" class="form-control" type="password" name="{$attribute_base}_data_user_password_{$attribute.id}" size="16" value="{if $attribute.content.original_password}{$attribute.content.original_password|wash}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" />
    </div>

    <div class="form-group">
        <label for="{$id_base}_password_confirm" class="form-label">{'Confirm password'|i18n( 'design/standard/content/datatype' )}:</label>
        <input id="{$id_base}_password_confirm" class="form-control" type="password" name="{$attribute_base}_data_user_password_confirm_{$attribute.id}" size="16" value="{if $attribute.content.original_password_confirm}{$attribute.content.original_password_confirm|wash}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" />
    </div>

    <div class="form-group">
        <label for="{$id_base}_email" class="form-label">{'Email'|i18n( 'design/standard/content/datatype' )}:</label>
        <input id="{$id_base}_email" class="form-control" type="text" name="{$attribute_base}_data_user_email_{$attribute.id}" size="28" value="{$attribute.content.email|wash( xhtml )}" />
    </div>

    {if ezini( 'UserSettings', 'RequireConfirmEmail' )|eq( 'true' )}
    <div class="form-group">
        <label for="{$id_base}_email_confirm" class="form-label">{'Confirm email'|i18n( 'design/standard/content/datatype' )}:</label>
        <input id="{$id_base}_email_confirm" class="form-control" type="text" name="{$attribute_base}_data_user_email_confirm_{$attribute.id}" size="28" value="{cond( ezhttp_hasvariable( concat( $attribute_base, '_data_user_email_confirm_', $attribute.id ), 'post' ), ezhttp( concat( $attribute_base, '_data_user_email_confirm_', $attribute.id ), 'post')|wash( xhtml ), $attribute.content.email|wash )}" />
    </div>
    {/if}
</div>

{/default}
