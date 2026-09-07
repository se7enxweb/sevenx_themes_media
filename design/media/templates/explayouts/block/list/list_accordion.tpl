{* List - accordion view, mirrors the reference list_accordion block *}
<div class="list-row">
    {foreach $block.values.items as $la_node}
    <div class="list-item">
        {def $la_tpl = item_view_template('accordion', $la_node.class_identifier)}
        {if $la_tpl|ne('')}
            {include uri=concat('design:', $la_tpl) node=$la_node content=$la_node.object location=$la_node view_type='accordion'}
        {/if}
        {undef $la_tpl}
    </div>
    {/foreach}
</div>
