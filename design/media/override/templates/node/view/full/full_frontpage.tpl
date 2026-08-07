<div class="content-view-full">
    <div class="class-frontpage">

{if $node.object.data_map.billboard.has_content}
    <div class="attribute-billboard">
        {attribute_view_gui attribute=$node.object.data_map.billboard}
    </div>
{/if}

    <div class="columns-frontpage float-break">
        {if $node.object.data_map.left_column.has_content}
        <div class="left-column-position">
            <div class="left-column">
                {attribute_view_gui attribute=$node.object.data_map.left_column}
            </div>
        </div>
        {/if}
        {if $node.object.data_map.center_column.has_content}
        <div class="center-column-position">
            <div class="center-column">
                {attribute_view_gui attribute=$node.object.data_map.center_column}
            </div>
        </div>
        {/if}
        {if $node.object.data_map.right_column.has_content}
        <div class="right-column-position">
            <div class="right-column">
                {attribute_view_gui attribute=$node.object.data_map.right_column}
            </div>
        </div>
        {/if}
    </div>

{if $node.object.data_map.bottom_column.has_content}
    <div class="attribute-bottom-column">
        {attribute_view_gui attribute=$node.object.data_map.bottom_column}
    </div>
{/if}

    </div>
</div>
