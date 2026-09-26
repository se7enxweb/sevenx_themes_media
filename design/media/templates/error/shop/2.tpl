{* Shop: this product can't go in the basket together with what is already there. *}
{include uri='design:error/parts/page.tpl'
         title='This product can\'t be added to your basket'|i18n( 'design/media/error' )
         message='It can\'t be bought together with what is already in your basket. Check out the basket first, or remove what is in it, and then add this product.'|i18n( 'design/media/error' )
         actions=array( 'back', 'home' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'shop 2 (incompatible product type)' )}
