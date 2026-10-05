{* My drafts (content/draft) in the media design: the drafts of the current user with their class, section,
   version, language and time, a link to preview and to edit each, and the buttons. DeleteIDArray[],
   RemoveButton and EmptyButton are those of the kernel view; the ezwebin page's "Select all" script is not
   needed (each draft has its own box). Strings of the ezwebin design. *}
{def $page_limit = 30
     $list_count = fetch( 'content', 'draft_count' )}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'My drafts'|i18n( 'design/ezwebin/content/draft' )}</h1>
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container acc content-list-page">
        <form name="draftaction" action={'content/draft/'|ezurl} method="post">
{if $list_count}
            <div class="content-edit-meta">
                <p>{"These are the current objects you are working on. The drafts are owned by you and can only be seen by you.
 You can either edit the drafts or remove them if you don't need them any more."|i18n( 'design/ezwebin/content/draft' )}</p>
            </div>
            <div class="shop-table-wrap">
                <table class="shop-table">
                    <tr>
                        <th><span class="mp-sr">{'Remove'|i18n( 'design/ezwebin/content/draft' )}</span></th>
                        <th>{'Name'|i18n( 'design/ezwebin/content/draft' )}</th>
                        <th>{'Class'|i18n( 'design/ezwebin/content/draft' )}</th>
                        <th>{'Version'|i18n( 'design/ezwebin/content/draft' )}</th>
                        <th>{'Language'|i18n( 'design/ezwebin/content/draft' )}</th>
                        <th>{'Last modified'|i18n( 'design/ezwebin/content/draft' )}</th>
                        <th><span class="mp-sr">{'Edit'|i18n( 'design/ezwebin/content/draft' )}</span></th>
                    </tr>
    {foreach fetch( 'content', 'draft_version_list', hash( 'limit', $page_limit, 'offset', $view_parameters.offset ) ) as $draft sequence array( 'bglight', 'bgdark' ) as $style}
                    <tr class="{$style}">
                        <td><input type="checkbox" name="DeleteIDArray[]" value="{$draft.id}" aria-label="{'Remove'|i18n( 'design/ezwebin/content/draft' )|wash}: {$draft.version_name|wash}" /></td>
                        <td><a href={concat( '/content/versionview/', $draft.contentobject.id, '/', $draft.version, '/' )|ezurl}>{$draft.version_name|wash}</a></td>
                        <td>{$draft.contentobject.content_class.name|wash}</td>
                        <td>{$draft.version}</td>
                        <td>{$draft.initial_language.name|wash}</td>
                        <td>{$draft.modified|l10n( shortdatetime )}</td>
                        <td><a class="btn btn-secondary btn-sm-acc" href={concat( '/content/edit/', $draft.contentobject.id, '/', $draft.version, '/' )|ezurl}>{'Edit'|i18n( 'design/ezwebin/content/draft' )}</a></td>
                    </tr>
    {/foreach}
                </table>
            </div>
            {include name=navigator uri='design:navigator/google.tpl' page_uri='/content/draft' item_count=$list_count view_parameters=$view_parameters item_limit=$page_limit}
            <div class="acc-actions">
                <input class="btn btn-secondary" type="submit" name="RemoveButton" value="{'Remove'|i18n( 'design/ezwebin/content/draft' )}" />
                <input class="btn btn-outline" type="submit" name="EmptyButton" value="{'Empty draft'|i18n( 'design/ezwebin/content/draft' )}" />
            </div>
{else}
            <div class="full-form-response">
                <h2>{'You have no drafts'|i18n( 'design/ezwebin/content/draft' )}</h2>
            </div>
{/if}
        </form>
    </div>
</div>
{undef $page_limit $list_count}
