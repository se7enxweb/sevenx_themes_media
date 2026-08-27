{foreach $zone.blocks as $col_child}
    {if and( $col_child.parent_id|eq($block.id),
             $col_child.placeholder|eq('main'),
             $col_child.definition_identifier|ne('') )}
        {include uri='design:explayouts/block/block.tpl' name='colblock' block=$col_child zone=$zone module_result=$module_result}
    {/if}
{/foreach}
