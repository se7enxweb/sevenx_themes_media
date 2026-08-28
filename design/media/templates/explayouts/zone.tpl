<section class="zone zone-{$zone.identifier|wash}">
{foreach $zone.blocks as $zone_block}
    {if and( is_set( $zone_block.parent_id ), $zone_block.parent_id|eq(0) )}
        {if and( is_set( $zone_block.definition_identifier ), $zone_block.definition_identifier|ne('') )}
            {include uri='design:explayouts/block/block.tpl' name='zoneblock' block=$zone_block zone=$zone module_result=$module_result}
        {else}
            {include uri='design:explayouts/block/tpl_block.tpl' block=$zone_block zone=$zone module_result=$module_result}
        {/if}
    {/if}
{/foreach}
</section>
