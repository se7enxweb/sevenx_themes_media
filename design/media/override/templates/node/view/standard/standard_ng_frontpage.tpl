


{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-frontpage vl1">
    <header class="article-header">
        <h3 class="title"><a href="{ibexa_path($location)}">{ng_render_field($content.fields.title)}</a></h3>
    </header>
</article>