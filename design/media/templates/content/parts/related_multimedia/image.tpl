


{if not($content.fields.image['empty'])}
    {def $image = $content.fields.image}
    {def $image_alias = ng_image_alias($image, 'i1320')}
    {def $image_uri = cond($image_alias, $image_alias.uri, '//:0')}
    {def $alt_text = first_set($image.value.alternativeText, '')}
    {def $lazy_loading = getParameter($ibexa.configResolver, 'lazy_loading.enabled', 'ngsite')}

    {if $is_slider}
        <div class="swiper-slide">
    {/if}
            <figure class="image-wrapper">
                <img
                    src="{$image_uri}"
                    {if or($is_slider, $lazy_loading)}loading="lazy"{/if} alt="{$alt_text}"
                />

                {if and(is_set($content.fields.caption), not($content.fields.caption['empty']))}
                    <figcaption>
                        {ng_render_field($content.fields.caption)}
                    </figcaption>
                {/if}
            </figure>
    {if $is_slider}
        </div>
    {/if}
{/if}