{if not(is_set($content))}{def $content = $node.object}{/if}
{def $view_type = 'full'}
{explblock name='content'}
<article class="view-type view-type-{$view_type} ng-recipe">
    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            <h1 class="full-page-title">{$node.object.data_map.title.content|wash}</h1>
            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl'}
                {include uri='design:content/parts/time.tpl'}
            </div>
        </div>
    </header>
    {/explblock}

    {if is_set($node.object.data_map['image'])}
        {if $node.object.data_map['image'].has_content}
            {explblock name='article_media'}
            <div class="full-page-image">
                <div class="container container-wide">
                    <figure class="image-wrapper">
                        {ng_render_field($node.object.data_map.image)}
                    </figure>
                </div>
            </div>
            {/explblock}
        {/if}
    {/if}

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">
            {if is_set($node.object.data_map['full_intro'])}
                {if $node.object.data_map['full_intro'].has_content}
                    <div class="full-page-intro">
                        {$node.object.data_map['full_intro'].content.output.output_text}
                    </div>
                {/if}
            {/if}

            {if is_set($node.object.data_map['body'])}
                {if $node.object.data_map['body'].has_content}
                    <div class="full-page-content">
                        {$node.object.data_map['body'].content.output.output_text}
                    </div>
                {/if}
            {/if}

            {if is_set($node.object.data_map['tags'])}
                {if $node.object.data_map['tags'].has_content}
                    {include uri='design:content/parts/tags.tpl'}
                {/if}
            {/if}
        </div>
        {/explblock}
    </div>
</article>
{/explblock}
