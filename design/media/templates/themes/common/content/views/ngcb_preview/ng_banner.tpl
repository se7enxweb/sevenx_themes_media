


{* IMPORT content/macros/links.tpl AS links *}

{* BLOCK content *}
    <article class="view-type view-type-{$view_type} ng-banner vl1">

        {if not($content.fields.image['empty'])}
            <figure class="image">
                {image_link($links, $content, 'image', 'i480', false)}
            </figure>
        {/if}

        <header class="article-header">
            <h2 class="title">
                {content_link($links, $content, $content.fields.title.value.text)}
            </h2>
        </header>

        <div class="short">
            {ng_render_field($content.fields.description)}
        </div>
    </article>
{* ENDBLOCK content *}