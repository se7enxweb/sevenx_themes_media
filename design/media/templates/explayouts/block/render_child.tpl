{* Render a child block inside a column/two_columns wrapper *}
{if $child.definition_identifier|eq('column')}
    {* column marker; skip *}
{else}
    {include uri='design:explayouts/block/child_block.tpl' block=$child module_result=$module_result}
{/if}
