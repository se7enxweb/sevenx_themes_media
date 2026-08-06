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
{if $li_paged}
<div class="ajax-collection">
    <div class="ajax-container">
{/if}
<div class="list-row">
{def $li_count = 0}
{foreach $block.values.items as $li_node}
    {if or($li_limit|eq(0), $li_count|lt($li_limit))}
    <div class="list-item">
        {include uri=concat('design:content/views/', $li_view, '/', $li_node.class_identifier, '.tpl') node=$li_node content=$li_node.object location=$li_node view_type=$li_view_label with_intro=$li_with_intro}
    </div>
    {set $li_count = $li_count|sum(1)}
    {/if}
{/foreach}
{undef $li_count}
</div>
{if $li_paged}
    </div>
    <nav class="ajax-navigation"
        data-page="1"
        data-total-pages="1"
        data-type="{$block.parameters['paged_collections:type']|wash}"></nav>
</div>
{/if}
{undef $li_paged}

{undef $li_with_intro}
{undef $li_limit}
{undef $li_view}
{undef $li_view_label}
