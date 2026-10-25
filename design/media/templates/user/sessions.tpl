{* "Your devices" (user/sessions) in the media design: the design's page header, then the account cards of
   user/edit -- the sessions signed in now (this device first, each with "Sign out this session"), "Sign out all
   other sessions", the "New sign-in" e-mail switch and the sessions that ended lately.

   The form, its token and the button names are those the view reads (SessionsToken, RevokeSessionButton,
   RevokeOthersButton, SignInMail, SaveMailButton); the texts are those of design/standard/templates/user/sessions.tpl,
   which this page replaces only for its look. Variables: see design/admin4/templates/user/sessions.tpl.
   Drawn by stylesheets/account.css (.acc-sessions). Guide: doc/eng-us/guides/your-devices-and-sessions.md *}
{def $device_names = hash( 'desktop', 'Computer'|i18n( 'design/standard/user/sessions' ), 'mobile', 'Phone'|i18n( 'design/standard/user/sessions' ),
                           'tablet', 'Tablet'|i18n( 'design/standard/user/sessions' ), 'app', 'Program or app'|i18n( 'design/standard/user/sessions' ),
                           'bot', 'Automated client'|i18n( 'design/standard/user/sessions' ), 'unknown', 'Unknown device'|i18n( 'design/standard/user/sessions' ) )
     $methods = hash( 'password', 'Password'|i18n( 'design/standard/user/sessions' ),
                      'two_factor', 'Password and two-step code'|i18n( 'design/standard/user/sessions' ),
                      'rest', 'REST interface'|i18n( 'design/standard/user/sessions' ), 'soap', 'SOAP interface'|i18n( 'design/standard/user/sessions' ),
                      'webdav', 'WebDAV'|i18n( 'design/standard/user/sessions' ), 'single_sign_on', 'Single sign-on'|i18n( 'design/standard/user/sessions' ),
                      'unknown', 'Signed in before sessions were recorded'|i18n( 'design/standard/user/sessions' ) )
     $reasons = hash( 'signout', 'Signed out'|i18n( 'design/standard/user/sessions' ), 'revoked', 'Signed out from this page'|i18n( 'design/standard/user/sessions' ),
                      'revoked_admin', 'Signed out by an administrator'|i18n( 'design/standard/user/sessions' ),
                      'revoked_others', 'Signed out with "all other sessions"'|i18n( 'design/standard/user/sessions' ),
                      'replaced', 'Replaced by a new sign-in'|i18n( 'design/standard/user/sessions' ),
                      'password_change', 'Ended by a password change'|i18n( 'design/standard/user/sessions' ),
                      'expired', 'Expired'|i18n( 'design/standard/user/sessions' ) )
     $levels = hash( 'ok', 'success', 'info', 'info', 'warn', 'warning', 'bad', 'error' )
     $others = 0}
{foreach $sessions_active as $s}{if $s.current|not}{set $others = inc( $others )}{/if}{/foreach}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{if $sessions_own}{'Your devices'|i18n( 'design/standard/user/sessions' )}{else}{'Sessions of %name'|i18n( 'design/standard/user/sessions',, hash( '%name', $sessions_user_name ) )|wash}{/if}</h1>
        <p class="full-page-header-text">{if $sessions_own}{'Where your account is signed in right now. If you do not recognize a device, sign it out and change your password.'|i18n( 'design/standard/user/sessions' )}{else}{'Where this account is signed in right now. Signing the user out ends every session at its next request.'|i18n( 'design/standard/user/sessions' )}{/if}</p>
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container acc acc-sessions" id="exp-user-sessions">
        {if $sessions_own}<p class="acc-crumb"><a href={'user/edit'|ezurl}>{'My account'|i18n( 'design/standard/user/passkeys' )}</a></p>{/if}

        {if $sessions_message}
        <div class="acc-notice {first_set( $levels[$sessions_message.level], 'info' )}" role="status"><p>{switch match=$sessions_message.key}
        {case match='revoked'}{'The session was signed out. The device has to sign in again.'|i18n( 'design/standard/user/sessions' )}{/case}
        {case match='revoked_others'}{if $sessions_message.count|gt( 0 )}{'%count other sessions were signed out.'|i18n( 'design/standard/user/sessions',, hash( '%count', $sessions_message.count ) )}{else}{'There were no other sessions to sign out.'|i18n( 'design/standard/user/sessions' )}{/if}{/case}
        {case match='revoked_all'}{if $sessions_message.count|gt( 0 )}{'%count sessions of this user were signed out.'|i18n( 'design/standard/user/sessions',, hash( '%count', $sessions_message.count ) )}{else}{'This user had no sessions to sign out.'|i18n( 'design/standard/user/sessions' )}{/if}{/case}
        {case match='current'}{'This is the session you are using. To end it, sign out.'|i18n( 'design/standard/user/sessions' )}{/case}
        {case match='not_found'}{'That session had already ended.'|i18n( 'design/standard/user/sessions' )}{/case}
        {case match='mail_on'}{'You will get an e-mail when your account signs in from a new device.'|i18n( 'design/standard/user/sessions' )}{/case}
        {case match='mail_off'}{'You will no longer get an e-mail about sign-ins from new devices.'|i18n( 'design/standard/user/sessions' )}{/case}
        {case match='token'}{'The page had expired. Nothing was changed; please try again.'|i18n( 'design/standard/user/sessions' )}{/case}
        {case}{/case}
        {/switch}</p></div>
        {/if}

        {if $sessions_enabled|not}
        <div class="acc-notice info" role="status"><p>{'Sessions are not recorded on this site.'|i18n( 'design/standard/user/sessions' )}</p></div>
        {elseif $sessions_available|not}
        <div class="acc-notice warning" role="status"><p>{'Sessions are not recorded yet: the site needs its database update.'|i18n( 'design/standard/user/sessions' )}</p></div>
        {else}

        <form method="post" action={$sessions_action|ezurl}>
            <input type="hidden" name="SessionsToken" value="{$sessions_form_token|wash}" />

            <section class="acc-card" aria-labelledby="us-active">
                <h2 id="us-active">{'Signed in now'|i18n( 'design/standard/user/sessions' )} <span class="acc-count">{$sessions_active|count}</span></h2>
                <ul class="acc-session-list">
                {foreach $sessions_active as $s}
                    <li class="acc-session{if $s.current} is-current{/if}" id="session-{$s.id}">
                        <h3>{$s.label|wash}{if $s.current} <span class="acc-badge">{'This device'|i18n( 'design/standard/user/sessions' )}</span>{/if}</h3>
                        <dl class="acc-facts">
                            <dt>{'Device'|i18n( 'design/standard/user/sessions' )}</dt><dd>{first_set( $device_names[$s.device], $s.device )|wash}</dd>
                            <dt>{'Address'|i18n( 'design/standard/user/sessions' )}</dt><dd>{$s.ip|wash}</dd>
                            <dt>{'Signed in'|i18n( 'design/standard/user/sessions' )}</dt><dd>{$s.created|l10n( 'shortdatetime' )} <span class="acc-muted">{first_set( $methods[$s.method], $s.method )|wash}</span></dd>
                            <dt>{'Last active'|i18n( 'design/standard/user/sessions' )}</dt><dd>{if $s.current}{'Now'|i18n( 'design/standard/user/sessions' )}{else}{$s.last_active|l10n( 'shortdatetime' )}{/if}</dd>
                            <dt>{'Stays signed in'|i18n( 'design/standard/user/sessions' )}</dt><dd>{if $s.remember_until}{'Remember me, until %date'|i18n( 'design/standard/user/sessions',, hash( '%date', $s.remember_until|l10n( 'shortdate' ) ) )|wash}{else}{'Until the browser is closed'|i18n( 'design/standard/user/sessions' )}{/if}</dd>
                        </dl>
                        {if $s.current}
                        <p class="acc-muted">{'To end this session, sign out.'|i18n( 'design/standard/user/sessions' )} <a href={'user/logout'|ezurl}>{'Sign out'|i18n( 'design/standard/user/sessions' )}</a></p>
                        {else}
                        <div class="acc-actions"><button type="submit" class="btn btn-outline acc-btn-danger" name="RevokeSessionButton" value="{$s.id}">{'Sign out this session'|i18n( 'design/standard/user/sessions' )}</button></div>
                        {/if}
                    </li>
                {/foreach}
                </ul>
                {if or( $others|gt( 0 ), $sessions_own|not )}
                <div class="acc-actions"><button type="submit" class="btn btn-outline acc-btn-danger" name="RevokeOthersButton" value="1">{if $sessions_own}{'Sign out all other sessions'|i18n( 'design/standard/user/sessions' )}{else}{'Sign out everywhere'|i18n( 'design/standard/user/sessions' )}{/if}</button></div>
                {/if}
            </section>

            {if and( $sessions_own, $sessions_mail_setting )}
            <section class="acc-card" aria-labelledby="us-mail">
                <h2 id="us-mail">{'Sign-in alerts'|i18n( 'design/standard/user/sessions' )}</h2>
                <p class="acc-check"><label><input type="checkbox" name="SignInMail" value="1"{if $sessions_mail} checked="checked"{/if} /> {'E-mail me when my account signs in from a new device or browser'|i18n( 'design/standard/user/sessions' )}</label></p>
                <div class="acc-actions"><button type="submit" class="btn btn-primary" name="SaveMailButton" value="1">{'Save'|i18n( 'design/standard/user/sessions' )}</button></div>
            </section>
            {/if}
        </form>

        <section class="acc-card" aria-labelledby="us-ended">
            <h2 id="us-ended">{'Recently ended'|i18n( 'design/standard/user/sessions' )}</h2>
            {if $sessions_ended|count}
            <div class="acc-table-wrap">
            <table class="acc-table">
                <thead><tr><th scope="col">{'Device'|i18n( 'design/standard/user/sessions' )}</th><th scope="col">{'Address'|i18n( 'design/standard/user/sessions' )}</th>
                    <th scope="col">{'Signed in'|i18n( 'design/standard/user/sessions' )}</th><th scope="col">{'Ended'|i18n( 'design/standard/user/sessions' )}</th>
                    <th scope="col">{'How'|i18n( 'design/standard/user/sessions' )}</th></tr></thead>
                <tbody>
                {foreach $sessions_ended as $s}
                <tr><td>{$s.label|wash}</td><td>{$s.ip|wash}</td><td>{$s.created|l10n( 'shortdatetime' )}</td>
                    <td>{if $s.ended}{$s.ended|l10n( 'shortdatetime' )}{else}{$s.last_active|l10n( 'shortdatetime' )}{/if}</td>
                    <td>{if $s.end_reason}{first_set( $reasons[$s.end_reason], $s.end_reason )|wash}{else}{'Expired'|i18n( 'design/standard/user/sessions' )}{/if}</td></tr>
                {/foreach}
                </tbody>
            </table>
            </div>
            {else}
            <p class="acc-muted">{'None in the last %days days.'|i18n( 'design/standard/user/sessions',, hash( '%days', $sessions_retention_days ) )}</p>
            {/if}
        </section>

        {/if}
    </div>
</div>
{undef $device_names $methods $reasons $levels $others}
