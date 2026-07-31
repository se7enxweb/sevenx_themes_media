{* Gallery slider, eZ4-native, mirroring the reference slider markup. *}
{if $block.values.items|count()|gt(0)}
<div class="default-swiper swiper"
    data-effect="{first_set($block.parameters['transition'], 'slide')}"
    {if $block.parameters['infinite_loop']}data-loop="true"{/if}{if $block.parameters['autoplay']}data-autoplay="{$block.parameters['autoplay_time']}"{/if}                    >
    <div class="swiper-wrapper">
        {foreach $block.values.items as $gs_entry}{def $gs_node = $gs_entry.node}
        <div class="swiper-slide">
            {include uri=concat('design:content/views/', first_set($block.item_view_type, 'slide'), '/', $gs_node.class_identifier, '.tpl') node=$gs_node content=$gs_node.object location=$gs_node view_type='slide'}
        </div>
        {undef $gs_node}{/foreach}
    </div>
    {if or($block.parameters['show_pagination'], $block.parameters['next_and_previous'])}
    <div class="swiper-navigation">
        {if $block.parameters['show_pagination']}
        <div class="swiper-pagination"></div>
        {/if}
        {if $block.parameters['next_and_previous']}
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
        {/if}
    </div>
    {/if}
</div>
{/if}
