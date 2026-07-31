{* EXTENDS design:$nglayouts.layoutTemplate *}

{def $show_path = false}
{def $site_title = $tag.keyword}
{def $topic_tag = $tag.keyword}

{* BLOCK page_head_meta *}
    {parent()}

    <meta name="robots" content="noindex">
{* ENDBLOCK page_head_meta *}

{* BLOCK content *}
    <header class="full-page-header text-center no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{$tag.keyword}</h1>
        </div>
    </header>

    <div class="container">
        {if $related_content|count|gt(0)}
            <div class="category-children">
                <div class="row">
                    {foreach $related_content as $related_content_item}
                        <div class="col-sm-6 col-md-6 col-lg-4">
                            {ng_view_content($related_content_item, 'standard_with_intro')}
                        </div>
                    {/foreach}
                </div>
            </div>

            {if haveToPaginate($related_content)}
                {pagerfanta($related_content, 'ngsite')}
            {/if}
        {/if}
    </div>
{* ENDBLOCK content *}