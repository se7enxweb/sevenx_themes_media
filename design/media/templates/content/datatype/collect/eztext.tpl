{* Media override for eZ text information collector textarea *}
{default attribute_base='ContentObjectAttribute' html_class='full'}
{def $data_text = first_set( $#collection_attributes[$attribute.id].data_text, $attribute.content )}
{def $rows = first_set( $attribute.contentclass_attribute.data_int1, 5 )}
<textarea class="{eq( $html_class, 'half' )|choose( 'box', 'halfbox' )}" name="{$attribute_base}_data_text_{$attribute.id}" cols="70" rows="{$rows}">{$data_text|wash}</textarea>
{/default}
