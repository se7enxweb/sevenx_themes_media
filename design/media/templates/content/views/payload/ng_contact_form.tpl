



{* EXTENDS design:forms/info_collection_base.tpl *}

{* BLOCK form_body *}
    {if not($content.fields.body['empty'])}
        {ng_render_field($content.fields.body)}
    {/if}

    

    {form_start($form, $form_parameters)}
        {form_errors($form)}

        <div class="form-wrapper">
            {form_row($form.sender_first_name, hash('ngparams', hash('autocomplete', 'given-name')))}

            {if not($content.fields.honeypot_field_name['empty'])}
                {form_row($form[$content.fields.honeypot_field_name.value.text])}
            {/if}

            {form_row($form.sender_last_name, hash('ngparams', hash('autocomplete', 'family-name')))}
            {form_row($form.sender_email, hash('ngparams', hash('autocomplete', 'email')))}
            {form_row($form.sender_message)}

            {form_row($form.gdpr_consent, hash('ngparams', hash('label', $content.fields.gdpr_consent_label.value.xml|ibexa_richtext_to_html5)))}
            {form_row($form.newsletter_1_consent, hash('ngparams', hash('label', $content.fields.newsletter_1_label.value.xml|ibexa_richtext_to_html5)))}

            {form_row($form.referer.value, hash('hidden', true, 'attr', hash('value', $referer)))}

            <div class="form-submit">
                <button type="submit" class="btn btn-primary">{$'ngsite.collected_info.button.send'|trans}</button>
            </div>
        </div>

        
        {form_rest($form)}
    {form_end($form, hash('render_rest', false))}
{* ENDBLOCK form_body *}

{* BLOCK form_response *}
    {parent()}
{* ENDBLOCK form_response *}