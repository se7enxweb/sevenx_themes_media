{* Product highlight block: presents the products picked into its manual
   collection, each with its price and a working "Add to basket".

   Every item is drawn by its item view, content/views/<item view>/<class>.tpl
   (item_view_template), product_card unless the block names another one. A
   product gets content/views/product_card/product.tpl; any other content
   picked into the collection falls back to content/views/product_card.tpl,
   which is the plain card. *}
{def $ph_view = 'product_card'
     $ph_tpl  = ''}
{if and( is_set( $block.item_view_type ), $block.item_view_type|ne( '' ), $block.item_view_type|ne( 'standard' ) )}
    {set $ph_view = $block.item_view_type}
{/if}
<div class="product-highlight">
    {foreach $block.values.items as $ph_node}
    <div class="product-highlight-item">
        {set $ph_tpl = item_view_template( $ph_view, $ph_node.class_identifier )}
        {if $ph_tpl|ne('')}
            {include uri=concat( 'design:', $ph_tpl ) node=$ph_node content=$ph_node.object location=$ph_node view_type=$ph_view}
        {/if}
    </div>
    {/foreach}
</div>
{undef $ph_view $ph_tpl}
