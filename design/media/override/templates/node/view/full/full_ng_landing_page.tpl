



{* eZ4-native landing page full view. If an internal_redirect object relation is
   set, we embed that object (usually the shared contact form).

   When this full view is rendered inside an Exponential layout (e.g. the
   Bold-Agency /Kontakt page), the layout already provides a title/hero block,
   so we only render the target payload here. When rendered standalone (no
   layout), we wrap it in the same full-page header as ng_contact_form. *}

{def $el_layout = fetch('explayouts','resolve_layout_for_node',hash('node_id',$node.node_id))}
{def $in_layout = and(is_array($el_layout), is_set($el_layout.block_count), $el_layout.block_count|gt(0))}

<div class="view-type view-type-{$view_type} ng-landing-page">
    {if not($in_layout)}
        <header class="full-page-header text-center{if or(not($show_path), eq(count($path_array), 2))} no-breadcrumbs{/if}">
            <div class="container">
                <h1 class="full-page-title">{$node.data_map.title.data_text|wash}</h1>
                {if and( is_set( $node.data_map.full_intro ), $node.data_map.full_intro.has_content )}
                    <div class="full-page-header-text">
                        <div class="row">
                            <div class="container container-narrow">
                                {attribute_view_gui attribute=$node.data_map.full_intro}
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
        </header>
    {/if}

    <div class="full-form-content">
        <div class="container">
            {if and( is_set( $node.data_map.internal_redirect ), $node.data_map.internal_redirect.has_content )}
                {def $redirect_object = $node.data_map.internal_redirect.content}
                {if and( is_set( $redirect_object ), is_set( $redirect_object.main_node_id ), $redirect_object.main_node_id|gt(0) )}
                    {def $contact_node = fetch('content','node',hash('node_id',$redirect_object.main_node_id))}
                    {if $contact_node}
                        {include uri='design:content/views/payload/ng_contact_form.tpl' node=$contact_node referer=$requested_uri_string form_class='embed-form js-form-embed'}
                    {/if}
                    {undef $contact_node}
                {/if}
                {undef $redirect_object}
            {/if}
        </div>
    </div>
</div>

{undef $in_layout $el_layout}
