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

{if and($block.definition_identifier|eq('twig_block'), twig_block_template($block.id)|eq(''))}
    {set $bl_skip = true()}
{/if}
{if $bl_skip|not()}

<div class="ngl-block ngl-{$block.definition_identifier|wash} ngl-vt-{$bl_view_type}{$bl_whitespace}{$bl_extra}"{if $bl_params['css_id']|ne('')} id="{$bl_params['css_id']|wash}"{/if}>
    {if $bl_params['set_container']}
        <div class="container{if $bl_params['set_container:size']|ne('')} container-{$bl_params['set_container:size']}{/if}">
            {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
        </div>
    {else}
        {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
    {/if}
</div>

{/if}
{undef $bl_view_type $bl_params $bl_top $bl_bottom $bl_whitespace $bl_extra $bl_skip}
