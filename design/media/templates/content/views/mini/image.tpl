{def $node = fetch('content','node',hash('node_id',$location.node_id))}
<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} image vl5">
    {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i160'}
    <header class="article-header">
        <h2 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>
    </header>
</article>
