{* DocBook-style section titles render as h1. *}
<h1{if first_set($classification, '')|trim} class="{first_set($classification, '')|wash}"{/if}>{$content}</h1>
