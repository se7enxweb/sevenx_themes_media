{* Title - plain heading (view_type 'title'), tag from block parameters *}
{def $tt_tag = 'h2'}
{if and( is_set( $block.parameters.tag ), $block.parameters.tag|ne('') )}{set $tt_tag = $block.parameters.tag}{/if}
{if and( is_set( $block.parameters.use_link ), $block.parameters.use_link|eq('1'), is_set( $block.parameters.link ) )}
    <{$tt_tag} class="title"><a href={$block.parameters.link|ezurl()}>{$block.parameters.title|wash}</a></{$tt_tag}>
{else}
    <{$tt_tag} class="title">{$block.parameters.title|wash}</{$tt_tag}>
{/if}
{undef $tt_tag}
