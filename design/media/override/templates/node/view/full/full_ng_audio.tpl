<article class="view-type view-type-{$view_type} ng-blog-post">
    <header class="full-page-header">
        <div class="container">
            <h1 class="full-page-title">{$node.object.data_map.title.content|wash}</h1>
            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl'}
                {include uri='design:content/parts/time.tpl'}
            </div>
        </div>
    </header>

    {if $node.object.data_map.image.has_content}
        <div class="full-page-image">
            <div class="container container-wide">
                {attribute_view_gui attribute=$node.object.data_map.image}
            </div>
        </div>
    {/if}

    <div class="container container-narrow">
        <div class="full-page-body">
            {if $node.object.data_map.full_intro.has_content}
                <div class="full-page-intro">
                    {$node.object.data_map.full_intro.data_text|strip_tags|wash}
                </div>
            {/if}

            {if $node.object.data_map.body.has_content}
                <div class="full-page-content">
                    {$node.object.data_map.body.data_text|strip_tags|wash}
                </div>
            {/if}

            {if $node.object.data_map.tags.has_content}
                {include uri='design:content/parts/tags.tpl'}
            {/if}
        </div>
    </div>
</article>
