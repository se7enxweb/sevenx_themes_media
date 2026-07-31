


{def $image = fieldValue($content, 'image')}
{def $image_mobile = fieldValue($content, 'image_mobile')}

{* BLOCK content *}
    <article class="view-component view-component-hero hero-style-2">
        <div class="container">
            <header class="article-header">
                <div class="row justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        {if not($content.fields.eyebrow_title['empty'])}
                            <div class="eyebrow-title">
                                {ng_render_field($content.fields.eyebrow_title)}
                            </div>
                        {/if}

                        {if not($content.fields.title['empty'])}
                            <h1 class="title">
                                {ng_render_field($content.fields.title)}
                            </h1>
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
                    </div>
                </div>
            </header>

            {if not(($image|count()|eq(0)))}
                <figure>
                    <picture>
                        {if not(($image_mobile|count()|eq(0)))}
                            <source media="(max-width: 991px)" srcset="{ng_image_alias($content.fields.image_mobile, 'i770')}">
                        {/if}
                        <source media="(min-width: 992px)" srcset="{ng_image_alias($content.fields.image, 'i1920')}">
                        {ng_render_field($content.fields.image, hash('parameters', hash('lazy_loading', false, 'alias', 'i1920')))}
                    </picture>
                </figure>
            {/if}
        </div>
    </article>
{* ENDBLOCK content *}