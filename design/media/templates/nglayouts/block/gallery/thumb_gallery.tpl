{* EXTENDS design:@nglayouts/block/block.tpl *}

{* IMPORT nglayouts/parts/macros.tpl AS macros *}

{* BLOCK content *}
    {if and(is_set($collections.default), not(($collections.default|count()|eq(0))))}
        <div class="thumb-swiper">
            <div class="gallery-top swiper"
                data-effect="{parameter(block, 'transition')}"
                data-length="{$collections.default|count}"
                {if parameter(block, 'infinite_loop')}data-loop="true"{/if}
                {if parameter(block, 'autoplay')}data-autoplay="{parameter(block, 'autoplay_time')}"{/if}
            >
                <div class="swiper-wrapper">
                    {foreach $collections.default as $result}
                        <div class="swiper-slide">
                            {nglayouts_render_result($result, null, block.itemViewType, hash('image_type', 'main', 'show_details', parameter(block, 'show_details'), 'show_details_on_hover', parameter(block, 'show_details_on_hover')))}
                        </div>
                    {/foreach}
                </div>

                {if parameter(block, 'next_and_previous')}
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                {/if}
            </div>

            <div class="swiper gallery-thumbs">
                <div class="swiper-wrapper">
                    {foreach $collections.default as $result}
                        <div class="swiper-slide">
                            {nglayouts_render_result($result, null, block.itemViewType, hash('image_type', 'thumb', 'show_details', parameter(block, 'show_details'), 'show_details_on_hover', parameter(block, 'show_details_on_hover')))}
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
   {/if}
{* ENDBLOCK content *}