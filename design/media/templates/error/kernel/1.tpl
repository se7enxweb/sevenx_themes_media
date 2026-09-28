{* Access denied: the page exists, but not for this visitor. Signed out, they
   are offered the sign-in form right here; signed in, what to do instead. *}
{if eq( $current_user.contentobject_id, $anonymous_user_id )}
{include uri='design:error/parts/page.tpl'
         code='403'
         title='Please sign in to see this page'|i18n( 'design/media/error' )
         message='This page is for members. Sign in below and you will be taken straight back to it.'|i18n( 'design/media/error' )
         login=cond( is_set( $embed_content ), $embed_content, '' )
         actions=array( 'home', 'back' )
         details=hash( 'Error'|i18n( 'design/media/error' ), 'kernel 1 (access denied)'|i18n( 'design/media/error' ) )}
{else}
{def $error_details = hash( 'Error'|i18n( 'design/media/error' ), 'kernel 1 (access denied)'|i18n( 'design/media/error' ),
                            'Signed in as'|i18n( 'design/media/error' ), $current_user.login )}
{if is_set( $module_required )}
    {set $error_details = $error_details|merge( hash( 'Permission needed'|i18n( 'design/media/error' ), concat( $module_required, '/', $function_required ) ) )}
{/if}
{include uri='design:error/parts/page.tpl'
         code='403'
         title='You don\'t have access to this page'|i18n( 'design/media/error' )
         message='Your account is signed in but is not allowed to open this page. If you think it should be, ask the site\'s editors to give your account access, or sign in with another account.'|i18n( 'design/media/error' )
         actions=array( 'home', 'logout', 'back' )
         details=$error_details}
{undef $error_details}
{/if}
