{* Title - section heading. layout_title() resolves the imported
   topic_tag placeholder with the current page's name. *}
{def $st_title = layout_title($block.parameters.title)}
{if and( is_set( $block.parameters.use_link ), $block.parameters.use_link|eq('1' ), is_set( $block.parameters.link ) )}
    <h2 class="title"><a href={$block.parameters.link|ezurl()}>{$st_title|wash}</a></h2>
{else}
    <h2 class="title">{$st_title|wash}</h2>
{/if}
{undef $st_title}
