{* Shop: the item is not a product that can be bought. *}
{include uri='design:error/parts/page.tpl'
         code='404'
         title='This item can\'t be bought'|i18n( 'design/media/error' )
         message='It isn\'t a product in the shop, or it is no longer for sale.'|i18n( 'design/media/error' )
         search=true()
         details=hash( 'Error'|i18n( 'design/media/error' ), 'shop 1 (not a product)' )}
