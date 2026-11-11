


{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-frontpage vl1">
    <header class="article-header">
        <h3 class="title"><a href={$node.url_alias|ezurl}>{if and(is_set($node.data_map.title), $node.data_map.title.has_content)}{$node.data_map.title.content|wash}{else}{$node.name|wash}{/if}</a></h3>
    </header>
</article>