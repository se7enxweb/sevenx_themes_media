


{def $image = fieldValue($content, 'image')}
{def $image_mobile = fieldValue($content, 'image_mobile')}

{* BLOCK content *}
<article class="view-component view-component-about about-style-2">
    <div class="row align-items-center justify-content-center justify-content-lg-left">
        {if not(($image|count()|eq(0)))}
            <div class="article-image col-lg-6 mb-4 mb-lg-0">
                <picture class="image">
                    {if not(($image_mobile|count()|eq(0)))}
                        <source media="(max-width: 991px)" srcset="{ng_image_alias($content.fields.image_mobile, 'i770')}">
                    {/if}
                    <source media="(min-width: 992px)" srcset="{ng_image_alias($content.fields.image, 'original')}">
                    {ng_render_field($content.fields.image, hash('parameters', hash('lazy_loading', false, 'alias', 'i1920')))}
                </picture>
            </div>
        {/if}

        <header class="article-header{if not(($image|count()|eq(0)))} col-lg-5 offset-lg-1{/if}">
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

            {if not($content.fields.description['empty'])}
                <div class="short">
                    {ng_render_field($content.fields.description)}
                </div>
            {/if}

            <div class="actions">
                {if not($content.fields.link_1['empty'])}
                    {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-primary')))}
                {/if}

                {if not($content.fields.link_2['empty'])}
                    {ng_render_field($content.fields.link_2, hash('parameters', hash('css_class', 'btn btn-default')))}
                {/if}
            </div>
        </header>
    </div>
</article>
{* ENDBLOCK content *}