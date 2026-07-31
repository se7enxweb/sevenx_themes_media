{* List grid view - delegates to grid/{N}_columns.tpl per block parameters,
   mirroring @nglayouts/block/list/grid.html.twig. Paged collections get the
   reference ajax-collection wrapper and ajax-navigation nav. *}
{def $gr_cols = 2}
{if and( is_set($block.parameters['number_of_columns']), $block.parameters['number_of_columns']|ne('') )}
    {set $gr_cols = $block.parameters['number_of_columns']}
{/if}
{def $gr_view = 'overlay'}
{if and( is_set($block.item_view_type), $block.item_view_type|ne('') )}
    {set $gr_view = $block.item_view_type}
{/if}
{def $gr_view_label = $gr_view}
{def $gr_with_intro = 0}
{if $gr_view|eq('standard_with_intro')}
    {set $gr_view = 'standard'}
    {set $gr_with_intro = 1}
{/if}
{def $gr_paged = false()}
{if and( is_set($block.parameters['paged_collections:enabled']), $block.parameters['paged_collections:enabled'] )}
    {set $gr_paged = true()}
{/if}
{if $gr_paged}
<div class="ajax-collection">
    {include uri=concat('design:explayouts/block/list/grid/', $gr_cols, '_columns.tpl') block=$block item_view_type=$gr_view view_type_label=$gr_view_label with_intro=$gr_with_intro row_class='ajax-container row'}
    <nav class="ajax-navigation"
        data-page="1"
        data-total-pages="1"
        data-type="{$block.parameters['paged_collections:type']|wash}"></nav>
</div>
{else}
{include uri=concat('design:explayouts/block/list/grid/', $gr_cols, '_columns.tpl') block=$block item_view_type=$gr_view view_type_label=$gr_view_label with_intro=$gr_with_intro row_class='row'}
{/if}
{undef $gr_cols $gr_view $gr_view_label $gr_with_intro $gr_paged}
