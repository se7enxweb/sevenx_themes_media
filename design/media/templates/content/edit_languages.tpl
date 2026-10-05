{* The language choice before editing (content/edit when the object has several languages, or a translation can
   be added) in the media design. The EditLanguage / FromLanguage radios and the LanguageSelection /
   CancelDraftButton names are those of the kernel view; the strings those of the ezwebin design this page
   replaces. Variables: object, show_existing_languages. *}
{def $languages = fetch( 'content', 'prioritized_languages' )
     $object_language_codes = $object.language_codes
     $can_edit = true()
     $first = true()}

<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{$object.name|wash}</h1>
    </div>
</header>

<div class="full-form-content acc-content">
    <div class="container acc">
        <form action={concat( 'content/edit/', $object.id )|ezurl} method="post">

{if $show_existing_languages}
    {set-block variable=$existing_languages_output}
    {foreach $languages as $language}
        {if and( $object_language_codes|contains( $language.locale ), fetch( 'content', 'access', hash( 'access', 'edit', 'contentobject', $object, 'language', $language.locale ) ) )}
                <label><input name="EditLanguage" type="radio" value="{$language.locale|wash}"{if $first} checked="checked"{set $first = false()}{/if} /> {$language.name|wash}</label>
        {/if}
    {/foreach}
    {/set-block}
    {if $existing_languages_output|trim}
            <fieldset class="acc-card">
                <legend class="mp-sr">{'Existing languages'|i18n( 'design/ezwebin/content/edit_languages' )}</legend>
                <h2>{'Existing languages'|i18n( 'design/ezwebin/content/edit_languages' )}</h2>
                <p class="acc-lead">{'Select the language you want to use when editing the object.'|i18n( 'design/ezwebin/content/edit_languages' )}:</p>
                <div class="content-edit-choices">{$existing_languages_output}</div>
            </fieldset>
    {/if}
{/if}

{set-block variable=$nonexisting_languages_output}
{foreach $languages as $language}
    {if and( $object_language_codes|contains( $language.locale )|not, fetch( 'content', 'access', hash( 'access', 'edit', 'contentobject', $object, 'language', $language.locale ) ) )}
                <label><input name="EditLanguage" type="radio" value="{$language.locale|wash}"{if $first} checked="checked"{set $first = false()}{/if} /> {$language.name|wash}</label>
    {/if}
{/foreach}
{/set-block}

{if $nonexisting_languages_output|trim}
            <fieldset class="acc-card">
                <legend class="mp-sr">{'New languages'|i18n( 'design/ezwebin/content/edit_languages' )}</legend>
                <h2>{'New languages'|i18n( 'design/ezwebin/content/edit_languages' )}</h2>
                <p class="acc-lead">{'Select the language you want to add to the object.'|i18n( 'design/ezwebin/content/edit_languages' )}:</p>
                <div class="content-edit-choices">{$nonexisting_languages_output}</div>
                <p class="acc-lead">{'Select the language the new translation will be based on.'|i18n( 'design/ezwebin/content/edit_languages' )}:</p>
                <div class="content-edit-choices">
                    <label><input name="FromLanguage" type="radio" checked="checked" value="" /> {'Use an empty, untranslated draft'|i18n( 'design/ezwebin/content/edit_languages' )}</label>
    {foreach $object.languages as $language}
                    <label><input name="FromLanguage" type="radio" value="{$language.locale|wash}" /> {$language.name|wash}</label>
    {/foreach}
                </div>
            </fieldset>
{elseif $show_existing_languages|not}
    {set $can_edit = false()}
            <div class="acc-notice warning" role="status"><p>{'You do not have permission to create a translation in another language.'|i18n( 'design/ezwebin/content/edit_languages' )}</p></div>
    {set-block variable=$existing_languages_output}
    {foreach $languages as $language}
        {if and( $object_language_codes|contains( $language.locale ), fetch( 'content', 'access', hash( 'access', 'edit', 'contentobject', $object, 'language', $language.locale ) ) )}
                <label><input name="EditLanguage" type="radio" value="{$language.locale|wash}"{if $first} checked="checked"{set $first = false()}{/if} /> {$language.name|wash}</label>
        {/if}
    {/foreach}
    {/set-block}
    {if $existing_languages_output|trim}
        {set $can_edit = true()}
            <fieldset class="acc-card">
                <legend class="mp-sr">{'Existing languages'|i18n( 'design/ezwebin/content/edit_languages' )}</legend>
                <h2>{'Existing languages'|i18n( 'design/ezwebin/content/edit_languages' )}</h2>
                <p class="acc-lead">{'However, you can select one of the following languages for editing.'|i18n( 'design/ezwebin/content/edit_languages' )}:</p>
                <div class="content-edit-choices">{$existing_languages_output}</div>
            </fieldset>
    {else}
            <div class="acc-notice error" role="alert"><p>{'You do not have permission to edit the object in any available languages.'|i18n( 'design/ezwebin/content/edit_languages' )}</p></div>
    {/if}
{/if}

            <div class="acc-actions">
{if $can_edit}
                <input class="btn btn-primary" type="submit" name="LanguageSelection" value="{'Edit'|i18n( 'design/ezwebin/content/edit_languages' )}" />
{/if}
                <input class="btn btn-secondary" type="submit" name="CancelDraftButton" value="{'Cancel'|i18n( 'design/ezwebin/content/edit_languages' )}" />
            </div>
        </form>
    </div>
</div>
{undef $languages $object_language_codes $can_edit $first}
