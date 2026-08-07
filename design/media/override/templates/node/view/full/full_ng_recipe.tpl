{if not(is_set($content))}{def $content = $node.object}{/if}
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

    {if is_set($node.object.data_map['image'])}
        {if $node.object.data_map['image'].has_content}
            <div class="full-page-image">
                <div class="container container-wide">
                    {attribute_view_gui attribute=$node.object.data_map['image']}
                </div>
            </div>
        {/if}
    {/if}

    <div class="container container-narrow">
        <div class="full-page-body">
            {if is_set($node.object.data_map['full_intro'])}
                {if $node.object.data_map['full_intro'].has_content}
                    <div class="full-page-intro">
                        {$node.object.data_map['full_intro'].data_text|strip_tags|wash}
                    </div>
                {/if}
            {/if}

            {if is_set($node.object.data_map['body'])}
                {if $node.object.data_map['body'].has_content}
                    <div class="full-page-content">
                        {$node.object.data_map['body'].data_text|strip_tags|wash}
                    </div>
                {/if}
            {/if}

            {if is_set($node.object.data_map['tags'])}
                {if $node.object.data_map['tags'].has_content}
                    {include uri='design:content/parts/tags.tpl'}
                {/if}
            {/if}
        </div>
    </div>
</article>
