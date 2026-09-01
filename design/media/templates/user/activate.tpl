{* eZ Publish compatible activate.tpl for the media design *}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{"Activate account"|i18n("design/standard/user")}</h1>
    </div>
</header>

<div class="full-form-content">
    <div class="container">
        <div class="full-form-response">
            {if $account_activated}
                {if $is_pending}
                    <p>{'Your email address has been confirmed. An administrator needs to approve your sign up request, before your login becomes valid.'|i18n('design/standard/user')}</p>
                {else}
                    <p>{'Your account is now activated.'|i18n('design/standard/user')}</p>
                {/if}
            {elseif $already_active}
                <p>{'Your account is already active.'|i18n('design/standard/user')}</p>
            {else}
                <p>{'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n('design/standard/user')}</p>
            {/if}

            <form action={"/user/login"|ezurl} method="post" class="embed-form">
                <input class="btn btn-primary" type="submit" value="{'OK'|i18n('design/standard/user')}" />
            </form>
        </div>
    </div>
</div>
