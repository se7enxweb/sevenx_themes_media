{* EXTENDS design:@nglayouts/block/block.tpl *}

{* IMPORT nglayouts/parts/macros.tpl AS macros *}

{* BLOCK content *}
    {if and(is_set($collections.default), not(($collections.default|count()|eq(0))))}
        <div class="sushi-swiper swiper"
            data-effect="slide"
            {if parameter(block, 'infinite_loop')}data-loop="true"{/if}
            {if parameter(block, 'autoplay')}data-autoplay="{parameter(block, 'autoplay_time')}"{/if}
            {if parameter(block, 'number_of_thumbnails')}data-slides-per-view="{parameter(block, 'number_of_thumbnails')}"{/if}
            {if parameter(block, 'thumbnails_to_move')}data-slides-per-group="{parameter(block, 'thumbnails_to_move')}"{/if}
        >
            <div class="swiper-wrapper">
                {foreach $collections.default as $result}
                    <div class="swiper-slide">
                        {nglayouts_render_result($result, null, block.itemViewType)}
                    </div>
                {/foreach}
            </div>
            {if parameter(block, 'show_pagination')}
                <div class="swiper-pagination"></div>
            {/if}

            {if parameter(block, 'next_and_previous')}
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            {/if}
        </div>
   {/if}
{* ENDBLOCK content *}