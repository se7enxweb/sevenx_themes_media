{* The requested language is not available for this content. *}
{include uri='design:error/parts/page.tpl'
         code='404'
         title='This page isn\'t available in that language'|i18n( 'design/media/error' )
         message='The page exists, but not in the language that was asked for. Try the home page to see what is available in your language.'|i18n( 'design/media/error' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'kernel 5 (language not found)' )}
