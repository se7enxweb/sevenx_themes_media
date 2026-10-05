{* Change password (user/password) in the media design: the design's page header and one account card with the
   current password, the new one with its requirements, the new one again, "Change password" and "Cancel". The
   field names, the form token and the button names are those the view reads (oldPassword, newPassword,
   confirmPassword, OKButton, CancelButton).

   Every problem is said next to its field (aria-describedby) and in a summary at the top of the form that links
   to the fields, all of them at once, and the first field with a problem gets the focus. The requirement list
   comes from the server, with the rules that failed marked. The kernel's script exp_password_field.js
   (design/standard) makes it live when it runs: checklist, strength meter, show/hide, "passwords match",
   "Generate a strong password". Every control it needs is in the markup with the hidden attribute, so without
   JavaScript none is shown.

   The typed passwords are never written back into the page. On a kernel older than the modern password page
   (no $field_errors) the old flags become the same inline errors and the script is not loaded.
   Drawn by stylesheets/account.css. *}
{if is_set( $field_errors )}
    {def $pw_errors = $field_errors
         $pw_rules = $password_rules
         $pw_min = $min_length
         $pw_t = $password_js_config.i18n
         $pw_changed = $password_changed
         $pw_modern = true()}
{else}
    {def $pw_min = cond( ezini_hasvariable( 'UserSettings', 'MinPasswordLength' ), ezini( 'UserSettings', 'MinPasswordLength' ), 3 )
         $pw_errors = hash( 'oldPassword', cond( $oldPasswordNotValid, array( 'Your current password is not right. Type it again; it is the one you signed in with.'|i18n( 'design/media/user' ) ), array() ),
                            'newPassword', cond( $newPasswordTooShort, array( 'The new password is too short. Use at least %1 characters; a few words together are easy to remember and hard to guess.'|i18n( 'design/media/user', '', array( $pw_min ) ) ), array() ),
                            'confirmPassword', cond( $newPasswordNotMatch, array( 'The two new passwords are not the same. Type the new password twice, exactly the same.'|i18n( 'design/media/user' ) ), array() ) )
         $pw_rules = array( hash( 'id', 'length', 'min', $pw_min, 'failed', $newPasswordTooShort, 'text', 'At least %1 characters.'|i18n( 'design/media/user', '', array( $pw_min ) ) ) )
         $pw_t = hash( 'show', '', 'ruleUnmet', '', 'strength', '' )
         $pw_changed = and( $message, not( or( $oldPasswordNotValid, $newPasswordNotMatch, $newPasswordTooShort ) ) )
         $pw_modern = false()}
{/if}
{def $pw_ids = hash( 'oldPassword', 'password-old', 'newPassword', 'password-new', 'confirmPassword', 'password-confirm' )
     $pw_first_error = cond( $pw_errors.oldPassword|count, 'password-old', $pw_errors.newPassword|count, 'password-new',
                             $pw_errors.confirmPassword|count, 'password-confirm', '' )}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Change your password'|i18n( 'design/media/user' )}</h1>
    </div>
</header>

