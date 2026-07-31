{* Imported nglayouts twig_block: renders the template the corresponding nexus
   block renders. The block-id -> template mapping lives in the
   twig_block_template() operator; unmapped twig blocks render nothing
   (block.tpl also skips their wrapper div in that case). *}
{def $twb_tpl = twig_block_template($block.id)}
{if $twb_tpl|ne('')}
{include uri=concat('design:', $twb_tpl) module_result=$module_result}
{/if}
{undef $twb_tpl}
