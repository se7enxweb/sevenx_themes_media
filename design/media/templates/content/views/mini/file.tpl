


{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} file vl5">
    <header class="article-header">
        <h3 class="title"><a href="{ibexa_path($location)}"><span class="ibexa_string-field">{$node.name|wash}</span></a></h3>
    </header>
</article>