{* Not found. *}
{include uri='design:error/parts/page.tpl'
         code='404'
         title='We couldn\'t find that page'|i18n( 'design/media/error' )
         message='It may have moved or been removed, or the address may have a typo. Try a search, or start again from the home page.'|i18n( 'design/media/error' )
         search=true()
         details=hash( 'Error'|i18n( 'design/media/error' ), 'kernel 2 (not found)'|i18n( 'design/media/error' ) )}
