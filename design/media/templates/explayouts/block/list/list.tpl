{def $li_view = 'standard'}
{if is_set($block.item_view_type)}
    {if $block.item_view_type|ne('')}{set $li_view = $block.item_view_type}{/if}
{/if}
{* the reference prints the configured view type (e.g. standard_with_intro)
   in the item class even though it renders via the standard template *}
{def $li_view_label = $li_view}
{def $li_with_intro = 0}
{if $li_view|eq('standard_with_intro')}
    {set $li_view = 'standard'}
    {set $li_with_intro = 1}
{/if}
{if $li_view|eq('listitem_with_intro')}
    {set $li_view = 'listitem'}
    {set $li_with_intro = 1}
{/if}
{if $li_view|eq('line_with_intro')}
    {set $li_view = 'line'}
    {set $li_with_intro = 1}
{/if}
{def $li_limit = 0}
{if $li_view|ne('listitem')}
    {if is_set($block.parameters['limit'])}
        {if $block.parameters['limit']|ne('')}{set $li_limit = $block.parameters['limit']|int}{/if}
    {/if}
{/if}

{def $li_paged = false()}
{if and( is_set($block.parameters['paged_collections:enabled']), $block.parameters['paged_collections:enabled'] )}
    {set $li_paged = true()}
{/if}
{def $li_total = 0}
{if and( is_set($block.values.total), $block.values.total|gt(0) )}
    {set $li_total = $block.values.total}
{else}
    {set $li_total = count($block.values.items)}
{/if}
{def $li_page_size = count($block.values.items)}
{def $li_total_pages = 1}
{if and( $li_page_size|gt(0), $li_total|gt($li_page_size) )}
    {set $li_total_pages = ceil( $li_total|div($li_page_size) )}
{/if}
{if $li_paged}
<div class="ajax-collection">
    <div class="ajax-container">
{/if}
{include uri='design:explayouts/block/list/list_items.tpl' block=$block li_view=$li_view li_view_label=$li_view_label li_with_intro=$li_with_intro li_limit=$li_limit}
{if $li_paged}
    </div>
    <nav class="ajax-navigation"
        style="width: 100%; text-align: center; display: flex; justify-content: center; align-items: center;"
        data-page="1"
        data-total-pages="{$li_total_pages}"
        data-type="{$block.parameters['paged_collections:type']|wash}">
        {if $li_total_pages|gt(1)}
            <a href="#" class="ajax-load-more" data-page="2" data-block-id="{$block.id}" data-node-id="{$module_result.node_id}" rel="nofollow noopener noreferrer">Load more</a>
        {/if}
    </nav>
</div>
{/if}
{undef $li_paged}
{undef $li_total $li_page_size $li_total_pages}

{undef $li_with_intro}
{undef $li_limit}
{undef $li_view}
{undef $li_view_label}
