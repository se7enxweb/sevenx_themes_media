{* List grid - 2 columns *}
{def $gc_view = 'overlay'}
{if and( is_set($item_view_type), $item_view_type|ne('') )}{set $gc_view = $item_view_type}{/if}
<div class="{first_set($row_class, 'row')}">
{foreach $block.values.items as $node}
    <div class="col-sm-6 col-md-6 col-lg-6">
        {include uri=concat('design:content/views/', $gc_view, '/', $node.class_identifier, '.tpl') node=$node content=$node.object location=$node view_type=first_set($view_type_label, $gc_view) with_intro=first_set($with_intro, 0)}
    </div>
{/foreach}
</div>
{undef $gc_view}
