{* List grid_featured - primary + secondary items, mirrors themes/app/block/list/grid_featured.html.twig *}
{def $gf_view = 'overlay'}
{if and( is_set($block.item_view_type), $block.item_view_type|ne('') )}
    {set $gf_view = $block.item_view_type}
{/if}
{if $block.values.items|count()|gt(0)}
<div class="grid-featured">
    {foreach $block.values.items as $gf_index => $gf_node}
        <div class="item {if $gf_index|eq(0)}primary-item{else}secondary-item{/if}">
            {def $gf_tpl = item_view_template($gf_view, $gf_node.class_identifier)}
            {if $gf_tpl|ne('')}
                {include uri=concat('design:', $gf_tpl) node=$gf_node content=$gf_node.object location=$gf_node view_type=$gf_view}
            {/if}
            {undef $gf_tpl}
        </div>
    {/foreach}
</div>
{/if}
{undef $gf_view}
