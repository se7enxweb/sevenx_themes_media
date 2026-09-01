{* Media design collect view for ezstring datatype. *}
{default attribute_base='ContentObjectAttribute'
         html_class='full'}
{def $data_text = first_set( $#collection_attributes[$attribute.id].data_text, $attribute.content )}
<input id="id_{$attribute.contentclass_attribute_identifier}" class="form-control {eq( $html_class, 'half' )|choose( 'box', 'halfbox' )}" type="text" size="70" name="{$attribute_base}_ezstring_data_text_{$attribute.id}" value="{$data_text|wash( xhtml )}"{if $attribute.contentclass_attribute.is_required} required="required"{/if} />
{/def}
{/default}
