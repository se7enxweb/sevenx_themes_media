{def $tc_left_class = 'col-md-8'}
{def $tc_right_class = 'col-md-4'}
{if $block.view_type|eq('two_columns_33_66')}
    {set $tc_left_class = 'col-md-4'}
    {set $tc_right_class = 'col-md-8'}
{elseif or( $block.view_type|eq('two_columns_50_50'), $block.view_type|eq('two_columns_50_50_1') )}
    {set $tc_left_class = 'col-md-6'}
    {set $tc_right_class = 'col-md-6'}
{/if}

<div class="row">
    <div class="{$tc_left_class}">
    {foreach $zone.blocks as $tc_child}
        {if and( $tc_child.parent_id|eq($block.id),
                 $tc_child.placeholder|eq('left'),
                 $tc_child.definition_identifier|ne('') )}
            {include uri='design:explayouts/block/block.tpl' block=$tc_child zone=$zone module_result=$module_result}
        {/if}
    {/foreach}
    </div>
    <div class="{$tc_right_class}">
    {foreach $zone.blocks as $tc_child}
        {if and( $tc_child.parent_id|eq($block.id),
                 $tc_child.placeholder|eq('right'),
                 $tc_child.definition_identifier|ne('') )}
            {include uri='design:explayouts/block/block.tpl' block=$tc_child zone=$zone module_result=$module_result}
        {/if}
    {/foreach}
    </div>
</div>

{undef $tc_left_class}
{undef $tc_right_class}
