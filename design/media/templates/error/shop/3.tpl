{* Shop: the currency asked for does not exist. *}
{include uri='design:error/parts/page.tpl'
         title='That currency isn\'t available'|i18n( 'design/media/error' )
         message='The shop doesn\'t sell in the currency that was asked for. Go back and choose another one.'|i18n( 'design/media/error' )
         actions=array( 'back', 'home' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'shop 3 (currency does not exist)' )}
