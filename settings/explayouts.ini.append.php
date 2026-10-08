<?php /* #?ini charset="utf-8"?

# Layouts blocks of the media design.

[BlockSettings]
AvailableBlocks[]=product_highlight

# Product highlight: the products picked into its manual collection, each as a
# card with its image, short description, price and an "Add to basket" that
# posts the shop's own buy form (content/parts/product_buy_form.tpl, the form
# of the product full view). Drawn by explayouts/block/product_highlight.tpl;
# each item by its item view, content/views/product_card/<class>.tpl (the
# block's item view type when one other than "standard" is chosen).
[BlockDefinition_product_highlight]
Name=Product highlight
Handler=expLayoutsListBlockHandler
ViewTypes[]
ViewTypes[]=product_highlight
HasCollection=1
Category=listing

*/ ?>
