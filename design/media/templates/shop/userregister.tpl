{* Checkout account information, styled to match user/register.tpl in this
   design: full-page-header + full-form-content + form-group/form-control.

   Field names follow kernel/shop/userregister.php:
     - the address line posts as City; the module accepts Place too, so an
       older template that still posts Place keeps working
     - Phone is validated only when the form posts it, which this one does
     - Street1 (not Street2), Zip, City, Country, FirstName, LastName and
       EMail are required by the module, so they carry *
*}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{"Your account information"|i18n("design/ezwebin/shop/userregister")}</h1>
        {* Laid out inline here rather than with a framework list class: this
           design does not define one, and an unstyled <ol> stacks the steps. *}
        <ol class="checkout-steps" style="list-style:none;margin:0;padding:0;">
            <li style="display:inline-block;margin:0 .75rem;opacity:.6;">1. {"Shopping basket"|i18n("design/ezwebin/shop/userregister")}</li>
            <li style="display:inline-block;margin:0 .75rem;font-weight:700;" class="selected active">2. {"Account information"|i18n("design/ezwebin/shop/userregister")}</li>
            <li style="display:inline-block;margin:0 .75rem;opacity:.6;">3. {"Confirm order"|i18n("design/ezwebin/shop/userregister")}</li>
        </ol>
    </div>
</header>

<div class="full-form-content">
    <div class="container">

        {section show=$input_error}
            <div class="alert alert-danger">
                <h2>{"Input did not validate. All fields marked with * must be filled in."|i18n("design/ezwebin/shop/userregister")}</h2>
            </div>
        {/section}

        <form method="post" action={"/shop/userregister/"|ezurl} name="ShopUserRegister" class="embed-form">
            <div class="form-wrapper">

                <div class="form-group">
                    <label for="FirstName" class="form-label">{"First name"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="text" id="FirstName" name="FirstName" value="{$first_name|wash}" />
                </div>

                <div class="form-group">
                    <label for="LastName" class="form-label">{"Last name"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="text" id="LastName" name="LastName" value="{$last_name|wash}" />
                </div>

                <div class="form-group">
                    <label for="EMail" class="form-label">{"E-mail"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="email" id="EMail" name="EMail" value="{$email|wash}" />
                </div>

                <div class="form-group">
                    <label for="Street1" class="form-label">{"Address line 1"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="text" id="Street1" name="Street1" value="{$street1|wash}" />
                </div>

                <div class="form-group">
                    <label for="Street2" class="form-label">{"Address line 2"|i18n("design/ezwebin/shop/userregister")}:</label>
                    <input class="form-control" type="text" id="Street2" name="Street2" value="{$street2|wash}" />
                </div>

                <div class="form-group">
                    <label for="Zip" class="form-label">{"Zip"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="text" id="Zip" name="Zip" value="{$zip|wash}" />
                </div>

                <div class="form-group">
                    <label for="City" class="form-label">{"City"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="text" id="City" name="City" value="{$city|wash}" />
                </div>

                <div class="form-group">
                    <label for="State" class="form-label">{"State"|i18n("design/ezwebin/shop/userregister")}:</label>
                    <input class="form-control" type="text" id="State" name="State" value="{$state|wash}" />
                </div>

                <div class="form-group">
                    <label for="Phone" class="form-label">{"Phone"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    <input class="form-control" type="tel" id="Phone" name="Phone" value="{$phone|wash}" />
                </div>

                <div class="form-group">
                    <label for="Country" class="form-label">{"Country"|i18n("design/ezwebin/shop/userregister")}:*</label>
                    {include uri='design:shop/country/edit.tpl' select_name='Country' select_size=1 current_val=$country select_class='form-control'}
                </div>

                <div class="form-group">
                    <label for="Comment" class="form-label">{"Comment"|i18n("design/ezwebin/shop/userregister")}:</label>
                    <textarea class="form-control" id="Comment" name="Comment" rows="5">{$comment|wash}</textarea>
                </div>

                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" id="StoreButton" name="StoreButton" value="{"Continue"|i18n("design/ezwebin/shop/userregister")}" />
                    <input class="btn btn-secondary" type="submit" id="CancelButton" name="CancelButton" value="{"Cancel"|i18n("design/ezwebin/shop/userregister")}" />
                </div>

            </div>
        </form>
    </div>
</div>

{literal}
<script type="text/javascript">
    function disableShopUserRegisterButtons()
    {
        var storeButton = document.getElementById( 'StoreButton' );
        var cancelButton = document.getElementById( 'CancelButton' );
        if ( storeButton ) storeButton.disabled = true;
        if ( cancelButton ) cancelButton.disabled = true;
    }
    var shopUserRegisterForm = document.forms['ShopUserRegister'];
    if ( shopUserRegisterForm )
    {
        // Disable on the next tick, not inside the submit handler. A submit
        // button that is disabled while the event is still running is left out
        // of the posted data, so StoreButton never arrived, the module saw no
        // Store action and simply re-rendered an empty form.
        shopUserRegisterForm.addEventListener( 'submit', function()
        {
            window.setTimeout( disableShopUserRegisterButtons, 0 );
        } );
    }
</script>
{/literal}
