{* An address the site has no part for. To a visitor this is simply a page
   that isn't there; the module name goes in the details, for whoever reports it. *}
{def $error_details = hash( 'Error'|i18n( 'design/media/error' ), 'kernel 20 (module not found)'|i18n( 'design/media/error' ) )}
{if and( is_set( $parameters.module ), $parameters.module|ne( '' ) )}
    {set $error_details = $error_details|merge( hash( 'Address part'|i18n( 'design/media/error' ), $parameters.module ) )}
{/if}
{include uri='design:error/parts/page.tpl'
         code='404'
         title='We couldn\'t find that page'|i18n( 'design/media/error' )
         message='The address doesn\'t match any page on this site. It may have a typo, or the link that brought you here may be out of date.'|i18n( 'design/media/error' )
         search=true()
         details=$error_details}
{undef $error_details}
