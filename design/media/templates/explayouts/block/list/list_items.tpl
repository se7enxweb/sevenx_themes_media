{* Renders only the list-row of items, used by the ajax load-more endpoint *}
{set $li_view = first_set($li_view, 'standard')}
{if $li_view|eq('standard_with_intro')}{set $li_view = 'standard'}{/if}
{if $li_view|eq('listitem_with_intro')}{set $li_view = 'listitem'}{/if}
{if $li_view|eq('line_with_intro')}{set $li_view = 'line'}{/if}
{set $li_view_label = first_set($li_view_label, $li_view)}
{set $li_with_intro = first_set($li_with_intro, 0)}
{set $li_limit = first_set($li_limit, 0)}
<div class="list-row">
{def $li_count = 0}
{def $li_tpl = ''}
{foreach $block.values.items as $li_node}
    {if or($li_limit|eq(0), $li_count|lt($li_limit))}
    <div class="list-item">
        {set $li_tpl = item_view_template($li_view, $li_node.class_identifier)}
        {if $li_tpl|ne('')}
            {include uri=concat('design:', $li_tpl) node=$li_node content=$li_node.object location=$li_node view_type=$li_view_label with_intro=$li_with_intro}
        {/if}
    </div>
    {set $li_count = $li_count|sum(1)}
    {/if}
{/foreach}
{undef $li_count $li_tpl}
</div>
{undef $li_view $li_view_label $li_with_intro $li_limit}
