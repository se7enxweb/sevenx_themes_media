{* Embedded information-collection lead form, mirroring the reference markup.
   Param: form_object_id (the Lead form content object). *}
{def $lf_id = first_set($form_object_id, 0)}
{def $lf_name = concat('information_collection_', $lf_id)}
{def $lf_class = first_set($form_class, 'embed-form js-form-embed')}
{def $privacy_link = concat('<a href="', '/bold_ger/datenschutz'|ezurl('no'), '">', 'Privacy Policy'|i18n('design/media/lead_form'), '</a>')}

<div class="ngenhancedlink-field">
    {if is_set($form_errors)}
        <div class="form-errors">
            <p>{'Please correct the following errors:'|i18n('design/media/lead_form')}</p>
            <ul>{foreach $form_errors as $field => $msg}<li>{$msg|wash}</li>{/foreach}</ul>
        </div>
    {/if}

    <form name="{$lf_name}" method="post" action={concat('/info-collection/submit/', $lf_id)|ezurl(no)} data-gtm-event-prefix="form-lead" class="{$lf_class}" novalidate>
        <div class="form-wrapper">
            <div class="form-group sender-first-name">
                <label for="{$lf_name}_sender_first_name_value" class="form-label required">{'First name'|i18n('design/media/lead_form')} <span aria-hidden="true">*</span><span class="sr-only">{'Mandatory field'|i18n('design/media/lead_form')}</span></label>
                <input class="form-control" type="text" id="{$lf_name}_sender_first_name_value" name="{$lf_name}[sender_first_name][value]" required="required" autocomplete="given-name" aria-invalid="false" aria-errormessage="error-{$lf_name}_sender_first_name_value" />
                <span id="error-{$lf_name}_sender_first_name_value" class="error-message">{'Enter a valid %name'|i18n('design/media/lead_form', '', hash('%name', 'First name'|i18n('design/media/lead_form'), '%name_akk', 'einen gültigen Vornamen'))}</span>
            </div>

            <div class="form-group sender-middle-name">
                <label for="{$lf_name}_sender_middle_name_value" class="form-label">{'Middle name'|i18n('design/media/lead_form')}</label>
                <input class="form-control" type="text" id="{$lf_name}_sender_middle_name_value" name="{$lf_name}[sender_middle_name][value]" tabindex="-1" aria-invalid="false" aria-errormessage="error-{$lf_name}_sender_middle_name_value" />
                <span id="error-{$lf_name}_sender_middle_name_value" class="error-message">{'Enter a valid %name'|i18n('design/media/lead_form', '', hash('%name', 'Middle name'|i18n('design/media/lead_form'), '%name_akk', 'einen gültigen zweiten Vornamen'))}</span>
            </div>

            <div class="form-group sender-last-name">
                <label for="{$lf_name}_sender_last_name_value" class="form-label required">{'Last name'|i18n('design/media/lead_form')} <span aria-hidden="true">*</span><span class="sr-only">{'Mandatory field'|i18n('design/media/lead_form')}</span></label>
                <input class="form-control" type="text" id="{$lf_name}_sender_last_name_value" name="{$lf_name}[sender_last_name][value]" required="required" autocomplete="family-name" aria-invalid="false" aria-errormessage="error-{$lf_name}_sender_last_name_value" />
                <span id="error-{$lf_name}_sender_last_name_value" class="error-message">{'Enter a valid %name'|i18n('design/media/lead_form', '', hash('%name', 'Last name'|i18n('design/media/lead_form'), '%name_akk', 'einen gültigen Nachnamen'))}</span>
            </div>

            <div class="form-group sender-email">
                <label for="{$lf_name}_sender_email_value" class="form-label required">{'E-mail'|i18n('design/media/lead_form')} <span aria-hidden="true">*</span><span class="sr-only">{'Mandatory field'|i18n('design/media/lead_form')}</span></label>
                <input class="form-control" type="email" id="{$lf_name}_sender_email_value" name="{$lf_name}[sender_email][value]" required="required" autocomplete="email" aria-invalid="false" aria-errormessage="error-{$lf_name}_sender_email_value" />
                <span id="error-{$lf_name}_sender_email_value" class="error-message">{'Enter a valid %name'|i18n('design/media/lead_form', '', hash('%name', 'E-mail'|i18n('design/media/lead_form'), '%name_akk', 'eine gültige E-Mail'))}</span>
            </div>

            <div class="form-group sender-message">
                <label for="{$lf_name}_sender_message_value" class="form-label">{'Message'|i18n('design/media/lead_form')}</label>
                <textarea class="form-control" id="{$lf_name}_sender_message_value" name="{$lf_name}[sender_message][value]" rows="5"></textarea>
            </div>

            <div class="form-group form-check gdpr-consent">
                <input type="checkbox" class="form-check-input" id="{$lf_name}_gdpr_consent_value" name="{$lf_name}[gdpr_consent][value]" required="required" value="1" />
                <label class="form-label" for="{$lf_name}_gdpr_consent_value" aria-invalid="false" aria-errormessage="error-{$lf_name}_gdpr_consent_value">
                    <p>{'I have read %privacy_link and agree to its terms.'|i18n('design/media/lead_form', '', hash('%privacy_link', $privacy_link))}</p>
                </label>
                <span id="error-{$lf_name}_gdpr_consent_value" class="error-message">{'GDPR Consent not checked'|i18n('design/media/lead_form')}</span>
            </div>

            <div class="form-group form-check newsletter-1-consent">
                <input type="checkbox" class="form-check-input" id="{$lf_name}_newsletter_1_consent_value" name="{$lf_name}[newsletter_1_consent][value]" value="1" />
                <label class="form-label" for="{$lf_name}_newsletter_1_consent_value" aria-invalid="false" aria-errormessage="error-{$lf_name}_newsletter_1_consent_value">
                    <p>{'I consent to receiving marketing and promotional materials. I understand that I can unsubscribe at any time.'|i18n('design/media/lead_form')}</p>
                </label>
                <span id="error-{$lf_name}_newsletter_1_consent_value" class="error-message">{'Newsletter 1 Consent not checked'|i18n('design/media/lead_form')}</span>
            </div>

            <input class="form-control" type="hidden" id="{$lf_name}_referer_value" name="{$lf_name}[referer][value]" value="" />

            <div class="form-submit">
                <button type="submit" class="btn btn-primary">{'Send form'|i18n('design/media/lead_form')}</button>
            </div>
        </div>

        <input class="form-control" type="hidden" id="{$lf_name}_content_id" name="{$lf_name}[content_id]" value="{$lf_id}" />
        <input class="form-control" type="hidden" id="{$lf_name}_content_type_id" name="{$lf_name}[content_type_id]" value="118" />
        <input class="form-control" type="hidden" id="{$lf_name}_discriminator" name="{$lf_name}[discriminator]" value="{$lf_id}" />
    </form>
</div>

{undef $lf_id $lf_name $lf_class $privacy_link}
