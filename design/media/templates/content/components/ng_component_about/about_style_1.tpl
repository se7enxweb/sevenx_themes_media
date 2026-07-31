


{def $image = fieldValue($content, 'image')}
{def $image_mobile = fieldValue($content, 'image_mobile')}

{* BLOCK content *}
    <article class="view-component view-component-about about-style-1">

        {if or(not($content.fields.eyebrow_title['empty']), not($content.fields.title['empty']))}
            <header class="article-header">
                {if not($content.fields.eyebrow_title['empty'])}
                    <div class="eyebrow-title">
                        {ng_render_field($content.fields.eyebrow_title)}
                    </div>
                {/if}

                {if not($content.fields.title['empty'])}
                    <h2 class="title">
                        {ng_render_field($content.fields.title)}
                    </h2>
                {/if}
            </header>
        {/if}
        {if not(($image|count()|eq(0)))}
            <picture class="image">
                {if not(($image_mobile|count()|eq(0)))}
                    <source media="(max-width: 991px)" srcset="{ng_image_alias($content.fields.image_mobile, 'i770')}">
                {/if}
                <source media="(min-width: 992px)" srcset="{ng_image_alias($content.fields.image, 'original')}">
                {ng_render_field($content.fields.image, hash('parameters', hash('lazy_loading', false, 'alias', 'i1920')))}
            </picture>
        {/if}

        <div class="article-info">
            {if not($content.fields.description['empty'])}
                <div class="short">
                    {ng_render_field($content.fields.description)}
                </div>
            {/if}

            <div class="actions">
                {if not($content.fields.link_1['empty'])}
                    {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-secondary')))}
                {/if}

                {if not($content.fields.link_2['empty'])}
                    {ng_render_field($content.fields.link_2, hash('parameters', hash('css_class', 'btn btn-default')))}
                {/if}
            </div>
        </div>

    </article>
{* ENDBLOCK content *}