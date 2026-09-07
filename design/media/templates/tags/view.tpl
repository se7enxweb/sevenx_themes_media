{* Public tag page for the media theme, the eZ4 equivalent of the reference
   tag route (/tags/view/<Topics>/<Keyword>).

   Overrides extension/eztags/design/standard/templates/tags/view.tpl, which
   renders admin-oriented markup and fetches from node 2 (all sites). This
   version uses the site's own header/list markup and is scoped to the
   siteaccess content root so one site never lists another's content. *}

{def $tv_root = ezini('NodeSettings','RootNode','content.ini')}
{if or(not($tv_root), $tv_root|eq(''))}
    {set $tv_root = 2}
{/if}

{def $tv_limit = 10}
{def $tv_offset = first_set($view_parameters.offset, 0)}

{def $tv_filter = hash(
    'id', 'TagsAttributeFilter',
    'params', hash(
        'tag_id', $tag.id,
        'include_synonyms', true()
    )
)}

{def $tv_nodes = fetch('content','tree', hash(
    'parent_node_id', $tv_root,
    'extended_attribute_filter', $tv_filter,
    'offset', $tv_offset,
    'limit', $tv_limit,
    'main_node_only', true(),
    'sort_by', array( array('published', false()) )
))}

{def $tv_count = fetch('content','tree_count', hash(
    'parent_node_id', $tv_root,
    'extended_attribute_filter', $tv_filter,
    'main_node_only', true()
))}

<article class="view-type view-type-full tag-view">
    <header class="full-page-header no-breadcrumbs text-center">
        <div class="container">
            <h1 class="full-page-title"><span class="ibexa_string-field">{$tag.keyword|wash}</span></h1>
        </div>
    </header>

    <div class="container container-narrow">
        {if $tv_nodes|count()|gt(0)}
            <div class="list-row">
                {foreach $tv_nodes as $tv_node}
                    <div class="list-item">
                        {def $tv_tpl = item_view_template('line', $tv_node.class_identifier)}
                        {if $tv_tpl|ne('')}
                            {include uri=concat('design:', $tv_tpl) node=$tv_node content=$tv_node.object location=$tv_node view_type='line'}
                        {/if}
                        {undef $tv_tpl}
                    </div>
                {/foreach}
            </div>

            {if $tv_count|gt($tv_limit)}
                {include uri='design:navigator/google.tpl'
                         page_uri=tag_url($tag.id)
                         item_count=$tv_count
                         view_parameters=$view_parameters
                         item_limit=$tv_limit}
            {/if}
        {else}
            <p class="no-results">{'ngsite.tags.no_content'|trans}</p>
        {/if}
    </div>
</article>

{undef $tv_root $tv_limit $tv_offset $tv_filter $tv_nodes $tv_count}
