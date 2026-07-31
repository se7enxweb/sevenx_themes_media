{* Title - centered section heading; heading tag from block parameters.
   layout_title() resolves the imported topic_tag placeholder. *}
{def $sc_tag = 'h2'}
{if and( is_set( $block.parameters.tag ), $block.parameters.tag|ne('') )}{set $sc_tag = $block.parameters.tag}{/if}
{def $sc_title = layout_title($block.parameters.title)}
{if and( is_set( $block.parameters.use_link ), $block.parameters.use_link|eq('1'), is_set( $block.parameters.link ) )}
    <{$sc_tag} class="title"><a href={$block.parameters.link|ezurl()}>{$sc_title|wash}</a></{$sc_tag}>
{else}
    <{$sc_tag} class="title">{$sc_title|wash}</{$sc_tag}>
{/if}
{undef $sc_tag $sc_title}
