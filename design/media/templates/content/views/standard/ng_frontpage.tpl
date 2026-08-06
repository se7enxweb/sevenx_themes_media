


{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-frontpage vl1">
    <header class="article-header">
        <h3 class="title"><a href="{$node.url_alias|ezurl}">{ng_render_field($content.fields.title)}</a></h3>
    </header>
</article>