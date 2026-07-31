{if first_set($multimedia_items, array())|count|gt(0)}
    {def $is_slider = ($multimedia_items|count|gt(1))}
    {if and(and(($multimedia_items|count|eq(2)), hasField($multimedia_items[0].content, 'image')), $multimedia_items[0].content.fields.image['empty'])}
        {def $is_slider = false}
    {/if}

    {if $is_slider}
        <div class="related-multimedia swiper">
            <div class="swiper-wrapper">
    {else}
        <div>
    {/if}

    {foreach $multimedia_items as $multimedia_item}
        {include uri='design:concat('@ibexadesign/content/parts/related_multimedia/', $multimedia_item.contentInfo.contentTypeIdentifier, '.html.twig')'}
    {/foreach}

    {if $is_slider}
            </div>
            <div class="swiper-navigation">
                <div class="swiper-pagination"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
    {else}
        </div>
    {/if}
{/if}