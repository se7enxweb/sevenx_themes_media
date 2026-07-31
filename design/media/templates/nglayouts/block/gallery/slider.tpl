{* EXTENDS design:@nglayouts/block/block.tpl *}

{* IMPORT nglayouts/parts/macros.tpl AS macros *}

{* BLOCK content *}
    {if and(is_set($collections.default), not(($collections.default|count()|eq(0))))}
        <div class="default-swiper swiper"
            data-effect="{parameter(block, 'transition')}"
            {if parameter(block, 'infinite_loop')}data-loop="true"{/if}
            {if parameter(block, 'autoplay')}data-autoplay="{parameter(block, 'autoplay_time')}"{/if}
        >
            <div class="swiper-wrapper">
                {foreach $collections.default as $result}
                    <div class="swiper-slide">
                        {nglayouts_render_result($result, null, block.itemViewType)}
                    </div>
                {/foreach}
            </div>
            {if or(parameter(block, 'show_pagination'), parameter(block, 'next_and_previous'))}
                <div class="swiper-navigation">
                    {if parameter(block, 'show_pagination')}
                        <div class="swiper-pagination"></div>
                    {/if}
                    {if parameter(block, 'next_and_previous')}
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                    {/if}
                </div>
            {/if}
        </div>
   {/if}
{* ENDBLOCK content *}