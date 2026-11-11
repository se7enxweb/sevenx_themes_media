<div class="view-type view-type-full video vf3">
    <div class="container">
        <header class="full-video-header">
            <h1 class="title">{$node.name|wash}</h1>
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </header>

        {* is_set() first, on its own: and() reads every argument, also the field a class may not have *}
        {if is_set( $node.object.data_map.file )}
        {if $node.object.data_map.file.has_content}
            <div class="full-video-player">
                {attribute_view_gui attribute=$node.object.data_map.file}
            </div>
        {/if}
        {/if}

        {if is_set( $node.object.data_map.description )}
        {if $node.object.data_map.description.has_content}
            <div class="body">
                {attribute_view_gui attribute=$node.object.data_map.description}
            </div>
        {/if}
        {/if}
    </div>
</div>
