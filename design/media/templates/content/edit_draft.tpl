{* "Edit selected version" (content/edit when the object already has drafts) in the media design: what is
   published, the drafts, and the choice to continue one of my drafts or to start a new one. The form, the
   SelectedVersion radios and the EditButton / NewDraftButton names are those of the kernel view; the strings
   those of the ezwebin design this page replaces. *}
{def $has_own_drafts = false()
     $has_other_drafts = false()
     $current_creator = fetch( 'user', 'current_user' )
     $first_own = true()}
{foreach $draft_versions as $item}
    {if eq( $item.creator_id, $current_creator.contentobject_id )}{set $has_own_drafts = true()}{else}{set $has_other_drafts = true()}{/if}
{/foreach}

<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{$object.name|wash}</h1>
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container acc">
        <form method="post" action={concat( 'content/edit/', $object.id, '/', $edit_language, '/', $from_language )|ezurl}>

            <div class="content-edit-meta">
                <p>{'The currently published version is %version and was published at %time.'|i18n( 'design/ezwebin/content/edit_draft',, hash( '%version', $object.current_version, '%time', $object.published|l10n( datetime ) ) )}</p>
                <p>{'The last modification was done at %modified.'|i18n( 'design/ezwebin/content/edit_draft',, hash( '%modified', $object.modified|l10n( datetime ) ) )}</p>
                <p>{'The object is owned by %owner.'|i18n( 'design/ezwebin/content/edit_draft',, hash( '%owner', $object.owner.name ) )|wash}</p>
            </div>

            <div class="acc-notice info" role="status">
{if and( $has_own_drafts, $has_other_drafts )}
                <p>{'This object is already being edited by yourself and others.
    You can either continue editing one of your drafts or you can create a new draft.'|i18n( 'design/ezwebin/content/edit_draft' )}</p>
{elseif $has_own_drafts}
                <p>{'This object is already being edited by you.
        You can either continue editing one of your drafts or you can create a new draft.'|i18n( 'design/ezwebin/content/edit_draft' )}</p>
{elseif $has_other_drafts}
                <p>{'This object is already being edited by someone else.
        You should either contact the person about their draft or create a new draft for your own use.'|i18n( 'design/ezwebin/content/edit_draft' )}</p>
{/if}
            </div>

            <div class="acc-card">
                <h2>{'Current drafts'|i18n( 'design/ezwebin/content/edit_draft' )}</h2>
                <div class="nf-scroll">
                <table class="content-edit-drafts">
                    <thead><tr>
{if $has_own_drafts}<th><span class="mp-sr">{'Edit'|i18n( 'design/ezwebin/content/edit_draft' )}</span></th>{/if}
                        <th>{'Version'|i18n( 'design/ezwebin/content/edit_draft' )}</th>
                        <th>{'Name'|i18n( 'design/ezwebin/content/edit_draft' )}</th>
                        <th>{'Owner'|i18n( 'design/ezwebin/content/edit_draft' )}</th>
                        <th>{'Created'|i18n( 'design/ezwebin/content/edit_draft' )}</th>
                        <th>{'Last modified'|i18n( 'design/ezwebin/content/edit_draft' )}</th>
                    </tr></thead>
                    <tbody>
{foreach $draft_versions as $item}
                    <tr>
    {if $has_own_drafts}
                        <td>{if eq( $item.creator_id, $current_creator.contentobject_id )}<input type="radio" id="content-edit-draft-{$item.version}" name="SelectedVersion" value="{$item.version}"{if $first_own} checked="checked"{set $first_own = false()}{/if} />{/if}</td>
    {/if}
                        <td><label for="content-edit-draft-{$item.version}">{$item.version}</label></td>
                        <td><a href={concat( 'content/versionview/', $object.id, '/', $item.version )|ezurl}>{$item.version_name|wash}</a></td>
                        <td>{$item.creator.name|wash}</td>
                        <td>{$item.created|l10n( shortdatetime )}</td>
                        <td>{$item.modified|l10n( shortdatetime )}</td>
                    </tr>
{/foreach}
                    </tbody>
                </table>
                </div>
                <div class="acc-actions">
{if $has_own_drafts}
                    <input class="btn btn-primary" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/ezwebin/content/edit_draft' )}" />
                    <input class="btn btn-secondary" type="submit" name="NewDraftButton" value="{'New draft'|i18n( 'design/ezwebin/content/edit_draft' )}" />
{elseif $has_other_drafts}
                    <input class="btn btn-primary" type="submit" name="NewDraftButton" value="{'New draft'|i18n( 'design/ezwebin/content/edit_draft' )}" />
{/if}
                </div>
            </div>
        </form>
    </div>
</div>
{undef $has_own_drafts $has_other_drafts $current_creator $first_own}
