{* A part of the site that is switched off. *}
{include uri='design:error/parts/page.tpl'
         code='404'
         title='This part of the site is switched off'|i18n( 'design/media/error' )
         message='It is not available at the moment. Everything else on the site is working as usual.'|i18n( 'design/media/error' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'kernel 22 (module disabled)'|i18n( 'design/media/error' ) )}
