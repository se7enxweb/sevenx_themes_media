{* Media override for eZ boolean information collector checkbox *}
{default attribute_base='ContentObjectAttribute'}
{def $data_int = first_set( $#collection_attributes[$attribute.id].data_int, $attribute.data_int )}
<input type="checkbox" id="ContentObjectAttribute_data_boolean_{$attribute.id}" name="{$attribute_base}_data_boolean_{$attribute.id}" value="1"{if $data_int|eq(1)} checked="checked"{/if}{if $attribute.contentclass_attribute.is_required} required="required"{/if} />
{/default}
