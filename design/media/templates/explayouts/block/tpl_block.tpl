{* Imported nglayouts tpl_block: renders the template the corresponding nexus
   block renders. The block-id -> template mapping lives in the
   tpl_block_template() operator; unmapped tpl blocks render nothing
   (block.tpl also skips their wrapper div in that case). *}
{def $tpl_tpl = tpl_block_template($block.id)}
{if $tpl_tpl|ne('')}
{include uri=concat('design:', $tpl_tpl) module_result=$module_result}
{/if}
{undef $tpl_tpl}
