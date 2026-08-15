


{* eZ4-native payload for ng_contact_form. The Netgen Twig form_* operators are
   not implemented in the Exponential port, so we use the standard eZ information
   collection inputs directly. *}

{def $referer = first_set($referer, '')}
{def $form_class = first_set($form_class, 'embed-form js-form-embed')}

<form name="contactform" method="post" action={"content/action"|ezurl} role="form" class="{$form_class|wash}">
    <div class="form-wrapper">
        <div class="form-group">
            <label for="id_sender_first_name">{$node.data_map.sender_first_name.contentclass_attribute_name|wash}</label>
            {attribute_view_gui attribute=$node.data_map.sender_first_name}
        </div>

        <div class="form-group">
            <label for="id_sender_last_name">{$node.data_map.sender_last_name.contentclass_attribute_name|wash}</label>
            {attribute_view_gui attribute=$node.data_map.sender_last_name}
        </div>

        <div class="form-group">
            <label for="id_sender_email">{$node.data_map.sender_email.contentclass_attribute_name|wash}</label>
            {attribute_view_gui attribute=$node.data_map.sender_email}
        </div>

        <div class="form-group">
            <label for="id_sender_message">{$node.data_map.sender_message.contentclass_attribute_name|wash}</label>
            {attribute_view_gui attribute=$node.data_map.sender_message}
        </div>

        {if and( is_set( $node.data_map.honeypot_field_name ), $node.data_map.honeypot_field_name.has_content, is_set( $node.data_map.honeypot_field_label ) )}
            {def $honeypot_name = $node.data_map.honeypot_field_name.content}
            {def $honeypot_label = $node.data_map.honeypot_field_label.content}
            <div class="form-group honeypot" style="display:none;" aria-hidden="true">
                <label for="id_{$honeypot_name}">{$honeypot_label|wash}</label>
                <input type="text" id="id_{$honeypot_name}" name="ContentObjectAttribute_ezstring_data_text_{$node.data_map.honeypot_field_name.id}" value="" tabindex="-1" autocomplete="off" />
            </div>
            {undef $honeypot_name $honeypot_label}
        {/if}

        {if and( is_set( $node.data_map.gdpr_consent ), $node.data_map.gdpr_consent.is_information_collector )}
            <div class="form-group form-check">
                {attribute_view_gui attribute=$node.data_map.gdpr_consent}
                <label for="ContentObjectAttribute_data_boolean_{$node.data_map.gdpr_consent.id}">
                    {$node.data_map.gdpr_consent_label.data_text|strip_tags|ristring('Privacy Policy','<a href="/Privacy-Policy">Privacy Policy</a>')}
                </label>
            </div>
        {/if}

        {if and( is_set( $node.data_map.newsletter_1_consent ), $node.data_map.newsletter_1_consent.is_information_collector )}
            <div class="form-group form-check">
                {attribute_view_gui attribute=$node.data_map.newsletter_1_consent}
                <label for="ContentObjectAttribute_data_boolean_{$node.data_map.newsletter_1_consent.id}">
                    {$node.data_map.newsletter_1_label.data_text|strip_tags}
                </label>
            </div>
        {/if}

        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
        <input type="hidden" name="ViewMode" value="payload" />
        <input type="hidden" name="ActionCollectInformation" value="1" />
        {if and( is_set( $node.data_map.referer ), $node.data_map.referer.is_information_collector )}
            <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$node.data_map.referer.id}" id="id_referer" value="{$referer|wash}" />
        {/if}

        <div class="buttonblock clearfix">
            <input class="btn btn-primary" type="submit" value="{'Send form'|trans}" />
        </div>
    </div>
</form>

{undef $referer $form_class}
