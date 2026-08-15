{* Embed image view. content_view_gui provides $object; ngsite contexts may provide $content. *}
{if and( is_set( $object ), is_set( $object.data_map.image ), $object.data_map.image.has_content )}
    {def $image_alias_name = 'i1320'}
    {def $image_content = $object.data_map.image.content}
    {def $image_alias = $image_content[$image_alias_name]}
    {if and( is_set( $image_alias ), $image_alias )}
        {def $image_alt = cond( $image_alias.text|ne(''), $image_alias.text|wash, $object.name|wash )}
        <div class="view-type view-type-{first_set($view_type, 'embed')} image">
            <figure class="image-wrapper">
                <img src={$image_alias.url|ezroot} loading="lazy" alt="{$image_alt}" class="ibexa_image-field" />

                {if and( is_set( $object.data_map.caption ), $object.data_map.caption.has_content )}
                    <figcaption>
                        {attribute_view_gui attribute=$object.data_map.caption}
                    </figcaption>
                {/if}
            </figure>
        </div>
    {/if}
{elseif and( is_set( $content ), is_set( $content.fields.image ), not( $content.fields.image['empty'] ) )}
    <div class="view-type view-type-{first_set($view_type, 'embed')} image">
        <figure class="image-wrapper">
            {ng_render_field($content.fields.image, hash('parameters', hash('alias', 'i1320', 'link_href', first_set($link_href, ''), 'link_class', first_set($objectParameters.link_class, ''), 'link_id', first_set($objectParameters.link_id, ''), 'link_title', first_set($objectParameters.link_title, ''), 'link_target', first_set($objectParameters.link_target, ''), 'ezlink', first_set($linkParameters, hash()))))}

            {if and( is_set( $content.fields.caption ), not( $content.fields.caption['empty'] ) )}
                <figcaption>
                    {ng_render_field($content.fields.caption)}
                </figcaption>
            {/if}
        </figure>
    </div>
{/if}
