{* The passkeys of the signed-in user's own account (user/passkeys) in the media design: the design's page header,
   then the account cards of user/edit -- the passkeys with Rename and Remove (after a confirmation), and "Add a
   passkey" with a name (the browser's passkey dialog runs from design:javascript/exp_passkey.js).

   The forms, their fields and the button names are those the view reads (PasskeyID, PasskeyNewName, PasskeyName,
   RenamePasskeyButton, RemovePasskeyButton, ConfirmRemovePasskeyButton); the texts are those of
   design/standard/templates/user/passkeys.tpl, which this page replaces only for its look. Variables: available,
   switched_off, passkeys, can_add, max_per_user, options_json, default_name, message (kind, text), confirm_passkey,
   reauth_seconds. Drawn by stylesheets/account.css (.acc-passkeys). Guide: doc/eng-us/guides/passkeys.md *}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Passkeys'|i18n( 'design/standard/user/passkeys' )}</h1>
        <p class="full-page-header-text">{'A passkey signs you in with your fingerprint, face, screen lock or security key instead of your password. It is stored on your device or in your password manager; this site keeps only its public key, so a leak here cannot reveal it.'|i18n( 'design/standard/user/passkeys' )}</p>
    </div>
</header>

<div class="full-form-content acc-content">
    <div class="container acc acc-passkeys">
        <p class="acc-crumb"><a href={'user/edit'|ezurl}>{'My account'|i18n( 'design/standard/user/passkeys' )}</a></p>

        {if $message}
        <div class="acc-notice {if eq( $message.kind, 'ok' )}success{else}warning{/if}" role="status"><p>{$message.text|wash}</p></div>
        {/if}

        {if $available|not}
        <div class="acc-notice warning" role="status"><p>
            {if $switched_off}{'Passkeys are switched off on this site.'|i18n( 'design/standard/user/passkeys' )}
            {else}{'Passkeys cannot be used on this site yet: the administrator has to run the database update first.'|i18n( 'design/standard/user/passkeys' )}{/if}
        </p></div>
        {else}

        {if $confirm_passkey}
        <div class="acc-notice error" role="alert">
            <div>
                <h2>{'Remove the passkey "%name"?'|i18n( 'design/standard/user/passkeys',, hash( '%name', $confirm_passkey.name ) )|wash}</h2>
                <p>{'It can no longer sign in to this account. Remove it from your device or password manager as well.'|i18n( 'design/standard/user/passkeys' )}</p>
                <form method="post" action={'user/passkeys'|ezurl}>
                    <input type="hidden" name="PasskeyID" value="{$confirm_passkey.id}" />
                    <div class="acc-actions">
                        <button class="btn btn-outline acc-btn-danger" type="submit" name="ConfirmRemovePasskeyButton" value="1">{'Remove the passkey'|i18n( 'design/standard/user/passkeys' )}</button>
                        <a class="btn btn-outline" href={'user/passkeys'|ezurl}>{'Cancel'|i18n( 'design/standard/user/passkeys' )}</a>
                    </div>
                </form>
            </div>
        </div>
        {/if}

        <section class="acc-card" aria-labelledby="pk-list">
            <h2 id="pk-list">{'Your passkeys'|i18n( 'design/standard/user/passkeys' )}</h2>
            {if $passkeys|count|eq( 0 )}
            <p class="acc-lead">{'You have no passkey yet. Add one below: the next time you sign in, choose "Sign in with a passkey".'|i18n( 'design/standard/user/passkeys' )}</p>
            {else}
            <p class="acc-lead">{'%count of at most %max'|i18n( 'design/standard/user/passkeys',, hash( '%count', $passkeys|count, '%max', $max_per_user ) )}</p>
            <ul class="acc-session-list">
            {foreach $passkeys as $passkey}
                <li class="acc-session">
                    <h3>{$passkey.name|wash}</h3>
                    <dl class="acc-facts">
                        <dt>{'Added'|i18n( 'design/standard/user/passkeys' )}</dt><dd>{$passkey.created|l10n( 'shortdatetime' )}</dd>
                        <dt>{'Last used'|i18n( 'design/standard/user/passkeys' )}</dt><dd>{if $passkey.never_used}{'Not yet'|i18n( 'design/standard/user/passkeys' )}{else}{$passkey.last_used|l10n( 'shortdatetime' )}{/if}</dd>
                        <dt>{'Kind'|i18n( 'design/standard/user/passkeys' )}</dt><dd>{if $passkey.synced}{'Synced'|i18n( 'design/standard/user/passkeys' )}{else}{'This device or key'|i18n( 'design/standard/user/passkeys' )}{/if} <span class="acc-muted">({$passkey.algorithm_name|wash})</span></dd>
                    </dl>
                    <form method="post" action={'user/passkeys'|ezurl} class="acc-inline-form">
                        <input type="hidden" name="PasskeyID" value="{$passkey.id}" />
                        <label class="form-label" for="passkey-name-{$passkey.id}">{'New name'|i18n( 'design/standard/user/passkeys' )}</label>
                        <div class="acc-inline-row">
                            <input class="form-control" type="text" id="passkey-name-{$passkey.id}" name="PasskeyNewName" value="{$passkey.name|wash}" maxlength="100" />
                            <button class="btn btn-outline btn-sm-acc" type="submit" name="RenamePasskeyButton" value="1">{'Rename'|i18n( 'design/standard/user/passkeys' )}</button>
                            <button class="btn btn-outline btn-sm-acc acc-btn-danger" type="submit" name="RemovePasskeyButton" value="1">{'Remove'|i18n( 'design/standard/user/passkeys' )}</button>
                        </div>
                    </form>
                </li>
            {/foreach}
            </ul>
            {/if}
        </section>

        <section class="acc-card" aria-labelledby="pk-add">
            <h2 id="pk-add">{'Add a passkey'|i18n( 'design/standard/user/passkeys' )}</h2>
            {if $can_add}
            <form method="post" action={'user/passkeys'|ezurl} id="passkey-register" class="embed-form"
                  data-exp-passkey="register" data-exp-passkey-options="{$options_json|wash}"
                  data-msg-working="{'Follow the steps of your browser or device.'|i18n( 'design/standard/user/passkeys' )|wash}"
                  data-msg-cancelled="{'The passkey dialog was closed. Nothing was changed.'|i18n( 'design/standard/user/passkeys' )|wash}"
                  data-msg-failed="{'The passkey could not be made. Please try again.'|i18n( 'design/standard/user/passkeys' )|wash}"
                  data-msg-unsupported="{'This browser cannot make passkeys. Use a current browser, or sign in with your password.'|i18n( 'design/standard/user/passkeys' )|wash}">
                <div class="form-group">
                    <label class="form-label" for="passkey-new-name">{'Name'|i18n( 'design/standard/user/passkeys' )}</label>
                    <input class="form-control" type="text" id="passkey-new-name" name="PasskeyName" value="" maxlength="100" placeholder="{$default_name|wash}" aria-describedby="passkey-new-name-hint" />
                    <p class="acc-muted acc-hint" id="passkey-new-name-hint">{'For example the device or password manager it is on, so you can tell your passkeys apart.'|i18n( 'design/standard/user/passkeys' )}</p>
                </div>
                <div class="acc-actions">
                    <button class="btn btn-primary" type="button" data-exp-passkey-start="1" data-exp-passkey-only="1" hidden="hidden">{'Add a passkey'|i18n( 'design/standard/user/passkeys' )}</button>
                </div>
                <p class="acc-passkey-status" data-exp-passkey-status="1" role="status" aria-live="polite" hidden="hidden"></p>
            </form>
            {else}
            <p class="acc-lead">{'This account has as many passkeys as it may have (%max). Remove one to add another.'|i18n( 'design/standard/user/passkeys',, hash( '%max', $max_per_user ) )}</p>
            {/if}
        </section>
        {/if}
    </div>
</div>
<script src={'javascript/exp_passkey.js'|ezdesign} defer="defer"></script>
