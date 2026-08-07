


{* IMPORT content/macros/links.tpl AS links *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-banner vl1">
    {if not($content.fields.image['empty'])}
        <figure class="image">
            {image_link($links, $content, 'image', 'i480')}
        </figure>
    {/if}

    <header class="article-header">
        <h3 class="title">
            {content_link($links, $content, $content.fields.title.value.text)}
        </h3>
    </header>

    {if first_set($with_intro, false)}
        <div class="short">
            {ng_render_field($content.fields.description)}
        </div>
    {/if}
</article>