{def $content_fields = array()}
{def $toolbar_macros = array()}

{set $node = fetch('content','node',hash('node_id',$location.node_id))}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-article vl2">
    {include uri='design:content/parts/item_image.tpl' node=$node}

    <header class="article-header">
        <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
        <div class="info">
            {include uri='design:content/parts/author.tpl'}
        </div>
    </header>
</article>
