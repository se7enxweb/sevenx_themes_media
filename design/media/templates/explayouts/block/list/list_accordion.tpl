{* List - accordion view, mirrors the reference list_accordion block *}
<div class="list-row">
    {foreach $block.values.items as $la_node}
    <div class="list-item">
        {include uri=concat('design:content/views/accordion/', $la_node.class_identifier, '.tpl') node=$la_node content=$la_node.object location=$la_node view_type='accordion'}
    </div>
    {/foreach}
</div>
