{* MACRO image($content, $location, $alias_name, $lazy_loading, $link_class) *}
    {def $alias_name = cond(and(is_set($alias_name), not(($alias_name|eq(null)))), $alias_name, 'i480')}
    {def $lazy_loading = cond(and(is_set($lazy_loading), not(($lazy_loading|eq(null)))), $lazy_loading, true())}

    {def $image_field = firstNonEmptyField($content, 'teaser_image', 'image')}

    {if not($image_field.empty)}
        <figure class="image">
            {ng_render_field($image_field, hash('parameters', hash('alias', $alias_name, 'link_href', cond(not(($location|count()|eq(0))), ibexa_path($location), null), 'lazy_loading', $lazy_loading, 'link_class', cond(and(is_set($link_class), not(($link_class|eq(null)))), $link_class, null))))}
        </figure>
    {/if}
{* ENDMACRO *}

{* MACRO title($content_fields, $content) *}
{* FILTER $None|spaceless *}
    {def $title = firstNonEmptyField($content, 'teaser_title', 'title', 'name')}
    {if not($title.empty)}
        {$title.value.text}
    {else}
        {$content.name}
    {/if}
{* ENDFILTER *}
{* ENDMACRO *}

{* The intro macro is intentionally not defined here; it is handled by the
   registered 'intro' template operator which returns the rendered
   teaser_intro/full_intro HTML. This avoids the Netgen/Site-API
   'content.fields.*' path that does not exist in eZ4. *}
