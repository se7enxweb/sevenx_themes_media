<div class="view-type view-type-full video vf3">
    <div class="container">
        <header class="full-video-header">
            <h1 class="title">{$node.name|wash}</h1>
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </header>

        {if and( is_set( $node.object.data_map.file ), $node.object.data_map.file.has_content )}
            <div class="full-video-player">
                {attribute_view_gui attribute=$node.object.data_map.file}
            </div>
        {/if}

        {if and( is_set( $node.object.data_map.description ), $node.object.data_map.description.has_content )}
            <div class="body">
                {attribute_view_gui attribute=$node.object.data_map.description}
            </div>
        {/if}
    </div>
</div>
