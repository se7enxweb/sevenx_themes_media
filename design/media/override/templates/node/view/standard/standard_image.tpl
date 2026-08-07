


{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} image vl1">
    <i class="icon-camera article-icon" aria-hidden="true"></i>
    <figure class="image">
        {ng_render_field($content.fields.image, hash('parameters', hash('alias', 'i480', 'alt_text', $content.fields.name.value.text, 'link_href', ibexa_path($location))))}
    </figure>

    <header class="article-header">
        <h2 class="title"><a href="{ibexa_path($location)}">{ng_render_field($content.fields.name)}</a></h2>
    </header>
</article>