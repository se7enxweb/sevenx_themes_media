{* Two-tier thumb gallery (gallery-top + gallery-thumbs), eZ4-native. *}
{if $block.values.items|count()|gt(0)}
<div class="thumb-swiper">
    <div class="gallery-top swiper"
        data-effect="{first_set($block.parameters['transition'], 'slide')}"
        data-length="{$block.values.items|count()}"
    >
        <div class="swiper-wrapper">
            {foreach $block.values.items as $tg_entry}{def $tg_node = $tg_entry.node}
            <div class="swiper-slide">
                {include uri='design:explayouts/block/gallery/_thumb_slide.tpl' node=$tg_node alias='i1320' show_info=1}
            </div>
            {undef $tg_node}{/foreach}
        </div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
    <div class="swiper gallery-thumbs">
        <div class="swiper-wrapper">
            {foreach $block.values.items as $tg_entry}{def $tg_node = $tg_entry.node}
            <div class="swiper-slide">
                {include uri='design:explayouts/block/gallery/_thumb_slide.tpl' node=$tg_node alias='i320' show_info=0}
            </div>
            {undef $tg_node}{/foreach}
        </div>
    </div>
</div>
{/if}
