{* The attributes of the edit form (content/edit) in the media design: one form group per attribute, its label
   (with "required" and the class attribute's description), its edit template, and the attribute id the kernel
   reads. Attributes of another category than the default one are grouped in a fieldset that stays open, so the
   form needs no script. While translating, the original is shown above the input. *}
{default $view_parameters = array()
         $attribute_categorys = ezini( 'ClassAttributeSettings', 'CategoryList', 'content.ini' )
         $attribute_default_category = ezini( 'ClassAttributeSettings', 'DefaultCategory', 'content.ini' )}
{def $content_language = ezini( 'RegionalSettings', 'Locale' )}

{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
{if $attribute_group|ne( $attribute_default_category )}
<fieldset class="content-edit-group">
    <legend>{first_set( $attribute_categorys[$attribute_group], $attribute_group )|wash}</legend>
{/if}
{foreach $content_attributes_grouped as $attribute_identifier => $attribute}
{def $contentclass_attribute = $attribute.contentclass_attribute
     $attribute_name = first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )}
<div class="form-group content-edit-attribute ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute_identifier}{if $attribute.has_validation_error} has-error{/if}">
{if and( eq( $attribute.can_translate, 0 ), ne( $object.initial_language_code, $attribute.language_code ) )}
    {* Not translatable: shown, not edited *}
    <label>{$attribute_name|wash}
    {if $attribute.can_translate|not} <span class="nontranslatable">({'not translatable'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
    {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description )|wash}</span>{/if}
    </label>
    <div class="original">
        {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
    </div>
    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
{elseif $attribute.display_info.edit.grouped_input}
    <fieldset>
        <legend{if $attribute.has_validation_error} class="message-error"{/if}>{$attribute_name|wash}
        {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
        {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
        {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description )|wash}</span>{/if}
        </legend>
    {if $is_translating_content}
        <div class="original">
            {attribute_view_gui attribute_base=$attribute_base attribute=$from_content_attributes_grouped_data_map[$attribute_group][$attribute_identifier] view_parameters=$view_parameters}
        </div>
    {/if}
        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
    </fieldset>
{else}
    <label class="form-label{if $attribute.has_validation_error} message-error{/if}" for="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}">{$attribute_name|wash}
    {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
    {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
    {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description )|wash}</span>{/if}
    </label>
    {if $is_translating_content}
    <div class="original">
        {attribute_view_gui attribute_base=$attribute_base attribute=$from_content_attributes_grouped_data_map[$attribute_group][$attribute_identifier] view_parameters=$view_parameters}
    </div>
    {/if}
    {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
{/if}
</div>
{undef $contentclass_attribute $attribute_name}
{/foreach}
{if $attribute_group|ne( $attribute_default_category )}
</fieldset>
{/if}
{/foreach}
{undef $content_language}
{/default}
