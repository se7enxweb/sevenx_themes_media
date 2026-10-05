{* The e-mail preferences box of the media design, on the pages that touch e-mail: the user profile, the
   notification settings, the newsletter pages. Variables: context ('profile', 'notification' or 'newsletter';
   optional). Signed in: the preference page itself; not signed in: the "send me a link" page.
   Drawn by stylesheets/account.css (.mp-account-link) and the design's .btn. *}
{def $mp_context = first_set( $context, 'profile' )
     $mp_signed_in = fetch( 'user', 'current_user' ).is_logged_in}
<div class="mp-account-link">
    <p>
        <b>{'E-mail preferences'|i18n( 'design/standard/mailpreferences' )}:</b>
{if $mp_context|eq( 'notification' )}
        {'Whether notifications are sent at all, how often, and every other kind of e-mail, is chosen on one page.'|i18n( 'design/standard/mailpreferences' )}
{elseif $mp_context|eq( 'newsletter' )}
        {'See and change every kind of e-mail we send you, including newsletters, or stop all optional e-mail, on one page.'|i18n( 'design/standard/mailpreferences' )}
{else}
        {'Choose which e-mail you get from us, download your e-mail data, or stop all optional e-mail.'|i18n( 'design/standard/mailpreferences' )}
{/if}
    </p>
{if $mp_signed_in}
    <a class="btn btn-secondary" href={'mailpreferences/settings'|ezurl}>{'Open my e-mail preferences'|i18n( 'design/standard/mailpreferences' )}</a>
{else}
    <a class="btn btn-secondary" href={'mailpreferences/request'|ezurl}>{'Manage my e-mail without an account'|i18n( 'design/standard/mailpreferences' )}</a>
{/if}
</div>
{undef $mp_context $mp_signed_in}
