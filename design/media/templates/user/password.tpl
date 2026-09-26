{* Change password, in the media design. Every problem is said in plain words
   beside what to do about it, all of them at once, and the typed passwords are
   never written back into the page (the stock template put all three into
   the form's value attributes, and so into the HTML). *}
{def $min_length = cond( ezini_hasvariable( 'UserSettings', 'MinPasswordLength' ), ezini( 'UserSettings', 'MinPasswordLength' ), 3 )
     $has_problem = or( $oldPasswordNotValid, $newPasswordNotMatch, $newPasswordTooShort )}
<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Change your password'|i18n( 'design/media/user' )}</h1>
    </div>
</header>

<div class="full-form-content">
    <div class="container">
    {if and( $message, $has_problem )}
        <div class="alert alert-danger" role="alert">
            <h2>{'Your password was not changed'|i18n( 'design/media/user' )}</h2>
            <ul>
            {if $oldPasswordNotValid}<li>{'Your current password is not right. Type it again; it is the one you signed in with.'|i18n( 'design/media/user' )}</li>{/if}
            {if $newPasswordNotMatch}<li>{'The two new passwords are not the same. Type the new password twice, exactly the same.'|i18n( 'design/media/user' )}</li>{/if}
            {if $newPasswordTooShort}<li>{'The new password is too short. Use at least %1 characters; a few words together are easy to remember and hard to guess.'|i18n( 'design/media/user', '', array( $min_length ) )}</li>{/if}
            </ul>
        </div>
    {elseif $message}
        <div class="alert alert-success" role="status">
            <h2>{'Your password has been changed'|i18n( 'design/media/user' )}</h2>
            <p>{'Use the new one the next time you sign in.'|i18n( 'design/media/user' )}</p>
        </div>
    {/if}

        <form action={concat( $module.functions.password.uri, '/', $userID )|ezurl} method="post" name="Password" class="embed-form">
            <div class="form-wrapper">
                <p>{'Signed in as %1.'|i18n( 'design/media/user', '', array( $userAccount.login|wash ) )}</p>
                <div class="form-group">
                    <label for="password-old" class="form-label required">{'Current password'|i18n( 'design/media/user' )}</label>
                    <input id="password-old" class="form-control{if $oldPasswordNotValid} is-invalid{/if}" type="password" name="oldPassword" autocomplete="current-password" required />
                </div>
                <div class="form-group">
                    <label for="password-new" class="form-label required">{'New password'|i18n( 'design/media/user' )}</label>
                    <input id="password-new" class="form-control{if or( $newPasswordNotMatch, $newPasswordTooShort )} is-invalid{/if}" type="password" name="newPassword" autocomplete="new-password" minlength="{$min_length}" required aria-describedby="password-new-help" />
                    <small id="password-new-help">{'At least %1 characters.'|i18n( 'design/media/user', '', array( $min_length ) )}</small>
                </div>
                <div class="form-group">
                    <label for="password-confirm" class="form-label required">{'New password again'|i18n( 'design/media/user' )}</label>
                    <input id="password-confirm" class="form-control{if $newPasswordNotMatch} is-invalid{/if}" type="password" name="confirmPassword" autocomplete="new-password" required />
                </div>
                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" name="OKButton" value="{'Change password'|i18n( 'design/media/user' )}" />
                    <input class="btn btn-secondary" type="submit" name="CancelButton" value="{'Cancel'|i18n( 'design/media/user' )}" formnovalidate />
                </div>
            </div>
        </form>
    </div>
</div>
{undef $min_length $has_problem}
