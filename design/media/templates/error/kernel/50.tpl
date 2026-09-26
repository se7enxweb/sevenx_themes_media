{* No database connection. Temporary by nature, so the page says so and offers
   to try again rather than sending the visitor elsewhere. *}
{include uri='design:error/parts/page.tpl'
         code='503'
         title='We\'ll be right back'|i18n( 'design/media/error' )
         message='The site can\'t reach its content right now. This is usually over within a minute or two, so please try again shortly.'|i18n( 'design/media/error' )
         actions=array( 'retry', 'home' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'kernel 50 (no database connection)' )}
