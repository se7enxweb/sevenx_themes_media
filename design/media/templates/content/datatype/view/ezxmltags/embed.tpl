{if and( is_set( $object ), $object.class_identifier|eq( 'image' ) )}
    {def $embed_align = cond( and( is_set( $object_parameters.align ), $object_parameters.align|ne('') ), $object_parameters.align, 'center' )}
    <div class="align-{$embed_align} ez-embed-type-image{if ne( first_set($classification, '')|trim, '' )} {first_set($classification, '')|wash}{/if}"{if is_set( $object_parameters.id )} id="{$object_parameters.id}"{/if}>
        {content_view_gui view=$view link_parameters=$link_parameters object_parameters=$object_parameters content_object=$object classification=$classification}
    </div>
{else}
    <div class="{if $object_parameters.align}object-{$object_parameters.align}{/if}{if ne(first_set($classification, '')|trim,'')} {first_set($classification, '')|wash}{/if}"{if is_set($object_parameters.id)} id="{$object_parameters.id}"{/if}>
        {content_view_gui view=$view link_parameters=$link_parameters object_parameters=$object_parameters content_object=$object classification=$classification}
    </div>
{/if}
