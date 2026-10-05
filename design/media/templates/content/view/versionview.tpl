{* The preview of a version (content/versionview, from My drafts and My pending items) in the media design: a
   bar above the page with the version and the language, and the actions of the editors' toolbar of ezwebin as
   the design's buttons (EditButton, PreviewPublishButton, VersionsButton: the names the kernel reads), then the
   full view of the version itself. *}
<div class="acc acc-preview-bar">
    <div class="container">
        <form method="post" action={concat( 'content/versionview/', $object.id, '/', $version.version, '/', $language, '/', $from_language )|ezurl}>
            <p><b>{'Version preview'|i18n( 'kernel/content' )}</b> &middot; {$version.version_name|wash} &middot; {'Version'|i18n( 'design/ezwebin/content/draft' )} {$version.version}</p>
            <div class="acc-actions">
{if or( and( eq( $version.status, 0 ), $is_creator, $object.can_edit ), and( eq( $object.status, 2 ), $object.can_edit ) )}
                <input class="btn btn-primary" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/standard/content/view/versionview' )}" />
                <input class="btn btn-secondary" type="submit" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/standard/content/view/versionview' )}" />
{/if}
{if $object.versions|count|gt( 1 )}
                <input class="btn btn-outline" type="submit" name="VersionsButton" value="{'Manage versions'|i18n( 'design/standard/content/edit' )}" />
{/if}
            </div>
        </form>
    </div>
</div>

{if $object.class_identifier|eq( 'user' )}
{* A user account has no full view in this design: its preview is the profile card of user/edit. *}
<div class="full-form-content acc-content">
    <div class="container acc">
        <div class="acc-card">
            <h2>{$version.version_name|wash}</h2>
            <dl class="acc-facts">
{foreach $object.data_map as $identifier => $attribute}
    {if $attribute.has_content}
                <dt>{$attribute.contentclass_attribute_name|wash}</dt>
                <dd>{if $attribute.data_type_string|eq( 'ezuser' )}{$attribute.content.login|wash} &middot; {$attribute.content.email|wash}{else}{attribute_view_gui attribute=$attribute image_class='small'}{/if}</dd>
    {/if}
{/foreach}
            </dl>
        </div>
    </div>
</div>
{else}
{node_view_gui view=full with_children=false() versionview_mode=true() is_editable=false() is_standalone=false() content_object=$object node_name=$object.name content_node=$node node=$node}
{/if}
