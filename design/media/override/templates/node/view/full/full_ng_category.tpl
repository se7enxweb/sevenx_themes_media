{* Category full view, eZ4-native, mirroring the reference ng_category full
   view: centered header with intro, 3-column grid of children rendered as
   standard_with_intro, 12 per page with page-navigation pagination. *}
{def $cat_map = $node.object.data_map}
{def $cat_limit = 12}
{def $cat_page = 1}
{if and(is_set($view_parameters.page), $view_parameters.page|int|gt(0))}{set $cat_page = $view_parameters.page|int}{/if}
{def $cat_offset = $cat_limit|mul($cat_page|dec)}
{def $cat_count = fetch('content','list_count', hash('parent_node_id', $node.node_id))}
{def $cat_children = fetch('content','list', hash(
    'parent_node_id', $node.node_id,
    'sort_by', array(array('published', false())),
    'limit', $cat_limit,
    'offset', $cat_offset ))}
{def $cat_pages = $cat_count|div($cat_limit)|ceil()}

<div class="view-type view-type-full ng-category">

    <header class="full-page-header no-breadcrumbs text-center">
        <div class="container">
            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>
            {if and(is_set($cat_map.full_intro), $cat_map.full_intro.has_content)}
                <div class="full-page-header-text">
                    <div class="row">
                        <div class="container container-narrow">
                            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$cat_map.full_intro}</div>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </header>

    <div class="container">
        {if and(is_set($cat_map.body), $cat_map.body.has_content)}
            <div class="full-page-body">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$cat_map.body}</div>
            </div>
        {/if}

        {if $cat_children|count()|gt(0)}
        <div class="category-children">
            <div class="row">
                {foreach $cat_children as $cat_child}
                    <div class="col-md-4 col-sm-6">
                        {include uri=concat('design:content/views/standard/', $cat_child.class_identifier, '.tpl') node=$cat_child content=$cat_child.object location=$cat_child view_type='standard_with_intro' with_intro=1}
                    </div>
                {/foreach}
            </div>
        </div>

        {if $cat_pages|gt(1)}
        <nav class="page-navigation" role="navigation" aria-label="Pagination navigation">
            <ul>
                {if $cat_page|gt(1)}
                <li class="page-item"><a class="page-link" href={concat($node.url_alias, '/(page)/', $cat_page|dec)|ezurl} rel="prev" aria-label="{'Go to previous page'|wash}">Previous</a></li>
                {/if}
                {for 1 to $cat_pages as $cat_pg}
                    {if $cat_pg|eq($cat_page)}
                    <li class="page-item current"><span class="page-link">{$cat_pg}<span class="d-inline d-sm-none"> of {$cat_pages}</span></span></li>
                    {else}
                    <li class="page-item d-none d-sm-block"><a class="page-link" href={concat($node.url_alias, '/(page)/', $cat_pg)|ezurl} aria-label="Go to page {$cat_pg|wash}">{$cat_pg}</a></li>
                    {/if}
                {/for}
                {if $cat_page|lt($cat_pages)}
                <li class="page-item"><a class="page-link" href={concat($node.url_alias, '/(page)/', $cat_page|inc)|ezurl} rel="next" aria-label="{'Go to next page'|wash}">Next</a></li>
                {/if}
            </ul>
        </nav>
        {/if}
        {/if}
    </div>
</div>
{undef $cat_map $cat_limit $cat_page $cat_offset $cat_count $cat_children $cat_pages}
