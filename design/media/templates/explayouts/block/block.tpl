{* Reset block-scoped variables so previous block.tpl includes don't leak. *}
{def $bl_view_type = ''}
{def $bl_params = array()}
{def $bl_top = 'none'}
{def $bl_bottom = 'none'}
{def $bl_whitespace = ''}
{def $bl_extra = ''}
{def $bl_skip = false()}
{if is_set($block.view_type)}{set $bl_view_type = $block.view_type|wash()}{/if}
{if is_set($block.parameters)}{set $bl_params = $block.parameters}{/if}

{if $bl_params['vertical_whitespace:enabled']}
    {if $bl_params['vertical_whitespace:top']|ne('')}{set $bl_top = $bl_params['vertical_whitespace:top']}{/if}
    {if $bl_params['vertical_whitespace:bottom']|ne('')}{set $bl_bottom = $bl_params['vertical_whitespace:bottom']}{/if}
    {set $bl_whitespace = concat(' whitespace-top-', $bl_top, ' whitespace-bottom-', $bl_bottom)}
{/if}

{if $bl_view_type|eq('section')}{set $bl_extra = ' section-title'}{/if}
{if $bl_view_type|eq('section_centered')}{set $bl_extra = ' section-title section-title-centered'}{/if}
{if $bl_view_type|eq('title_centered')}{set $bl_extra = ' text-center'}{set $bl_whitespace = ''}{/if}
{if $bl_view_type|eq('list_zigzag')}{set $bl_extra = ' list-zigzag'}{/if}
{if $bl_view_type|eq('list_accordion')}{set $bl_extra = ' list-accordion'}{/if}
{if and($bl_params['background_color:enabled'], $bl_params['background_color:color']|ne(''))}
    {set $bl_extra = concat($bl_extra, ' bg-color-', $bl_params['background_color:color'])}
{/if}
{if and($bl_params['background_image:enabled'], $bl_params['background_image:image']|ne(''))}
    {set $bl_extra = concat($bl_extra, ' with-bg-image')}
{/if}
{if $bl_params['css_class']|ne('')}
    {set $bl_extra = concat($bl_extra, ' ', $bl_params['css_class'])}
{/if}

{if and($block.definition_identifier|eq('tpl_block'), tpl_block_template($block.id)|eq(''))}
    {set $bl_skip = true()}
{/if}

{* Decide whether to mark this block with explblock and which name. *}
{def $bl_expl_name = ''}
{def $bl_has_children = false()}
{if is_set($zone.blocks)}
    {foreach $zone.blocks as $child}
        {if and(is_set($child.parent_id), $child.parent_id|eq($block.id))}
            {set $bl_has_children = true()}
        {/if}
    {/foreach}
{/if}

{if and(
    $bl_skip|not(),
    $bl_has_children|not(),
    $zone.identifier|ne('header'),
    $zone.identifier|ne('footer'),
    $block.definition_identifier|ne('tpl_block'),
    $block.definition_identifier|ne('full_view')
)}
    {if $block.definition_identifier|eq('title')}
        {set $bl_expl_name = 'article_header'}
    {elseif or($block.definition_identifier|eq('image'), $block.definition_identifier|eq('gallery'), $block.definition_identifier|eq('grid_gallery'), $block.definition_identifier|eq('thumb_gallery'), $block.definition_identifier|eq('slider'), $block.definition_identifier|eq('sushi_bar'))}
        {set $bl_expl_name = 'article_media'}
    {else}
        {set $bl_expl_name = 'article_body'}
    {/if}
{/if}

{def $bl_content_id = ''}
{def $bl_location_id = ''}
{if and($block.definition_identifier|contains('ibexa_component_'), is_set($block.parameters.content), $block.parameters.content|gt(0))}
    {set $bl_content_id = $block.parameters.content|wash()}
    {def $bl_cmp = component_content($block.parameters.content)}
    {if $bl_cmp}{set $bl_location_id = $bl_cmp.main_node_id}{/if}
    {undef $bl_cmp}
{/if}
{if $bl_skip|not()}

<div class="ngl-block ngl-{$block.definition_identifier|wash} ngl-vt-{$bl_view_type}{$bl_whitespace}{$bl_extra}"{if $bl_params['css_id']|ne('')} id="{$bl_params['css_id']|wash}"{/if}{if $bl_content_id|ne('')} data-component="true" data-content-id="{$bl_content_id}" data-location-id="{$bl_location_id|wash}"{/if}>
    {if $bl_params['set_container']}
        <div class="container{if $bl_params['set_container:size']|ne('')} container-{$bl_params['set_container:size']}{/if}">
            {if $bl_expl_name|ne('')}
                {explblock name=$bl_expl_name}
                    {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
                {/explblock}
            {else}
                {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
            {/if}
        </div>
    {else}
        {if $bl_expl_name|ne('')}
            {explblock name=$bl_expl_name}
                {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
            {/explblock}
        {else}
            {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
        {/if}
    {/if}
</div>

{/if}
{undef $bl_view_type $bl_params $bl_top $bl_bottom $bl_whitespace $bl_extra $bl_skip $bl_expl_name $bl_has_children $bl_content_id $bl_location_id}
