


{* EXTENDS design:$nglayouts.layoutTemplate *}

{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{elseif not($content.fields.full_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.full_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{* BLOCK content *}
    <div class="view-type view-type-{$view_type} ng-category">

        <header class="full-page-header text-center{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
            <div class="container">
                <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>
                {if not($content.fields.full_intro['empty'])}
                    <div class="full-page-header-text">
                        <div class="row">
                            <div class="container container-narrow">
                                {ng_render_field($content.fields.full_intro)}
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
        </header>

        <div class="container">
            {if not($content.fields.body['empty'])}
                <div class="full-page-body">
                    {ng_render_field($content.fields.body)}
                </div>
            {/if}

            {def $featured_locations = filterFieldRelationLocations($content, 'featured_content')}
            {if $featured_locations|count|gt(0)}
                <div class="category-featured-content">
                    {foreach $featured_locations as $featured_location}
                        {ng_view_content($featured_location, 'line')}
                    {/foreach}
                </div>
            {/if}

            {if $content.fields.show_children.value.bool}
                {def $pager = ng_query('subtree')}

                {if $pager|count|gt(0)}
                    {def $children_view_type = first_set($content.fields.view_type.value.identifiers[0], 'standard')}
                    {def $columns = first_set($content.fields.grid_columns.value.identifiers[0], '3')}
                    {def $column_css_class = hash('1', 'col-12', '2', 'col-sm-6', '3', 'col-md-4 col-sm-6', '4', 'col-lg-3 col-md-4 col-sm-6')}
                    <div class="category-children">
                        {if $children_view_type|eq('listitem')}
                            <ul class="listitem-list">
                                {foreach $pager as $pager_item}
                                    <li>
                                        {ng_view_content($pager_item, $children_view_type)}
                                    </li>
                                {/foreach}
                            </ul>
                        {else}
                            <div class="row">
                                {foreach $pager as $pager_item}
                                    <div class="{$column_css_class[$columns]}">
                                        {ng_view_content($pager_item, $children_view_type)}
                                    </div>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                {/if}

                {if haveToPaginate($pager)}
                    {pagerfanta($pager, 'ngsite')}
                {/if}
            {/if}
        </div>
    </div>
{* ENDBLOCK content *}