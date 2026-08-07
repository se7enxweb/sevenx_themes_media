<div class="view-type view-type-{$view_type} ng-frontpage">
    <div class="container">
        <h1 class="full-page-title">{$node.object.data_map.title.content|wash}</h1>
        {if $node.object.data_map.body}
	{if $node.object.data_map.body.has_content}
            <div class="full-page-content">
                {$node.object.data_map.body.data_text|strip_tags|wash}
            </div>
        {/if}
        {/if}
    </div>
</div>
