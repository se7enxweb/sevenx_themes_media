{* Raw HTML snippet block - outputs the admin-provided HTML as-is. *}
{if and( is_set( $block.parameters.content ), $block.parameters.content|ne('') )}
{$block.parameters.content}
{/if}
