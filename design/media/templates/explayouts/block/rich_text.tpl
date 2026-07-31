{* Rich text block: outputs the stored HTML content parameter verbatim,
   like the reference rich_text.html.twig. Renders nothing when empty. *}
{def $rt_content = ''}
{if and( is_set( $block.parameters['content'] ), $block.parameters['content']|ne('') )}
    {set $rt_content = $block.parameters['content']}
{elseif is_set( $block.values.content )}
    {set $rt_content = $block.values.content}
{/if}
{if $rt_content|ne('')}{$rt_content}{/if}
{undef $rt_content}
