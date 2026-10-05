{* The edit form of the public site (content/edit) in the media design: the design's page header with the object
   and its class, the language line, the validation messages, the attributes (content/edit_attribute.tpl) in the
   design's form column, and the buttons. The form action, the button names and the hidden fields are those of the
   kernel view and of the ezwebin design this page replaces, and so are its strings. The editors' website toolbar
   of ezwebin is not shown: the media design has none. Drawn by stylesheets/account.css. *}
{def $content_language = ezini( 'RegionalSettings', 'Locale' )
     $language_index = 0
     $translation_list = $content_version.translation_list}
{foreach $translation_list as $index => $translation}
    {if eq( $edit_language, $translation.language_code )}{set $language_index = $index}{/if}
{/foreach}

<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Edit <%object_name> (%class_name)'|i18n( 'design/ezwebin/content/edit', , hash( '%object_name', $object.name, '%class_name', first_set( $class.nameList[$content_language], $class.name ) ) )|wash}</h1>
{if $object.content_class.description}
        <p class="full-page-header-text">{first_set( $class.descriptionList[$content_language], $class.description )|wash}</p>
{/if}
    </div>
</header>

<div class="full-form-content acc-content">
    <div class="container">
        <form name="editform" id="editform" class="embed-form content-edit-form" enctype="multipart/form-data" method="post" action={concat( '/content/edit/', $object.id, '/', $edit_version, '/', $edit_language|not|choose( concat( $edit_language, '/' ), '/' ), $is_translating_content|not|choose( concat( $from_language, '/' ), '' ) )|ezurl}>

            <div class="content-edit-meta">
                <p>
{if $is_translating_content}
    {def $from_language_object = $object.languages[$from_language]}
                {'Translating content from %from_lang to %to_lang'|i18n( 'design/ezwebin/content/edit',, hash(
                    '%from_lang', concat( $from_language_object.name, '&nbsp;<img src="', $from_language_object.locale|flag_icon, '" alt="', $from_language_object.locale, '" />' ),
                    '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" alt="', $translation_list[$language_index].language_code, '" />' ) ) )}
    {undef $from_language_object}
{else}
                {'Content in %language'|i18n( 'design/ezwebin/content/edit',, hash( '%language', $translation_list[$language_index].locale.intl_language_name ) )}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" alt="{$translation_list[$language_index].language_code}" />
{/if}
                </p>
            </div>

            {include uri='design:content/edit_validation.tpl'}

            <div class="form-wrapper">
{foreach ezini( 'EditSettings', 'AdditionalTemplates', 'content.ini' ) as $additional_tpl}
                {include uri=concat( 'design:', $additional_tpl )}
{/foreach}

                {include uri='design:content/edit_attribute.tpl' view_parameters=$view_parameters}

                <div class="buttonblock content-edit-buttons">
                    <input class="btn btn-primary" type="submit" name="PublishButton" value="{'Send for publishing'|i18n( 'design/ezwebin/content/edit' )}" title="{'Publish the contents of the draft that is being edited. The draft will become the published version of the object.'|i18n( 'design/ezwebin/content/edit' )}" />
                    <input class="btn btn-secondary" type="submit" name="StoreButton" value="{'Store draft'|i18n( 'design/ezwebin/content/edit' )}" title="{'Store the contents of the draft that is being edited and continue editing. Use this button to periodically save your work while editing.'|i18n( 'design/ezwebin/content/edit' )}" />
                    <input class="btn btn-secondary" type="submit" name="StoreExitButton" value="{'Store draft and exit'|i18n( 'design/ezwebin/content/edit' )}" title="{'Store the draft that is being edited and exit from edit mode. Use when you need to exit your work and return later to continue.'|i18n( 'design/ezwebin/content/edit' )}" />
                    <input class="btn btn-outline btn-discard" type="submit" name="DiscardButton" value="{'Discard draft'|i18n( 'design/ezwebin/content/edit' )}" title="{'Discard the draft that is being edited. This will also remove the translations that belong to the draft (if any).'|i18n( 'design/ezwebin/content/edit' )}" />
                    <input type="hidden" name="DiscardConfirm" value="0" />
                    <input type="hidden" name="RedirectIfDiscarded" value="{if ezhttp_hasvariable( 'LastAccessesURI', 'session' )}{ezhttp( 'LastAccessesURI', 'session' )}{/if}" />
                    <input type="hidden" name="RedirectURIAfterPublish" value="{if ezhttp_hasvariable( 'LastAccessesURI', 'session' )}{ezhttp( 'LastAccessesURI', 'session' )}{/if}" />
                </div>
            </div>
        </form>
    </div>
</div>
{undef $content_language $language_index $translation_list}
