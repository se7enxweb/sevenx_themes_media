{* Product card: the item view the "Product highlight" layouts block uses for a
   product. Name, first image, short description, price and a working "Add to
   basket" - the buy form is content/parts/product_buy_form.tpl, the same one
   the product full view uses, so the item lands in the basket exactly as it
   does from the product page.

   The stock 'product' class keeps its images in an object relation list
   ('image'), not an ezimage, so the picture is the first related Image object
   that has one.

   Parameters: node (the product's tree node), view_type. *}

{def $pc_map  = $node.object.data_map
     $pc_img  = false()
     $pc_rel  = false()}
{if and( is_set( $pc_map.image ), $pc_map.image.has_content )}
    {foreach $pc_map.image.content.relation_list as $pc_item}
        {set $pc_rel = fetch( 'content', 'object', hash( 'object_id', $pc_item.contentobject_id ) )}
        {if and( $pc_rel, is_set( $pc_rel.data_map.image ) )}
            {if $pc_rel.data_map.image.has_content}
                {set $pc_img = $pc_rel.data_map.image}
                {break}
            {/if}
        {/if}
    {/foreach}
{/if}

<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}"
         class="view-type view-type-{first_set( $view_type, 'product_card' )|wash} product product-card">

    <div class="product-card-media">
        {if $pc_img}
        <a href={$node.url_alias|ezurl} tabindex="-1" aria-hidden="true">
            <img src={ng_image_alias( $pc_img, 'i770' )|ezroot}
                 {if and( $pc_img.content['i770'].width|gt(0), $pc_img.content['i770'].height|gt(0) )}width="{$pc_img.content['i770'].width}" height="{$pc_img.content['i770'].height}"{/if}
                 alt="{$node.name|wash}" class="exp_image-field" />
        </a>
        {else}
        <div class="product-gallery-empty"><div class="image-wrapper"></div></div>
        {/if}
    </div>

    <div class="product-card-body">
        <h2 class="product-card-title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>

        {if and( is_set( $pc_map.product_number ), $pc_map.product_number.has_content )}
        <p class="product-card-number">{'Item'|i18n('ngsite')} {$pc_map.product_number.content|wash}</p>
        {/if}

        {if and( is_set( $pc_map.short_description ), $pc_map.short_description.has_content )}
        <div class="product-card-intro exp_richtext-field">{attribute_view_gui attribute=$pc_map.short_description}</div>
        {/if}

        <div class="product-buy product-card-buy">
            {include uri='design:content/parts/product_buy_form.tpl' node=$node
                     field_id=concat( 'Quantity-', $node.node_id )}
        </div>

        <p class="product-card-more">
            <a href={$node.url_alias|ezurl}>{'View product details'|i18n('ngsite')}</a>
        </p>
    </div>
</article>

{undef $pc_map $pc_img $pc_rel}
