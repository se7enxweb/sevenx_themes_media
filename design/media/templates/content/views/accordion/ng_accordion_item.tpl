{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))}
<article     data-item="true"
            data-content-id="{$node.contentobject_id}"
            data-location-id="{$node.node_id}"
        class="view-type view-type-{$view_type} ng-accordion-item vl10">
    <h3 class="title">
        <a role="button" href="#collapse-{$node.node_id}" role="button" class="collapsed" data-bs-toggle="collapse" aria-expanded="false" aria-controls="collapse-{$node.node_id}">
            <span         class="ibexa_string-field" >{$node.name|wash}</span>
        </a>
    </h3>
    <div id="collapse-{$node.node_id}" class="collapse" aria-labelledby="heading-{$node.node_id}" data-bs-parent=".list-accordion">
        {if and(is_set($node.data_map.description), $node.data_map.description.has_content)}
        <div class="short">
            <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$node.data_map.description}</div>
        </div>
        {/if}
    </div>
</article>
