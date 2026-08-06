{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))}
<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} image vl4">
    {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i320'}
    <div class="article-content">
        <header class="article-header">
            <h2 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>
        </header>
        <div class="short">
        </div>
    </div>
</article>
