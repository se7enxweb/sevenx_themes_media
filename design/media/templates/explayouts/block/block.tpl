{if not(is_set($bl_view_type))}{def $bl_view_type = ''}{/if}
{if is_set($block.view_type)}{set $bl_view_type = $block.view_type|wash()}{/if}
{if not(is_set($bl_params))}{def $bl_params = array()}{/if}
{if is_set($block.parameters)}{set $bl_params = $block.parameters}{/if}

{if not(is_set($bl_whitespace))}{def $bl_whitespace = ''}{/if}
{if $bl_params['vertical_whitespace:enabled']}
    {if not(is_set($bl_top))}{def $bl_top = 'none'}{/if}
    {if not(is_set($bl_bottom))}{def $bl_bottom = 'none'}{/if}
    {if $bl_params['vertical_whitespace:top']|ne('')}{set $bl_top = $bl_params['vertical_whitespace:top']}{/if}
    {if $bl_params['vertical_whitespace:bottom']|ne('')}{set $bl_bottom = $bl_params['vertical_whitespace:bottom']}{/if}
    {set $bl_whitespace = concat(' whitespace-top-', $bl_top, ' whitespace-bottom-', $bl_bottom)}
    {undef $bl_top}
    {undef $bl_bottom}
{/if}

{if not(is_set($bl_extra))}{def $bl_extra = ''}{/if}
{if $bl_view_type|eq('section')}{set $bl_extra = ' section-title'}{/if}
{if $bl_view_type|eq('section_centered')}{set $bl_extra = ' section-title section-title-centered'}{/if}
{if $bl_view_type|eq('title_centered')}{set $bl_extra = ' text-center'}{/if}
{if $bl_view_type|eq('list_zigzag')}{set $bl_extra = ' list-zigzag'}{/if}
{if $bl_view_type|eq('list_accordion')}{set $bl_extra = ' list-accordion'}{/if}
{if and($bl_params['background_color:enabled'], $bl_params['background_color:color']|ne(''))}
    {set $bl_extra = concat($bl_extra, ' bg-color-', $bl_params['background_color:color'])}
{/if}
{if $bl_params['css_class']|ne('')}
    {set $bl_extra = concat($bl_extra, ' ', $bl_params['css_class'])}
{/if}

{if not(is_set($bl_container))}{def $bl_container = false()}{/if}
{set $bl_container = false()}
{if and($bl_params['set_container'], not(and(is_set($no_container), $no_container|eq(1))), ne($block.view_type, 'list'))}
    {set $bl_container = true()}
{/if}

{* Unmapped twig blocks render nothing at all (the reference omits their
   wrapper div too) - skip before emitting any markup. *}
{if not(is_set($bl_skip))}{def $bl_skip = false()}{/if}
{if and($block.definition_identifier|eq('twig_block'), twig_block_template($block.id)|eq(''))}
    {set $bl_skip = true()}
{/if}
{if $bl_skip|not()}

<div class="ngl-block ngl-{$block.definition_identifier|wash} ngl-vt-{$bl_view_type}{$bl_whitespace}{$bl_extra}"{if $bl_params['css_id']|ne('')} id="{$bl_params['css_id']|wash}"{/if} data-block-id="{$block.id|wash}" data-block-definition="{$block.definition_identifier|wash}" data-block-view-type="{$bl_view_type}">
    {if $bl_container}<div class="container{if $bl_params['set_container:size']|ne('')} container-{$bl_params['set_container:size']}{/if}">{/if}
        {include uri=concat('design:explayouts/block/', $block.definition_identifier, '.tpl') block=$block zone=$zone module_result=$module_result}
    {* Recompute instead of reusing $bl_container: nested block.tpl includes
       (two_columns/column children) share this namespace and clobber it,
       which used to swallow the closing container div. *}
    {if not(is_set($bl_container_close))}{def $bl_container_close = false()}{/if}
    {set $bl_container_close = false()}
    {if and($block.parameters['set_container'], and(not(and(is_set($no_container), $no_container|eq(1))), ne($block.view_type, 'list')))}
        {set $bl_container_close = true()}
    {/if}
    {if $bl_container_close}</div>{/if}
    {undef $bl_container_close}
</div>
{/if}
{undef $bl_skip}
{undef $bl_container}
{undef $bl_extra}
{undef $bl_whitespace}
{undef $bl_params}
{undef $bl_view_type}
