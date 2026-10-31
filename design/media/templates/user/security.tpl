{* "Security activity" (user/security) in the media design: the design's page header, then the account cards of
   user/edit -- "Secure your account" on the own account, the counts of the last days, the filter, the events newest
   first with "Was this you?" on the ones that need attention, the paging and "Download my sign-in data".

   The forms, their token and the button names are those the view reads (SecurityToken, SecureButton,
   ConfirmEventButton, DownloadButton); the texts are those of design/standard/templates/user/security.tpl, which this
   page replaces only for its look, so it follows the site's own light and dark modes instead of the system's.
   Variables: see design/admin4/templates/user/security.tpl. Drawn by stylesheets/account.css (.acc-security).
   Guide: doc/eng-us/guides/your-devices-and-sessions.md *}
{def $kinds = hash(
        'signin', 'Signed in'|i18n( 'design/standard/user/security' ),
        'signin_failed', 'Failed sign-in attempt'|i18n( 'design/standard/user/security' ),
        'signout', 'Signed out'|i18n( 'design/standard/user/security' ),
        'revoke', 'Sessions signed out'|i18n( 'design/standard/user/security' ),
        'new_device', 'Sign-in from a new device'|i18n( 'design/standard/user/security' ),
        'new_location', 'Sign-in from a new location'|i18n( 'design/standard/user/security' ),
        'reauth', 'Identity confirmed ("Verify it is you")'|i18n( 'design/standard/user/security' ),
        'reauth_failed', 'Identity check failed'|i18n( 'design/standard/user/security' ),
        'passkey_use', 'Signed in with a passkey'|i18n( 'design/standard/user/security' ),
        'passkey_failed', 'Passkey sign-in failed'|i18n( 'design/standard/user/security' ),
        'second_factor_refused', 'Sign-in refused: two-step code missing or wrong'|i18n( 'design/standard/user/security' ),
        'twofactor_failed', 'Wrong two-step code'|i18n( 'design/standard/user/security' ),
        'locked', 'Account locked after failed sign-ins'|i18n( 'design/standard/user/security' ),
        'unlocked', 'Account unlocked'|i18n( 'design/standard/user/security' ),
        'password_change', 'Password changed'|i18n( 'design/standard/user/security' ),
        'password_change_failed', 'Password change failed'|i18n( 'design/standard/user/security' ),
        'password_reset', 'Password reset'|i18n( 'design/standard/user/security' ),
        'password_reset_request', 'New password requested'|i18n( 'design/standard/user/security' ),
        'email_change', 'E-mail address changed'|i18n( 'design/standard/user/security' ),
        'login_change', 'Username changed'|i18n( 'design/standard/user/security' ),
        'twofactor_on', 'Two-step sign-in turned on'|i18n( 'design/standard/user/security' ),
        'twofactor_off', 'Two-step sign-in turned off'|i18n( 'design/standard/user/security' ),
        'recovery_used', 'Recovery code used'|i18n( 'design/standard/user/security' ),
        'recovery_issued', 'New recovery codes'|i18n( 'design/standard/user/security' ),
        'app_password_create', 'App password created'|i18n( 'design/standard/user/security' ),
        'app_password_revoke', 'App password revoked'|i18n( 'design/standard/user/security' ),
        'passkey_add', 'Passkey added'|i18n( 'design/standard/user/security' ),
        'passkey_remove', 'Passkey removed'|i18n( 'design/standard/user/security' ),
        'enabled', 'Account enabled'|i18n( 'design/standard/user/security' ),
        'disabled', 'Account disabled'|i18n( 'design/standard/user/security' ) )
     $filter_names = hash( 'all', 'All'|i18n( 'design/standard/user/security' ), 'signin', 'Sign-ins and sessions'|i18n( 'design/standard/user/security' ),
                           'account', 'Account changes'|i18n( 'design/standard/user/security' ), 'problems', 'Needs attention'|i18n( 'design/standard/user/security' ) )
     $levels = hash( 'ok', 'success', 'info', 'info', 'warn', 'warning', 'bad', 'error' )}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{if $security_own}{'Security activity'|i18n( 'design/standard/user/security' )}{else}{'Security activity of %name'|i18n( 'design/standard/user/security',, hash( '%name', $security_user_name ) )|wash}{/if}</h1>
        <p class="full-page-header-text">{'Sign-ins and changes to the security of your account. If you see something you did not do, change your password and sign out the devices you do not recognize.'|i18n( 'design/standard/user/security' )}</p>
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container acc acc-security" id="exp-user-security">
        <ul class="acc-crumb acc-sec-links">
            {if $security_own}<li><a href={'user/edit'|ezurl}>{'My account'|i18n( 'design/standard/user/passkeys' )}</a></li>{/if}
            <li><a href={cond( $security_own, 'user/sessions', concat( 'user/sessions/', $security_user_id ) )|ezurl}>{'Your devices'|i18n( 'design/standard/user/security' )}</a></li>
            {if $security_own}<li><a href={'user/password'|ezurl}>{'Change password'|i18n( 'design/standard/user/security' )}</a></li>{/if}
        </ul>

        {if $security_message}
        <div class="acc-notice {first_set( $levels[$security_message.level], 'info' )}" role="status"><p>{switch match=$security_message.key}
        {case match='secured'}{if $security_message.tracked|not}{'Sessions are not recorded on this site, so no other device could be signed out. Change your password now.'|i18n( 'design/standard/user/security' )}{elseif $security_message.count|gt( 0 )}{'%count other sessions were signed out. Now change your password.'|i18n( 'design/standard/user/security',, hash( '%count', $security_message.count ) )}{else}{'No other device was signed in. Now change your password.'|i18n( 'design/standard/user/security' )}{/if}{/case}
        {case match='confirmed'}{'Thank you. The event is marked as yours.'|i18n( 'design/standard/user/security' )}{/case}
        {case match='not_found'}{'That event needs no answer.'|i18n( 'design/standard/user/security' )}{/case}
        {case match='token'}{'The page had expired. Nothing was changed; please try again.'|i18n( 'design/standard/user/security' )}{/case}
        {case}{/case}
        {/switch}</p>
        {if eq( $security_message.key, 'secured' )}<p><a class="btn btn-primary" href={'user/password'|ezurl}>{'Change password'|i18n( 'design/standard/user/security' )}</a></p>{/if}
        </div>
        {/if}

        {if $security_own}
        <section class="acc-card acc-sec-secure{if $security_secure} is-current{/if}" id="secure" aria-labelledby="sec-secure">
            <h2 id="sec-secure">{'Secure your account'|i18n( 'design/standard/user/security' )}</h2>
            <p class="acc-lead">{'If something here was not you, sign out every other device, then choose a new password. Devices kept signed in with Remember me are signed out too.'|i18n( 'design/standard/user/security' )}</p>
            <form method="post" action={'user/security'|ezurl}>
                <input type="hidden" name="SecurityToken" value="{$security_form_token|wash}" />
                <div class="acc-actions"><button type="submit" class="btn btn-outline acc-btn-danger" name="SecureButton" value="1">{'Yes, sign out the other devices'|i18n( 'design/standard/user/security' )}</button></div>
            </form>
        </section>
        {/if}

        {if $security_available|not}
        <div class="acc-notice warning" role="status"><p>{'The security activity is not recorded on this site yet.'|i18n( 'design/standard/user/security' )}</p></div>
        {else}

        <ul class="acc-figures">
            <li class="acc-figure"><strong>{$security_summary.signins}</strong> <span>{'Sign-ins in the last %days days'|i18n( 'design/standard/user/security',, hash( '%days', $security_summary.days ) )}</span></li>
            <li class="acc-figure{if $security_summary.failures|gt( 0 )} is-bad{/if}"><strong>{$security_summary.failures}</strong> <span>{'Failed attempts'|i18n( 'design/standard/user/security' )}</span></li>
            <li class="acc-figure"><strong>{$security_summary.changes}</strong> <span>{'Account changes'|i18n( 'design/standard/user/security' )}</span></li>
        </ul>

        <section class="acc-card" aria-labelledby="sec-events">
            <h2 id="sec-events">{if $security_own}{'Security activity'|i18n( 'design/standard/user/security' )}{else}{'Security activity of %name'|i18n( 'design/standard/user/security',, hash( '%name', $security_user_name ) )|wash}{/if}</h2>
            <ul class="acc-tabs">
            {foreach $security_filters as $f}
                <li>{if eq( $f, $security_filter )}<span class="current" aria-current="true">{$filter_names[$f]|wash}</span>{else}<a href={concat( $security_action, cond( eq( $f, 'all' ), '', concat( '?filter=', $f ) ) )|ezurl}>{$filter_names[$f]|wash}</a>{/if}</li>
            {/foreach}
            </ul>

            {if $security_events|count}
            <ol class="acc-events">
            {foreach $security_events as $e}
                <li class="acc-event is-{$e.level|wash}">
                    <div class="acc-event-head">
                        <strong>{first_set( $kinds[$e.kind], $e.name )|wash}</strong>
                        <time datetime="{$e.time|datetime( 'custom', '%Y-%m-%dT%H:%i:%s' )|wash}">{$e.time|l10n( 'shortdatetime' )}</time>
                    </div>
                    <p class="acc-event-meta">{if $e.ip}<span>{$e.ip|wash}</span>{/if}{if is_set( $e.details.location )}<span>{$e.details.location|wash}</span>{/if}{if and( is_set( $e.details.browser ), is_set( $e.details.os ) )}<span>{$e.details.browser|wash}, {$e.details.os|wash}</span>{/if}</p>
                    {if is_set( $security_review[$e.id] )}
                    <form method="post" action={'user/security'|ezurl} class="acc-review">
                        <input type="hidden" name="SecurityToken" value="{$security_form_token|wash}" />
                        <p class="acc-review-question">{'Was this you?'|i18n( 'design/standard/user/security' )}</p>
                        <div class="acc-actions">
                            <button type="submit" class="btn btn-primary" name="ConfirmEventButton" value="{$e.id|wash}">{'Yes, it was me'|i18n( 'design/standard/user/security' )}</button>
                            <a class="btn btn-outline acc-btn-danger" href={'user/security/(secure)/1'|ezurl}>{'No, secure my account'|i18n( 'design/standard/user/security' )}</a>
                        </div>
                    </form>
                    {/if}
                </li>
            {/foreach}
            </ol>
            {include name=navigator uri='design:navigator/google.tpl' page_uri=concat( '/', $security_action )
                     page_uri_suffix=cond( eq( $security_filter, 'all' ), '', concat( '?filter=', $security_filter ) )
                     item_count=$security_count view_parameters=$view_parameters item_limit=$security_limit}
            {else}
            <p class="acc-muted">{'No security activity recorded yet.'|i18n( 'design/standard/user/security' )}</p>
            {/if}
        </section>

        {if $security_own}
        <form method="post" action={$security_action|ezurl} class="acc-card acc-sec-download">
            <p class="acc-muted">{'Your sessions and security events as a JSON file.'|i18n( 'design/standard/user/security' )}</p>
            <div class="acc-actions"><button type="submit" class="btn btn-outline" name="DownloadButton" value="1">{'Download my sign-in data'|i18n( 'design/standard/user/security' )}</button></div>
        </form>
        {/if}

        {/if}
    </div>
</div>
{undef $kinds $filter_names $levels}
