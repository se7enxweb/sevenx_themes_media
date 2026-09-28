{* A known part of the site, asked for a view it does not have. *}
{def $error_details = hash( 'Error'|i18n( 'design/media/error' ), 'kernel 21 (view not found)'|i18n( 'design/media/error' ) )
     $error_part = concat( cond( is_set( $parameters.module ), $parameters.module, '' ), '/', cond( is_set( $parameters.view ), $parameters.view, '' ) )}
{if $error_part|ne( '/' )}
    {set $error_details = $error_details|merge( hash( 'Address part'|i18n( 'design/media/error' ), $error_part ) )}
{/if}
{include uri='design:error/parts/page.tpl'
         code='404'
         title='We couldn\'t find that page'|i18n( 'design/media/error' )
         message='This part of the site exists, but not the page the address asks for. It may have a typo, or the link may be out of date.'|i18n( 'design/media/error' )
         search=true()
         details=$error_details}
{undef $error_details $error_part}
