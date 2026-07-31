{* Gallery - sushi bar swiper carousel, mirrors themes/app/block/gallery/sushi_bar.html.twig *}
{def $sb_params = array()}
{if is_set($block.parameters)}{set $sb_params = $block.parameters}{/if}
{def $sb_view = 'overlay'}
{if and( is_set($block.item_view_type), $block.item_view_type|ne('') )}
    {set $sb_view = $block.item_view_type}
{/if}
{if $block.values.items|count()|gt(0)}
<div class="sushi-swiper swiper"
    data-effect="slide"
    {if $sb_params['infinite_loop']}data-loop="true"{/if}
    {if $sb_params['autoplay']}data-autoplay="{$sb_params['autoplay_time']}"{/if}
    {if $sb_params['number_of_thumbnails']}data-slides-per-view="{$sb_params['number_of_thumbnails']}"{/if}
    {if $sb_params['thumbnails_to_move']}data-slides-per-group="{$sb_params['thumbnails_to_move']}"{/if}
>
    <div class="swiper-wrapper">
        {foreach $block.values.items as $sb_item}
            {if is_set($sb_item.node)}
            <div class="swiper-slide">
                {include uri=concat('design:content/views/', $sb_view, '/', $sb_item.node.class_identifier, '.tpl') node=$sb_item.node content=$sb_item.node.object location=$sb_item.node view_type=$sb_view}
            </div>
            {/if}
        {/foreach}
    </div>
    {if $sb_params['show_pagination']}
        <div class="swiper-pagination"></div>
    {/if}
    {if $sb_params['next_and_previous']}
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    {/if}
</div>
{/if}
{undef $sb_params $sb_view}
