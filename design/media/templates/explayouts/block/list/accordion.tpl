{* List - accordion view *}
<div class="slb slb-list slb-list-accordion" data-block-id="{$block.id|wash}">
    {if $block.name}<h3>{$block.name|wash}</h3>{/if}
    {foreach $block.values.items as $item}
        <details class="accordion-item">
            <summary><a href={$item.url_alias|ezurl}>{$item.name|wash}</a></summary>
            <p>{$item.name|wash}</p>
        </details>
    {/foreach}
    {if eq(count($block.values.items),0)}<p class="empty">No items found.</p>{/if}
</div>
