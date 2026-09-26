{* Shop: the currency exists but is switched off. *}
{include uri='design:error/parts/page.tpl'
         title='That currency isn\'t available at the moment'|i18n( 'design/media/error' )
         message='The shop has paused sales in this currency. Go back and choose another one.'|i18n( 'design/media/error' )
         actions=array( 'back', 'home' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'shop 4 (currency inactive)' )}
