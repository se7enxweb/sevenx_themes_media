{* An object embedded inline in rich text, in the media design: content/views/embed_inline/<class>.tpl
   when the class has one, else the generic link with the name. *}
{if $object.main_node}
{include uri='design:node/view/embed-inline.tpl' node=$object.main_node}
{/if}
