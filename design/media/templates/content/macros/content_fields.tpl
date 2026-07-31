


{* MACRO image($content, $location, $alias_name, $lazy_loading, $link_class) *}
    {def $alias_name = cond(and(is_set($alias_name), not(($alias_name|eq(null)))), $alias_name, 'i480')}
    {def $lazy_loading = cond(and(is_set($lazy_loading), not(($lazy_loading|eq(null)))), $lazy_loading, getParameter($ibexa.configResolver, 'lazy_loading.enabled', 'ngsite'))}

    {def $image_field = false}
    {if and(hasField($content, 'teaser_image'), not($content.fields.teaser_image['empty']))}
        {def $image_field = $content.fields.teaser_image}
    {elseif and(hasField($content, 'image'), not($content.fields.image['empty']))}
        {def $image_field = $content.fields.image}
    {/if}

    {if $image_field}
        <figure class="image">
            {ng_render_field($image_field, hash('parameters', hash('alias', $alias_name, 'link_href', cond(not(($location|count()|eq(0))), ibexa_path($location), null), 'lazy_loading', $lazy_loading, 'link_class', cond(and(is_set($link_class), not(($link_class|eq(null)))), $link_class, null))))}
        </figure>
    {/if}
{* ENDMACRO *}

{* MACRO title($content) *}
{* FILTER $None|spaceless *}
    {def $title = firstNonEmptyField($content, 'teaser_title', 'title', 'name')}
    {if not($title['empty'])}
        {$title.value.text}
    {else}
        {$content.name}
    {/if}
{* ENDFILTER *}
{* ENDMACRO *}

{* MACRO intro($content) *}
    {if and(hasField($content, 'teaser_intro'), not($content.fields.teaser_intro['empty']))}
        <div class="short">
            {ng_render_field($content.fields.teaser_intro)}
        </div>
    {elseif and(hasField($content, 'full_intro'), not($content.fields.full_intro['empty']))}
        <div class="short">
            {ng_render_field($content.fields.full_intro)}
        </div>
    {/if}
{* ENDMACRO *}