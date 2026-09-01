{* Media override for eZ email information collector input *}
{default attribute_base='ContentObjectAttribute' html_class='full'}
{def $data_text = first_set( $#collection_attributes[$attribute.id].data_text, $attribute.content )}
<input id="id_{$attribute.contentclass_attribute_identifier}" class="form-control {eq( $html_class, 'half' )|choose( 'box', 'halfbox' )}" type="email" size="70" name="{$attribute_base}_data_text_{$attribute.id}" value="{$data_text|wash( xhtml )}"{if $attribute.contentclass_attribute.is_required} required="required"{/if} autocomplete="email" />
{/default}
