{* Gallery grid with lightbox, eZ4-native per the reference grid_gallery. *}
{if $block.values.items|count()|gt(0)}
<div class="row flex-row nglayouts-flex-row js-lightbox-enabled">
    {foreach $block.values.items as $gg_entry}{def $gg_node = $gg_entry.node}
    <div class="nglayouts-as-flex" style="width:33.333333333333%">
        <div     data-item="true"
            data-content-id="{$gg_node.contentobject_id}"
            data-location-id="{$gg_node.node_id}"
        class="view-type view-type-gallery_grid {$gg_node.class_identifier|ristring('_','-')} vl3">
            {def $gg_ident = ''}
            {if and(is_set($gg_node.data_map.video_identifier), $gg_node.data_map.video_identifier.has_content)}
                {set $gg_ident = $gg_node.data_map.video_identifier.content}
            {/if}
            {if $gg_ident|ne('')}
            <a href="#" class="js-lightbox-item js-video-poster" title="{$gg_node.name|wash}">
                <img  src="https://img.youtube.com/vi/{$gg_ident}/mqdefault.jpg" alt="" />
            </a>
            {else}
            {def $gg_url = ''}
            {def $gg_w = ''}
            {def $gg_h = ''}
            {if and(is_set($gg_node.data_map.image), $gg_node.data_map.image.has_content)}
                {def $gg_img = $gg_node.data_map.image.content}
                {if is_set($gg_img['i1320'])}{set $gg_url = $gg_img['i1320'].url}
                {elseif is_set($gg_img['original'])}{set $gg_url = $gg_img['original'].url}{/if}
                {if is_set($gg_img['original'])}{set $gg_w = $gg_img['original'].width}{set $gg_h = $gg_img['original'].height}{/if}
                {undef $gg_img}
            {elseif and(is_set($gg_node.data_map.teaser_image), $gg_node.data_map.teaser_image.has_content)}
                {def $gg_img = $gg_node.data_map.teaser_image.content}
                {if is_set($gg_img['i1320'])}{set $gg_url = $gg_img['i1320'].url}
                {elseif is_set($gg_img['original'])}{set $gg_url = $gg_img['original'].url}{/if}
                {if is_set($gg_img['original'])}{set $gg_w = $gg_img['original'].width}{set $gg_h = $gg_img['original'].height}{/if}
                {undef $gg_img}
            {/if}
            {if $gg_url|ne('')}
            <a href={$gg_url|ezroot} title="{$gg_node.name|wash}" class="js-lightbox-item" data-pswp-width="{$gg_w}" data-pswp-height="{$gg_h}">
                <img
            src={$gg_url|ezroot}
            loading="lazy"                                                alt="{$gg_node.name|wash}"
                    class="ibexa_image-field"  />
            </a>
            {/if}
            {undef $gg_url $gg_w $gg_h}
            {/if}
            {undef $gg_ident}
        </div>
    </div>
    {undef $gg_node}{/foreach}
</div>
{/if}
