


{* IMPORT content/macros/links.tpl AS links *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-banner vl4">
    {if not($content.fields.image['empty'])}
        <figure class="image">
            {image_link($links, $content, 'image', 'i480')}
        </figure>
    {/if}

    <div class="article-content">
        <header class="article-header">
            <h3 class="title">
                {content_link($links, $content, $content.fields.title.value.text)}
            </h3>
        </header>
        <div class="short">
            {ng_render_field($content.fields.description)}
        </div>
    </div>
</article>