{* List - numbered view *}
<div class="slb slb-list slb-list-numbered" data-block-id="{$block.id|wash}">
    {if $block.name}<h3>{$block.name|wash}</h3>{/if}
    <ol class="block-list">
    {foreach $block.values.items as $item}
        <li><a href={$item.url_alias|ezurl}>{$item.name|wash}</a></li>
    {/foreach}
    {if eq(count($block.values.items),0)}
        <li class="empty">No items found.</li>
    {/if}
    </ol>
</div>
