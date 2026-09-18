{* Title - plain heading (view_type 'title'), tag from block parameters *}
{def $tt_tag = 'h2'}
{if and( is_set( $block.parameters.tag ), $block.parameters.tag|ne('') )}{set $tt_tag = $block.parameters.tag}{/if}
{* The handler resolves the compound link once - a mailto, a tel, a path or a
   plain URL - so this only has to decide whether to wrap the heading. *}
{if and( is_set( $block.values.has_link ), $block.values.has_link, $block.values.link_href|ne('') )}
    <{$tt_tag} class="title"><a href={$block.values.link_href|ezurl()}{if $block.values.link_target|ne('')} target="{$block.values.link_target|wash}"{/if}>{$block.parameters.title|wash}</a></{$tt_tag}>
{else}
    <{$tt_tag} class="title">{$block.parameters.title|wash}</{$tt_tag}>
{/if}
{undef $tt_tag}
