{* List grid - 4 columns *}
{def $gc_view = 'overlay'}
{if and( is_set($item_view_type), $item_view_type|ne('') )}{set $gc_view = $item_view_type}{/if}
{def $gc_tpl = ''}
<div class="{first_set($row_class, 'row')}">
{foreach $block.values.items as $node}
    <div class="col-sm-6 col-md-4 col-lg-3">
        {set $gc_tpl = item_view_template($gc_view, $node.class_identifier)}
        {if $gc_tpl|ne('')}
            {include uri=concat('design:', $gc_tpl) node=$node content=$node.object location=$node view_type=first_set($view_type_label, $gc_view) with_intro=first_set($with_intro, 0)}
        {/if}
    </div>
{/foreach}
</div>
{undef $gc_view $gc_tpl}
