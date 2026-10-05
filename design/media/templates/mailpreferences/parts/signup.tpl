{* The optional e-mail on the registration form (user/register) in the media design: one unticked box per optional
   category, in the design's form-check layout. Nothing is ticked for the person; a category that needs a
   confirmation sends its confirmation link after the registration.
   Variables: categories (hash( identifier, name, description, checked, double_opt_in ), from the register view;
   empty when the e-mail preferences are not installed), css (optional: another class of the wrapper, e.g. form-group). *}
{if and( is_set( $categories ), $categories|count|gt( 0 ) )}
<fieldset class="mp-signup{if is_set( $css )} {$css|wash}{/if}">
    <legend>{'E-mail from us (optional)'|i18n( 'design/standard/mailpreferences' )}</legend>
    <p class="mp-signup-intro">{'Tick what you want to receive. You can change it at any time on your e-mail preference page, and every one of these e-mails has an unsubscribe link.'|i18n( 'design/standard/mailpreferences' )}</p>
{foreach $categories as $category}
    <div class="form-check">
        <input class="form-check-input" type="checkbox" id="mp-signup-{$category.identifier|wash}" name="MailPreferenceCategory[]" value="{$category.identifier|wash}"{if $category.checked} checked="checked"{/if} />
        <label class="form-check-label" for="mp-signup-{$category.identifier|wash}"><b>{$category.name|wash}</b>{if $category.description|ne( '' )} &ndash; {$category.description|wash}{/if}{if $category.double_opt_in} <span class="mp-signup-note">({'we send you a link to confirm it first'|i18n( 'design/standard/mailpreferences' )})</span>{/if}</label>
    </div>
{/foreach}
    <input type="hidden" name="MailPreferenceSignupShown" value="1" />
</fieldset>
{/if}
