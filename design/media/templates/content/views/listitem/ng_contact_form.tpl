{def $node = fetch('content','node',hash('node_id',$location.node_id))}
<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} ng-contact-form vl6">
    <h2 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>
    {if first_set($with_intro, false)}
        {intro('', $content)}
    {/if}
</article>
