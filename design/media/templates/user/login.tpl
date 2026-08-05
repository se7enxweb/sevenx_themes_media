{* eZ Publish compatible login.tpl for the media design *}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{"Login"|i18n("design/standard/user")}</h1>
    </div>
</header>

<div class="full-form-content">
    <div class="container">
        {if $User:warning.bad_login}
        <div class="alert alert-danger">
            <h2>{"Could not login"|i18n("design/standard/user")}</h2>
            <p>{"A valid username and password is required to login."|i18n("design/standard/user")}</p>
        </div>
        {/if}

        {if $site_access.allowed|not}
        <div class="alert alert-danger">
            <h2>{"Access not allowed"|i18n("design/standard/user")}</h2>
            <p>{"You are not allowed to access %1."|i18n("design/standard/user",,array($site_access.name))}</p>
        </div>
        {/if}

        <form name="loginform" method="post" action={"/user/login/"|ezurl} role="form" class="embed-form">
            <div class="form-wrapper">
                <div class="form-group">
                    <label for="id1" class="form-label required">{"Username"|i18n("design/standard/user",'User name')}</label>
                    <input class="form-control" type="text" size="10" name="Login" id="id1" value="{$User:login|wash}" tabindex="1" />
                </div>

                <div class="form-group">
                    <label for="id2" class="form-label required">{"Password"|i18n("design/standard/user")}</label>
                    <input class="form-control" type="password" size="10" name="Password" id="id2" value="" tabindex="1" />
                </div>

                {if and( ezini_hasvariable( 'Session', 'RememberMeTimeout' ), ezini( 'Session', 'RememberMeTimeout' ) )}
                <div class="form-group">
                    <input type="checkbox" tabindex="1" name="Cookie" id="id3" />
                    <label for="id3" style="display:inline;">{"Remember me"|i18n("design/standard/user")}</label>
                </div>
                {/if}

                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" name="LoginButton" value="{'Login'|i18n('design/standard/user','Button')}" tabindex="1" />
                    <input class="btn btn-secondary" type="submit" name="RegisterButton" value="{'Sign Up'|i18n('design/standard/user','Button')}" tabindex="1" />
                </div>

                <p class="text-center note mt-5">
                    <a href={'/user/forgotpassword'|ezurl}>{'Forgot your password?'|i18n("design/standard/user")}</a>
                </p>

                <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />

                {section show=and( is_set( $User:post_data ), is_array( $User:post_data ) )}
                    {section name=postData loop=$User:post_data}
                    <input name="Last_{$postData:key|wash}" value="{$postData:item|wash}" type="hidden" />
                    {/section}
                {/section}
            </div>
        </form>
    </div>
</div>
