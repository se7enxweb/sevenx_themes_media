{* Video thumbnail inside a gallery grid. *}
{if not(is_set($node))}{def $node = false()}{/if}
{if and( is_set($location), is_object($location) )}{set $node = fetch( 'content', 'node', hash( 'node_id', $location.node_id ) )}{/if}
<div class="gallery-thumb video-thumb">
    <a href={$node.url_alias|ezurl} title="{$node.name|wash}">
        {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i160'}
        <span class="video-label">{$node.name|wash}</span>
    </a>
</div>
