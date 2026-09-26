{* Forgotten password, in the media design (the kernel asks for
   user/forgotpassword.tpl; forgot_password.tpl beside this is an unconverted
   port and is never loaded).

   An unknown address is answered exactly as a known one: "if an account uses
   it, a link is on its way". The stock page said "There is no registered user
   with that email address", which told anyone whether an address has an
   account here. *}
<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">
        {if or( $link, $wrong_email )}{'Check your email'|i18n( 'design/media/user' )}
        {elseif $generated}{'Your new password is on its way'|i18n( 'design/media/user' )}
        {elseif $wrong_key}{'This link can\'t be used'|i18n( 'design/media/user' )}
        {else}{'Forgotten your password?'|i18n( 'design/media/user' )}{/if}
        </h1>
    </div>
</header>

<div class="full-form-content">
    <div class="container">
    {if or( $link, $wrong_email )}
        {def $typed_email = cond( $link, $email, $wrong_email )}
        <div class="alert alert-success" role="status">
            <p>{'If an account uses %email, we have sent it a link to set a new password.'|i18n( 'design/media/user', '', hash( '%email', $typed_email|wash ) )}</p>
            <p>{'The link works once. Nothing there after a few minutes? Check your spam folder, or make sure the address is the one you signed up with and ask again.'|i18n( 'design/media/user' )}</p>
        </div>
        <p class="text-center">
            <a class="btn btn-primary" href={'/user/login'|ezurl}>{'Back to sign in'|i18n( 'design/media/user' )}</a>
            <a class="btn btn-secondary" href={'/user/forgotpassword'|ezurl}>{'Try another address'|i18n( 'design/media/user' )}</a>
        </p>
        {undef $typed_email}
    {elseif $generated}
        <div class="alert alert-success" role="status">
            <p>{'We have emailed a new password to %email. Sign in with it, then change it to one of your own from your account page.'|i18n( 'design/media/user', '', hash( '%email', $email|wash ) )}</p>
        </div>
        <p class="text-center"><a class="btn btn-primary" href={'/user/login'|ezurl}>{'Sign in'|i18n( 'design/media/user' )}</a></p>
    {else}
        {if $wrong_key}
        <div class="alert alert-danger" role="alert">
            <p>{'Password links work only once and only for a while, and this one has been used or has run out. Ask for a new one below; it takes a moment.'|i18n( 'design/media/user' )}</p>
        </div>
        {else}
        <p class="text-center">{'Enter the email address you signed up with and we will send you a link to set a new password.'|i18n( 'design/media/user' )}</p>
        {/if}
        <form method="post" name="forgotpassword" action={'/user/forgotpassword/'|ezurl} class="embed-form">
            <div class="form-wrapper">
                <div class="form-group">
                    <label for="forgotpassword-email" class="form-label required">{'Email address'|i18n( 'design/media/user' )}</label>
                    <input id="forgotpassword-email" class="form-control" type="email" name="UserEmail" autocomplete="email" required />
                </div>
                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" name="GenerateButton" value="{'Send me a link'|i18n( 'design/media/user' )}" />
                </div>
                <p><a href={'/user/login'|ezurl}>{'Remembered it? Sign in'|i18n( 'design/media/user' )}</a></p>
            </div>
        </form>
    {/if}
    </div>
</div>
