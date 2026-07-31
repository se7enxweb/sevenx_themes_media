

{* MACRO content_link($content, $link_name, $link_class) *}
{* FILTER $None|spaceless *}
    {def $url = related_content_link($_self, $content)|trim}
    {def $open_in_new_tab = false}
    {if and(hasField($content, 'link'), $content.fields.link.value.isTargetLinkInNewTab)}
        {def $open_in_new_tab = true}
    {/if}

    {def $link_class = first_set($link_class, '')}
    {if not(($content.fields.link.value.suffix|eq(null)))}
        {def $url = concat($url, $content.fields.link.value.suffix)}
    {/if}

    {if $url}
        <a href="{$url}"
        {if not(($link_class|count()|eq(0)))}class="{$link_class}"{/if}
        {if $open_in_new_tab}target="_blank" rel="nofollow noopener noreferrer" {/if}
        >
    {/if}

    {first_set($link_name, '')}

    {if $url}
        </a>
    {/if}
{* ENDFILTER *}
{* ENDMACRO *}

{* MACRO image_link($content, $field, $alias, $lazy_loading) *}
{* FILTER $None|spaceless *}
    {def $url = related_content_link($_self, $content)|trim}
    {def $open_in_new_tab = false}
    {if and(hasField($content, 'link'), $content.fields.link.value.isTargetLinkInNewTab)}
        {def $open_in_new_tab = true}
    {/if}
    {if not(($content.fields.link.value.suffix|eq(null)))}
        {def $url = concat($url, $content.fields.link.value.suffix)}
    {/if}
    {def $lazy_loading = cond(and(is_set($lazy_loading), not(($lazy_loading|eq(null)))), $lazy_loading, getParameter($ibexa.configResolver, 'lazy_loading.enabled', 'ngsite'))}

    {if $url|count()|eq(0)}
        <span>
    {/if}
    {ng_render_field($content.fields[$field], hash('parameters', hash('alias', $alias, 'link_href', $url, 'link_target', cond($open_in_new_tab, '_blank', ''), 'lazy_loading', $lazy_loading)))}
    {if $url|count()|eq(0)}
        </span>
    {/if}

{* ENDFILTER *}
{* ENDMACRO *}

{* MACRO related_content_link($content) *}
{* FILTER $None|spaceless *}
    {def $url = null}
    {if hasField($content, 'link')}
        {if $content.fields.link.value.isTypeInternal}
            {def $url = path('ibexa.url.alias', hash('contentId', $content.fields.link.value.reference))}
        {elseif $content.fields.link.value.isTypeExternal}
            {def $url = $content.fields.link.value.reference}
        {/if}
    {/if}

    {$url}

{* ENDFILTER *}
{* ENDMACRO *}

{* MACRO item_content_link($link, $link_name) *}
{* FILTER $None|spaceless *}
    {def $url = null}
    {if not(($link|eq(null)))}
        {if $link.value.isTypeInternal}
            {def $url = path('ibexa.url.alias', hash('contentId', $link.value.reference))}
        {elseif $link.value.isTypeExternal}
            {def $url = $link.value.reference}
        {/if}
    {/if}

    {def $open_in_new_tab = false}
    {if $link.value.isTargetLinkInNewTab}
        {def $open_in_new_tab = true}
    {/if}


    {if not(($link.value.suffix|eq(null)))}
        {def $url = concat($url, $link.value.suffix)}
    {/if}

    {if $url}
        <a href="{$url}"
        {if $open_in_new_tab}target="_blank" rel="nofollow noopener noreferrer" {/if}
        >
    {/if}

    {first_set($link_name, '')}

    {if $url}
        </a>
    {/if}
{* ENDFILTER *}
{* ENDMACRO *}

{* MACRO item_image_link($link, $field, $alias, $lazy_loading) *}
{* FILTER $None|spaceless *}
    {def $url = null}
    {if not(($link|eq(null)))}
        {if $link.value.isTypeInternal}
            {def $url = path('ibexa.url.alias', hash('contentId', $link.value.reference))}
        {elseif $link.value.isTypeExternal}
            {def $url = $link.value.reference}
        {/if}
    {/if}

    {def $open_in_new_tab = false}
    {if $link.value.isTargetLinkInNewTab}
        {def $open_in_new_tab = true}
    {/if}
    {if not(($link.value.suffix|eq(null)))}
        {def $url = concat($url, $link.value.suffix)}
    {/if}
    {def $lazy_loading = cond(and(is_set($lazy_loading), not(($lazy_loading|eq(null)))), $lazy_loading, getParameter($ibexa.configResolver, 'lazy_loading.enabled', 'ngsite'))}

    {if $url|count()|eq(0)}
        <span>
    {/if}
    {ng_render_field($field, hash('parameters', hash('alias', $alias, 'link_href', $url, 'link_target', cond($open_in_new_tab, '_blank', ''), 'lazy_loading', $lazy_loading)))}
    {if $url|count()|eq(0)}
        </span>
    {/if}

{* ENDFILTER *}
{* ENDMACRO *}