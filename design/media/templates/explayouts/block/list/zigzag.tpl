{* List - zigzag view *}
<div class="slb slb-list slb-list-zigzag" data-block-id="{$block.id|wash}">
    {if $block.name}<h3>{$block.name|wash}</h3>{/if}
    {foreach $block.values.items as $item}
        <div class="row zigzag-item">
            <div class="col-sm-6 {if $item@index|mod(2)|eq(0)}order-sm-1{else}order-sm-2{/if}">
                {if $item.data_map.image.has_content}{attribute_view_gui attribute=$item.data_map.image image_class=small}{/if}
            </div>
            <div class="col-sm-6 {if $item@index|mod(2)|eq(0)}order-sm-2{else}order-sm-1{/if}">
                <h4><a href={$item.url_alias|ezurl}>{$item.name|wash}</a></h4>
            </div>
        </div>
    {/foreach}
    {if eq(count($block.values.items),0)}<p class="empty">No items found.</p>{/if}
</div>
