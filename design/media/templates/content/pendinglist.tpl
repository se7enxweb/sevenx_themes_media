{* My pending items (content/pendinglist) in the media design: the versions of the current user that wait for
   approval, with class, section, version and time, and a link to preview each. Strings of the ezwebin design. *}
{def $page_limit = 15
     $list_count = fetch( 'content', 'pending_count' )}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'My pending items [%pending_count]'|i18n( 'design/ezwebin/content/pendinglist',, hash( '%pending_count', $list_count ) )}</h1>
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container acc content-list-page">
        <form name="pendinglistaction" action={'/content/pendinglist'|ezurl} method="post">
{if $list_count}
            <div class="shop-table-wrap">
                <table class="shop-table">
                    <tr>
                        <th>{'Name'|i18n( 'design/ezwebin/content/pendinglist' )}</th>
                        <th>{'Class'|i18n( 'design/ezwebin/content/pendinglist' )}</th>
                        <th>{'Section'|i18n( 'design/ezwebin/content/pendinglist' )}</th>
                        <th>{'Version'|i18n( 'design/ezwebin/content/pendinglist' )}</th>
                        <th>{'Last modified'|i18n( 'design/ezwebin/content/pendinglist' )}</th>
                    </tr>
    {foreach fetch( 'content', 'pending_list', hash( 'limit', $page_limit, 'offset', $view_parameters.offset ) ) as $pending_item sequence array( 'bglight', 'bgdark' ) as $style}
        {def $section_object = fetch( 'section', 'object', hash( 'section_id', $pending_item.contentobject.section_id ) )}
                    <tr class="{$style}">
                        <td><a href={concat( '/content/versionview/', $pending_item.contentobject.id, '/', $pending_item.version )|ezurl}>{$pending_item.contentobject.name|wash}</a></td>
                        <td>{$pending_item.contentobject.content_class.name|wash}</td>
                        <td>{if $section_object}{$section_object.name|wash}{else}<i>{'Unknown'|i18n( 'design/ezwebin/content/pendinglist' )}</i>{/if}</td>
                        <td>{$pending_item.version}</td>
                        <td>{$pending_item.modified|l10n( shortdatetime )}</td>
                    </tr>
        {undef $section_object}
    {/foreach}
                </table>
            </div>
            {include name=navigator uri='design:navigator/google.tpl' page_uri='/content/pendinglist' item_count=$list_count view_parameters=$view_parameters item_limit=$page_limit}
{else}
            <div class="full-form-response">
                <h2>{'Your pending list is empty'|i18n( 'design/ezwebin/content/pendinglist' )}</h2>
            </div>
{/if}
        </form>
    </div>
</div>
{undef $page_limit $list_count}
