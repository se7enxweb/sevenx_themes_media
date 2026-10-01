{* Hero component: content object comes from the block's 'content' parameter *}
{def $cmp = component_content($block.parameters['content'])}
{if $cmp}
{include uri=concat('design:explayouts/block/component/', $block.view_type, '.tpl') block=$block cmp=$cmp}
{/if}
{undef $cmp}
