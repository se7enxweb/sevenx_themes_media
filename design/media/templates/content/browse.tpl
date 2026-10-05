{* The browse page of the public site (content/browse) in the media design: where "Add items" of the
   notification settings, and any other browse action, lets the user pick content. The form, its hidden fields
   and the SelectButton / BrowseCancelButton names are those of the kernel view; the list is the ezwebin
   design's content/browse_mode_list.tpl, drawn by stylesheets/account.css. Strings of the ezwebin design. *}
{def $number_of_items = 10
     $browse_list_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node_id, 'depth', 1 ) )
     $node_array = fetch( 'content', 'list', hash( 'parent_node_id', $node_id, 'depth', 1, 'offset', $view_parameters.offset, 'limit', $number_of_items, 'sort_by', $main_node.sort_array ) )
     $select_name = 'SelectedObjectIDArray'
     $select_type = 'checkbox'
     $select_attribute = 'contentobject_id'
     $current_node = fetch( 'content', 'node', hash( 'node_id', $browse.start_node ) )}
{if eq( $browse.return_type, 'NodeID' )}
    {set $select_name = 'SelectedNodeIDArray'}
    {set $select_attribute = 'node_id'}
{/if}
{if eq( $browse.selection, 'single' )}
    {set $select_type = 'radio'}
{/if}

<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Browse'|i18n( 'design/ezwebin/content/browse' )} - {$main_node.name|wash}</h1>
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container acc content-browse">
        <form name="browse" action={$browse.from_page|ezurl} method="post">

{if $browse.description_template}
            {include name=Description uri=$browse.description_template browse=$browse main_node=$main_node}
{else}
            <div class="content-edit-meta">
                <p>{'To select objects, choose the appropriate radiobutton or checkbox(es), and click the "Select" button.'|i18n( 'design/ezwebin/content/browse' )}</p>
                <p>{'To select an object that is a child of one of the displayed objects, click the parent object name to display a list of its children.'|i18n( 'design/ezwebin/content/browse' )}</p>
            </div>
{/if}

            <div class="acc-card">
                <h2>{if $browse.start_node|gt( 1 )}{$current_node.name|wash}{else}{'Top level'|i18n( 'design/ezwebin/content/browse' )}{/if} <span class="acc-count">{$current_node.children_count}</span></h2>
{if $browse.start_node|gt( 1 )}
                <p class="acc-crumb"><a href={concat( '/content/browse/', $main_node.parent_node_id, '/' )|ezurl}>{'Back'|i18n( 'design/ezwebin/content/browse' )}</a></p>
{/if}
                <div class="nf-scroll">
                {include uri='design:content/browse_mode_list.tpl'}
                </div>

                {include name=Navigator uri='design:navigator/google.tpl'
                         page_uri=concat( '/content/browse/', $main_node.node_id )
                         item_count=$browse_list_count
                         view_parameters=$view_parameters
                         item_limit=$number_of_items}

{if $browse.persistent_data|count()}
    {foreach $browse.persistent_data as $key => $data_item}
                <input type="hidden" name="{$key|wash}" value="{$data_item|wash}" />
    {/foreach}
{/if}
                <input type="hidden" name="BrowseActionName" value="{$browse.action_name}" />
{if $browse.browse_custom_action}
                <input type="hidden" name="{$browse.browse_custom_action.name}" value="{$browse.browse_custom_action.value}" />
{/if}
{if $cancel_action}
                <input type="hidden" name="BrowseCancelURI" value="{$cancel_action|wash}" />
{/if}
                <div class="acc-actions">
                    <input class="btn btn-primary" type="submit" name="SelectButton" value="{'Select'|i18n( 'design/ezwebin/content/browse' )}" />
                    <input class="btn btn-secondary" type="submit" name="BrowseCancelButton" value="{'Cancel'|i18n( 'design/ezwebin/content/browse' )}" />
                </div>
            </div>
        </form>
    </div>
</div>
{undef $number_of_items $browse_list_count $node_array $select_name $select_type $select_attribute $current_node}
