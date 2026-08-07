


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $location_path = ibexa_path($location)}
{def $children = filterChildren($location, array('image'), 1)}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-gallery vl1">
    <i class="icon-camera article-icon" aria-hidden="true"></i>
    {if not($children.searchHits|count()|eq(0))}
        {def $first_image = $children[0].content}

        <figure class="image">
            {ng_render_field($first_image.fields.image, hash('parameters', hash('alias', 'i480', 'alt_text', $first_image.fields.name.value, 'link_href', $location_path)))}
        </figure>
    {/if}
    <header class="article-header">
        <h3 class="title"><a href="{$location_path}">{title($content_fields, $content)}</a></h3>
    </header>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>