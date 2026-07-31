


{if not($content.fields.image['empty'])}
    <div class="view-type view-type-{$view_type} image">
        <figure class="image-wrapper">
            {ng_render_field($content.fields.image, hash('parameters', hash('alias', cond(not((first_set($objectParameters.align, '')|count()|eq(0))), 'i770', 'i1320'), 'link_href', first_set($link_href, ''), 'link_class', first_set($objectParameters.link_class, ''), 'link_id', first_set($objectParameters.link_id, ''), 'link_title', first_set($objectParameters.link_title, ''), 'link_target', first_set($objectParameters.link_target, ''), 'ezlink', first_set($linkParameters, hash()))))}

            {if not($content.fields.caption['empty'])}
                <figcaption>
                    {ng_render_field($content.fields.caption)}
                </figcaption>
            {/if}
        </figure>
    </div>
{/if}