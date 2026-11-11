{* Rich-text embed that lists the embedded object's children: itemized_sub_items and
   vertically_listed_sub_items as lines, horizontally_listed_sub_items as standard items in a row,
   itemized_subtree_items as lines of the whole subtree. At most 10 items. *}
{def $si_items = cond($classification|eq('itemized_subtree_items'),
                      fetch('content', 'tree', hash('parent_node_id', $node.node_id, 'limit', 10, 'sort_by', $node.sort_array)),
                      fetch('content', 'list', hash('parent_node_id', $node.node_id, 'limit', 10, 'sort_by', $node.sort_array)))
     $si_view = cond($classification|eq('horizontally_listed_sub_items'), 'standard', 'line')}
<div class="embed {$classification|wash}">
    <h3><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
    <div class="list-row">
    {foreach $si_items as $si_node}
        <div class="list-item">
            {include uri=concat('design:', item_view_template($si_view, $si_node.class_identifier))
                     node=$si_node content=$si_node.object location=$si_node view_type=$si_view with_intro=false()}
        </div>
    {/foreach}
    </div>
</div>
{undef $si_items $si_view}
