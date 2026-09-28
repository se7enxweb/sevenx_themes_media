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
   embedded sign-in form. Values are washed here, once. *}
{def $root_node = ezini( 'NodeSettings', 'RootNode', 'content.ini' )
     $error_actions = cond( is_set( $actions ), $actions, array( 'home', 'sitemap', 'back' ) )}
<style>
{literal}
.site-error-page{padding:0 1rem}
.site-error-page .site-error-code{font-size:7rem;font-weight:700;line-height:1;letter-spacing:-.03em;margin:5rem 0 1rem;color:#FED82F;-webkit-text-stroke:2px #000;text-stroke:2px #000}
.site-error-page .site-error-title{margin:0 0 1.25rem}
.site-error-page .site-error-message{margin:0 auto 2.5rem;max-width:36rem}
.site-error-page .site-error-note{margin-top:-1.5rem}
.site-error-page .site-error-search{display:flex;gap:.5rem;max-width:30rem;margin:0 auto 2.5rem}
.site-error-page .site-error-search input{flex:1;min-width:0;padding:.75rem 1rem;border:2px solid #000;border-radius:0;font:inherit}
.site-error-page .site-error-search input:focus{outline:3px solid #FED82F;outline-offset:1px}
.site-error-page .site-error-buttons{display:flex;flex-wrap:wrap;gap:.75rem;justify-content:center;margin-bottom:3rem}
.site-error-page .site-error-login{max-width:26rem;margin:0 auto 3rem;text-align:left}
.site-error-page .site-error-login .full-page-header{display:none}
.site-error-page .site-error-login .container{padding:0;max-width:none}
.site-error-page .site-error-login .full-form-content{padding:0;margin:0}
.site-error-page .site-error-details{max-width:36rem;margin:0 auto 5rem;text-align:left;font-size:.875rem;color:#555}
.site-error-page .site-error-details summary{cursor:pointer;text-align:center}
.site-error-page .site-error-details dl{display:grid;grid-template-columns:max-content 1fr;gap:.25rem 1rem;margin:1rem 0 0;word-break:break-word}
.site-error-page .site-error-details dt{font-weight:600}
@media (max-width:575.98px){.site-error-page .site-error-code{font-size:4.5rem;margin-top:3rem}}
{/literal}
</style>
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
    <form class="site-error-search" action={'/content/search'|ezurl} method="get" role="search">
        <label class="visually-hidden" for="site-error-search-text">{'Search this site'|i18n( 'design/media/error' )}</label>
        <input id="site-error-search-text" type="search" name="SearchText" placeholder="{'Search this site'|i18n( 'design/media/error' )}" />
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
        {case match='back'}<a href="javascript:history.back()" class="btn btn-secondary" onclick="history.back();return false;">{'Go back'|i18n( 'design/media/error' )}</a>{/case}
        {case match='retry'}<a href="" class="btn btn-primary" onclick="location.reload();return false;">{'Try again'|i18n( 'design/media/error' )}</a>{/case}
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
