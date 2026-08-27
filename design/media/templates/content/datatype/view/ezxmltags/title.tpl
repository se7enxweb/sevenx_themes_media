{* DocBook-style section titles render as h1. *}
<h1{if $classification|first_set('')|trim} class="{$classification|first_set('')|wash}"{/if}>{$content}</h1>
