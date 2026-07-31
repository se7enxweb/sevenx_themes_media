{* Title - centered page title with optional icon, mirrors the reference
   title/title_centered.html.twig (tag/title/title_icon block parameters). *}
{def $tc_tag = 'h2'}
{if and( is_set( $block.parameters.tag ), $block.parameters.tag|ne('') )}{set $tc_tag = $block.parameters.tag}{/if}
<{$tc_tag} class="title">
    {if $block.parameters['title_icon:enabled']}<div class="title-icon"><i class="{$block.parameters['title_icon:css_class']|wash}"></i></div>{/if}
    {$block.parameters.title|wash}
</{$tc_tag}>
{undef $tc_tag}
