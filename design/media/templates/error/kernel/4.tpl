{* Moved. The kernel normally redirects before this is ever shown; it is here
   for the case where the redirect is not followed. *}
{def $new_location = cond( is_set( $parameters.new_location ), $parameters.new_location, '/' )}
<div class="container container-narrow site-error-page" style="padding:0 1rem">
    <div class="site-error text-center">
        <h1 class="site-error-title site-error-generic-title" style="margin:5rem 0 1.25rem">{'This page has moved'|i18n( 'design/media/error' )}</h1>
        <p class="site-error-message">{'It now lives at a new address.'|i18n( 'design/media/error' )}</p>
    </div>
    <div class="site-error-buttons text-center" style="margin-bottom:5rem">
        <a href={$new_location|ezurl} class="btn btn-primary">{'Go to the new page'|i18n( 'design/media/error' )}</a>
    </div>
</div>
{undef $new_location}
