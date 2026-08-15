{def $embed_alias = 'i1320'}
{def $embed_alt = cond( and( is_set( $object.data_map.image.content ), $object.data_map.image.content.alternative_text ), $object.data_map.image.content.alternative_text, $object.name|wash )}
<div class="view-type view-type-embed image">
    <figure class="image-wrapper">
        {ng_render_field( $object.data_map.image, hash( 'parameters', hash( 'alias', $embed_alias, 'lazy_loading', true(), 'alt_text', $embed_alt ) ) )}
    </figure>
</div>
{undef $embed_alias $embed_alt}
