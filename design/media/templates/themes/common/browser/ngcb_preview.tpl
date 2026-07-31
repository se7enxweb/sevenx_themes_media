{def $valid_field_groups = array('', 'content')}

<div class="fields">
    {foreach $content.fields as $field}
        {if and(not($field['empty']), ($field.innerFieldDefinition.fieldGroup|contains($valid_field_groups)))}
            <div class="field {$field.fieldTypeIdentifier}">
                <p><strong>{$field.name}</strong></p>

                {if $field.fieldTypeIdentifier|eq('ibexa_richtext')}
                    
                    {saveXML($field.value.xml)|strip_tags|trim|u.truncate(300)}
                {elseif $field.fieldTypeIdentifier|eq('ibexa_image')}
                    {ng_render_field($field, hash('parameters', hash('alias', 'i480')))}
                {else}
                    {ng_render_field($field)}
                {/if}
            </div>
        {/if}
    {/foreach}
</div>