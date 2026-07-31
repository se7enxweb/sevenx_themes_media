{* List - zigzag view, mirrors the reference list_zigzag block *}
<div class="list-row">
    {foreach $block.values.items as $lz_node}
    <div class="list-item">
        {include uri=concat('design:content/views/zigzag/', $lz_node.class_identifier, '.tpl') node=$lz_node content=$lz_node.object location=$lz_node view_type='zigzag'}
    </div>
    {/foreach}
</div>
