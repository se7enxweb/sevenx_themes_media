{* EXTENDS design:@nglayouts/block/block.tpl *}

{* BLOCK content *}
    {if and(is_set($collections.default), not(($collections.default|count()|eq(0))))}
        <div class="grid-featured">
            {foreach $collections.default as $result}
                <div class="item {if $loop.index0|eq(0)}primary-item{else}secondary-item{/if}">
                    {nglayouts_render_result($result, null, block.itemViewType)}
                </div>
            {/foreach}
        </div>
    {/if}
{* ENDBLOCK content *}