{* The one look every error page on the site shares.

   Included by error/kernel/*.tpl and error/shop/*.tpl with:
     code         the HTTP status shown large ('404'); optional
     title        what happened, in plain words
     message      one or two sentences: why, and what to do about it
     notes        further sentences, each its own paragraph; optional
     search      true() to offer the site search (for "not found" kinds)
     login        HTML of a sign-in form to show (access denied, signed out)
     actions      'home', 'sitemap', 'back', 'retry', 'logout' -- which buttons, in order
     links        buttons of the page's own, shown before the actions: an array of
                  hash( 'url', <href>, 'text', <label>, 'primary', true()/false() );
                  the url is used as given (pass it through ezurl first)
     details      array of label => value for the "Technical details" box

   Everything passed in is plain text except login, which is the kernel's own
   embedded sign-in form. Values are washed here, once.

   The look is in stylesheets/error-page.css; exp-page-actions.js does "Go back" and "Try again", exp-search-focus.js puts the
   cursor in the search field (data-exp-autofocus) when the page opens. *}
{def $root_node = ezini( 'NodeSettings', 'RootNode', 'content.ini' )
     $error_actions = cond( is_set( $actions ), $actions, array( 'home', 'sitemap', 'back' ) )}
<div class="container container-narrow site-error-page">
    <div class="site-error text-center">
        {if and( is_set( $code ), $code|ne( '' ) )}
        <p class="site-error-code" aria-hidden="true">{$code|wash}</p>
        {/if}
        <h1 class="site-error-title site-error-generic-title">{$title|wash}</h1>
        <p class="site-error-message">{$message|wash}</p>
        {if is_set( $notes )}
        {foreach $notes as $error_note}
        <p class="site-error-message site-error-note">{$error_note|wash}</p>
        {/foreach}
        {/if}
    </div>

    {if and( is_set( $login ), $login|ne( '' ) )}
    <div class="site-error-login">{$login}</div>
    {/if}

    {if and( is_set( $search ), $search )}
    <form class="site-error-search" action={'/content/search'|ezurl} method="post" role="search">
        <label class="visually-hidden" for="site-error-search-text">{'Search this site'|i18n( 'design/media/error' )}</label>
        <input id="site-error-search-text" type="search" name="SearchText" data-exp-autofocus="" placeholder="{'Search this site'|i18n( 'design/media/error' )}" />
        <button type="submit" class="btn btn-primary">{'Search'|i18n( 'design/media/error' )}</button>
    </form>
    {/if}

    <div class="site-error-buttons text-center">
    {if is_set( $links )}
    {foreach $links as $error_link}
        <a href="{$error_link.url|wash}" class="btn {if and( is_set( $error_link.primary ), $error_link.primary )}btn-primary{else}btn-secondary{/if}">{$error_link.text|wash}</a>
    {/foreach}
    {/if}
    {foreach $error_actions as $error_action}
        {switch match=$error_action}
        {case match='home'}<a href={'/'|ezurl} class="btn btn-primary">{'Go to the home page'|i18n( 'design/media/error' )}</a>{/case}
        {case match='sitemap'}<a href={concat( '/content/view/sitemap/', $root_node )|ezurl} class="btn btn-secondary">{'Browse the site map'|i18n( 'design/media/error' )}</a>{/case}
        {case match='back'}<a href="#" class="btn btn-secondary" data-exp-history-back="">{'Go back'|i18n( 'design/media/error' )}</a>{/case}
        {case match='retry'}<a href="" class="btn btn-primary" data-exp-reload="">{'Try again'|i18n( 'design/media/error' )}</a>{/case}
        {case match='logout'}<a href={'/user/logout'|ezurl} class="btn btn-secondary">{'Sign in as someone else'|i18n( 'design/media/error' )}</a>{/case}
        {case}{/case}
        {/switch}
    {/foreach}
    </div>

    {if and( is_set( $details ), $details|count )}
    <details class="site-error-details">
        <summary>{'Technical details'|i18n( 'design/media/error' )}</summary>
        <dl>
        {foreach $details as $detail_label => $detail_value}
            <dt>{$detail_label|wash}</dt><dd>{$detail_value|wash}</dd>
        {/foreach}
        </dl>
    </details>
    {/if}
</div>
{undef $root_node $error_actions}
