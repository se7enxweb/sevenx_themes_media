{def $toolbar_macros = array()}

{set $node = fetch('content','node',hash('node_id',$location.node_id))}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-htmlbox vl1">
    <header class="article-header">
        {if and(is_set($node.data_map.html_code), $node.data_map.html_code.has_content)}{$node.data_map.html_code.content}{/if}
    </header>
</article>
