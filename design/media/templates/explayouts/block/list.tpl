{* List block dispatcher by view_type *}
{def $list_view_type = ''}
{if is_set( $block.view_type )}{set $list_view_type = $block.view_type|wash()}{/if}
{if $list_view_type|eq('')}{set $list_view_type = 'list'}{/if}
{include uri=concat('design:explayouts/block/list/', $list_view_type, '.tpl') block=$block}