<div class="full-form-content acc-content">
    <div class="container acc acc-pw">
    {if $pw_changed}
        <div class="acc-notice success" role="status">
            <div>
                <h2>{'Your password has been changed'|i18n( 'design/media/user' )}</h2>
                <p>{'You are still signed in here. Use the new password the next time you sign in.'|i18n( 'design/media/user' )}</p>
                {if or( and( is_set( $other_sessions_signed_out ), $other_sessions_signed_out ), and( is_set( $sessions_ended ), $sessions_ended|gt( 0 ) ) )}<p>{'You were signed out on your other devices.'|i18n( 'design/media/user' )}</p>{/if}
                {if and( is_set( $notification_sent ), $notification_sent )}<p>{'We sent a confirmation to your e-mail address.'|i18n( 'design/media/user' )}</p>{/if}
            </div>
        </div>
        <div class="acc-actions">
            <a class="btn btn-primary" href={cond( is_set( $redirect_uri ), $redirect_uri, '/user/edit' )|ezurl}>{'Continue'|i18n( 'design/media/user' )}</a>
            <a class="btn btn-outline" href={'/user/edit'|ezurl}>{'My profile'|i18n( 'design/media/user' )}</a>
        </div>
    {else}
        <form action={concat( $module.functions.password.uri, '/', $userID )|ezurl} method="post" name="Password" class="embed-form" novalidate{if $pw_modern} data-exp-password-form data-exp-password-config="{$password_js_config_json|wash}"{/if}>
        {if $pw_first_error}
            <div class="acc-notice error acc-pw-summary" id="password-error-summary" role="alert" tabindex="-1" aria-labelledby="password-error-summary-title" data-exp-password-summary>
                <div>
                    <h2 id="password-error-summary-title">{'Your password was not changed'|i18n( 'design/media/user' )}</h2>
                    <ul>
                    {foreach $pw_ids as $pw_field => $pw_id}{foreach $pw_errors[$pw_field] as $pw_text}
                        <li><a href="#{$pw_id}">{$pw_text|wash}</a></li>
                    {/foreach}{/foreach}
                    </ul>
                </div>
            </div>
        {elseif and( is_set( $error_summary ), $error_summary|count )}
            <div class="acc-notice error acc-pw-summary" id="password-error-summary" role="alert" tabindex="-1" data-exp-password-summary>
                <div>
                    <h2>{'Your password was not changed'|i18n( 'design/media/user' )}</h2>
                    <ul>{foreach $error_summary as $pw_error}<li>{$pw_error.text|wash}</li>{/foreach}</ul>
                </div>
            </div>
        {/if}
            <div class="acc-card">
                <p class="acc-lead">{'Signed in as %1.'|i18n( 'design/media/user', '', array( $userAccount.login|wash ) )}</p>

                <div class="form-group acc-pw-field{if $pw_errors.oldPassword|count} has-error{/if}">
                    <label for="password-old" class="form-label required">{'Current password'|i18n( 'design/media/user' )}</label>
                    {if $pw_errors.oldPassword|count}<p class="acc-pw-error" id="password-old-error">{foreach $pw_errors.oldPassword as $pw_text}<span>{$pw_text|wash}</span>{/foreach}</p>{/if}
                    <div class="acc-pw-row">
                        <input id="password-old" class="form-control{if $pw_errors.oldPassword|count} is-invalid{/if}" type="password" name="oldPassword" autocomplete="current-password" required data-exp-password="current"{if $pw_errors.oldPassword|count} aria-invalid="true" aria-describedby="password-old-error"{/if}{if eq( $pw_first_error, 'password-old' )} autofocus{/if} />
                        {if $pw_modern}<button type="button" class="btn btn-outline acc-pw-toggle" aria-controls="password-old" aria-pressed="false" data-exp-password-toggle="password-old" hidden><span data-exp-password-toggle-text>{$pw_t.show|wash}</span><span class="visually-hidden"> {'current password'|i18n( 'design/media/user' )}</span></button>{/if}
                    </div>
                </div>

                <div class="form-group acc-pw-field{if $pw_errors.newPassword|count} has-error{/if}">
                    <label for="password-new" class="form-label required">{'New password'|i18n( 'design/media/user' )}</label>
                    {if $pw_errors.newPassword|count}<p class="acc-pw-error" id="password-new-error">{foreach $pw_errors.newPassword as $pw_text}<span>{$pw_text|wash}</span>{/foreach}</p>{/if}
                    <div class="acc-pw-row">
                        <input id="password-new" class="form-control{if $pw_errors.newPassword|count} is-invalid{/if}" type="password" name="newPassword" autocomplete="new-password" required minlength="{$pw_min}" data-exp-password="new" aria-describedby="{if $pw_errors.newPassword|count}password-new-error {/if}password-new-rules"{if $pw_errors.newPassword|count} aria-invalid="true"{/if}{if eq( $pw_first_error, 'password-new' )} autofocus{/if} />
                        {if $pw_modern}<button type="button" class="btn btn-outline acc-pw-toggle" aria-controls="password-new" aria-pressed="false" data-exp-password-toggle="password-new" hidden><span data-exp-password-toggle-text>{$pw_t.show|wash}</span><span class="visually-hidden"> {'new password'|i18n( 'design/media/user' )}</span></button>{/if}
                    </div>
                    <p class="acc-pw-rules-title" id="password-new-rules-title">{'Your new password needs:'|i18n( 'design/media/user' )}</p>
                    <ul class="acc-pw-rules" id="password-new-rules" aria-labelledby="password-new-rules-title" data-exp-password-rules>
                    {foreach $pw_rules as $pw_rule}
                        <li data-exp-password-rule="{$pw_rule.id|wash}"{if $pw_rule.failed} data-state="unmet" data-failed="true"{/if}>{$pw_rule.text|wash}<span class="visually-hidden">, </span><span class="visually-hidden" data-exp-password-rule-state>{if $pw_rule.failed}{$pw_t.ruleUnmet|wash}{/if}</span></li>
                    {/foreach}
                    </ul>
                    {if $pw_modern}
                    <div class="acc-pw-meter" data-exp-password-meter hidden>
                        <span class="acc-pw-meter-caption">{$pw_t.strength|wash}:</span>
                        <span class="acc-pw-meter-bar" aria-hidden="true"><span></span></span>
                        <span class="acc-pw-meter-text" data-exp-password-meter-text aria-live="polite"></span>
                    </div>
                    <p class="acc-pw-generate"><button type="button" class="btn btn-outline btn-sm-acc" data-exp-password-generate hidden>{'Generate a strong password'|i18n( 'design/media/user' )}</button></p>
                    <p class="acc-pw-status" data-exp-password-status role="status" hidden></p>
                    {/if}
                </div>

                <div class="form-group acc-pw-field{if $pw_errors.confirmPassword|count} has-error{/if}">
                    <label for="password-confirm" class="form-label required">{'New password again'|i18n( 'design/media/user' )}</label>
                    {if $pw_errors.confirmPassword|count}<p class="acc-pw-error" id="password-confirm-error">{foreach $pw_errors.confirmPassword as $pw_text}<span>{$pw_text|wash}</span>{/foreach}</p>{/if}
                    <div class="acc-pw-row">
                        <input id="password-confirm" class="form-control{if $pw_errors.confirmPassword|count} is-invalid{/if}" type="password" name="confirmPassword" autocomplete="new-password" required data-exp-password="confirm"{if $pw_errors.confirmPassword|count} aria-invalid="true" aria-describedby="password-confirm-error"{/if}{if eq( $pw_first_error, 'password-confirm' )} autofocus{/if} />
                        {if $pw_modern}<button type="button" class="btn btn-outline acc-pw-toggle" aria-controls="password-confirm" aria-pressed="false" data-exp-password-toggle="password-confirm" hidden><span data-exp-password-toggle-text>{$pw_t.show|wash}</span><span class="visually-hidden"> {'new password again'|i18n( 'design/media/user' )}</span></button>{/if}
                    </div>
                    {if $pw_modern}<p class="acc-pw-match" data-exp-password-match aria-live="polite" hidden></p>{/if}
                </div>

                <div class="acc-actions">
                    <input class="btn btn-primary" type="submit" name="OKButton" value="{'Change password'|i18n( 'design/media/user' )}" />
                    <input class="btn btn-outline" type="submit" name="CancelButton" value="{'Cancel'|i18n( 'design/media/user' )}" formnovalidate />
                </div>
            </div>
        </form>
        {if $pw_modern}{ezscript( array( 'exp_password_field.js' ) )}{/if}
    {/if}
    </div>
</div>
{undef $pw_errors $pw_rules $pw_min $pw_t $pw_changed $pw_modern $pw_ids $pw_first_error}
