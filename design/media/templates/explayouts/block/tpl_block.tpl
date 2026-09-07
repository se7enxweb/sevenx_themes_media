{* Imported nglayouts tpl_block: renders the template the corresponding nexus
   block renders. tpl_block_template() resolves imported blocks through the
   block-id map and editor-created blocks through their own block_name
   parameter (design:explayouts/tpl_block/<block_name>.tpl); unmapped tpl
   blocks render nothing (block.tpl also skips their wrapper div in that case). *}
{def $tpl_tpl = tpl_block_template($block.id)}
{if $tpl_tpl|ne('')}
{include uri=concat('design:', $tpl_tpl) module_result=$module_result}
{/if}
{undef $tpl_tpl}
