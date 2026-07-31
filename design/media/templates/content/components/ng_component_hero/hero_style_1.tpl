


{def $image = $content.fields.image}
{def $image_mobile = $content.fields.image_mobile}
{def $local_video = $content.fields.video}
{def $local_video_mobile = $content.fields.video_mobile}

{* BLOCK content *}
    <article class="view-component view-component-hero hero-style-1{if or(not(($image|count()|eq(0))), not(($local_video|count()|eq(0))))} bg-with-media{/if}">
        <div class="container">
            <div class="row">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    <header class="article-header">
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
                    </header>
                </div>
            </div>
        </div>
        <figure>
            {if and(is_set($local_video), not($local_video['empty']))}
                <video preload="auto" autoplay="" loop="" muted="" playsinline="" class="js-responsive-video"
                    data-desktop-vid="{path('ngsite_download', hash('contentId', $content.id, 'fieldId', $local_video.id, 'isInline', 1))}"
                    {if and(is_set($local_video_mobile), not($local_video_mobile['empty']))}
                    data-mobile-vid="{path('ngsite_download', hash('contentId', $content.id, 'fieldId', $local_video_mobile.id, 'isInline', 1))}"
                {/if}
                ></video>
                <span class="overlay"></span>
            {elseif not($image['empty'])}
                <picture>
                    {if not($image_mobile['empty'])}
                        <source media="(max-width: 991px)" srcset="{ng_image_alias($content.fields.image_mobile, 'i770')}">
                    {/if}
                    <source media="(min-width: 992px)" srcset="{ng_image_alias($content.fields.image, 'original')}">
                    {ng_render_field($content.fields.image, hash('parameters', hash('lazy_loading', false, 'alias', 'i1920')))}
                </picture>
                <span class="overlay"></span>
            {/if}
        </figure>
    </article>
{* ENDBLOCK content *}