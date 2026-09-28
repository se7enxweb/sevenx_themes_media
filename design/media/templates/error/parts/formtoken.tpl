{* A form was sent without its form token, or with one that does not match
   (extension/ezformtoken). Nothing was saved: the visitor reloads the form and
   sends it again. Signed out, they are told they may have to sign in again.

   Included by error/kernel/6.tpl (design/standard) with:
     reason       'missing' or 'wrong'
     reload_url   where "Reload the form" goes (a path on this site)
     home_url     the front page of this siteaccess
     signed_out   true() when the visitor is not signed in
     login_form   true() when the refused form was a sign-in form

   Wording shared with every design (context design/standard/error/formtoken). *}
{def $formtoken_notes = array( 'Reload the form and send it again.'|i18n( 'design/standard/error/formtoken' ) )}
{if $signed_out}
    {set $formtoken_notes = $formtoken_notes|append( 'You may have been signed out in the meantime. If so, please sign in again.'|i18n( 'design/standard/error/formtoken' ) )}
{elseif and( is_set( $login_form ), $login_form )}
    {set $formtoken_notes = $formtoken_notes|append( 'If you were signing in, please sign in again.'|i18n( 'design/standard/error/formtoken' ) )}
{/if}
{include uri='design:error/parts/page.tpl'
         code='403'
         title='This form has expired'|i18n( 'design/standard/error/formtoken' )
         message='The page with this form was open for a long time, or the form was sent from another page. To keep your information safe, nothing was saved.'|i18n( 'design/standard/error/formtoken' )
         notes=$formtoken_notes
         links=array( hash( 'url', $reload_url, 'text', 'Reload the form'|i18n( 'design/standard/error/formtoken' ), 'primary', true() ),
                      hash( 'url', $home_url, 'text', 'Go to the front page'|i18n( 'design/standard/error/formtoken' ), 'primary', false() ) )
         actions=array()}
{undef $formtoken_notes}
