{* Media design collect view for eztext datatype. *}
{default attribute_base='ContentObjectAttribute'
         html_class='full'}
{def $data_text = first_set( $#collection_attributes[$attribute.id].data_text, $attribute.content )}
<textarea id="id_{$attribute.contentclass_attribute_identifier}" class="form-control {eq( $html_class, 'half' )|choose( 'box', 'halfbox' )}" name="{$attribute_base}_data_text_{$attribute.id}" cols="70" rows="{$attribute.contentclass_attribute.data_int1}">{$data_text|wash}</textarea>
