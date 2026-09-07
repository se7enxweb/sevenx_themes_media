{* List - zigzag view, mirrors the reference list_zigzag block *}
<div class="list-row">
    {foreach $block.values.items as $lz_node}
    <div class="list-item">
        {def $lz_tpl = item_view_template('zigzag', $lz_node.class_identifier)}
        {if $lz_tpl|ne('')}
            {include uri=concat('design:', $lz_tpl) node=$lz_node content=$lz_node.object location=$lz_node view_type='zigzag'}
        {/if}
        {undef $lz_tpl}
    </div>
    {/foreach}
</div>
