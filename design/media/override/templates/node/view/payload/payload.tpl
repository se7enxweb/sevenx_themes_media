{* eZ4-native payload-only view for ng_contact_form used by AJAX form submits. *}

{if $validation.processed}
    {if count($validation.attributes)|gt(0)}
        <div class="message-warning">
            <h2>{'Missing or invalid input'|i18n('design/standard/node/view')}</h2>
            <ul>
                {section name=UnvalidatedAttributes loop=$validation.attributes}
                    <li>{$:item.name|wash}: {$:item.description}</li>
                {/section}
            </ul>
        </div>
    {/if}

    {include uri='design:content/views/payload/ng_contact_form.tpl'
             node=$node
             referer=$requested_uri_string
             form_class='embed-form js-form-embed'}
{else}
    <div class="success-message">
        {$node.data_map.success_text.data_text|strip_tags}
    </div>
{/if}
