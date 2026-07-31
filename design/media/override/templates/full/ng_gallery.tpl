{* Gallery full view, eZ4-native, mirroring the reference: header, swiper of
   the gallery's child images, then intro/body/tags. *}
{def $gf_map = $node.object.data_map}
{def $content = $node.object}
<div class="view-type view-type-full ng-gallery">
    <header class="full-page-header">
        <div class="container">
            {include uri='design:content/parts/main_topic.tpl' content=$node.object}

            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>

            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl' content=$node.object node=$node}
                {include uri='design:content/parts/time.tpl'}
            </div>
        </div>
    </header>

    {def $gf_children = fetch('content','list', hash('parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array('image'), 'sort_by', array(array('priority', true()))))}
    {if $gf_children|count()|gt(0)}
    <div class="full-page-image">
        <div class="container container-wide">
            <div class="related-multimedia swiper">
                <div class="swiper-wrapper">
                    {foreach $gf_children as $gf_child}
                        {if and(is_set($gf_child.data_map.image), $gf_child.data_map.image.has_content)}
                        {def $gf_img = $gf_child.data_map.image.content}
                        {def $gf_url = ''}
                        {if is_set($gf_img['i1320'])}{set $gf_url = $gf_img['i1320'].url}
                        {elseif is_set($gf_img['large'])}{set $gf_url = $gf_img['large'].url}
                        {elseif is_set($gf_img['original'])}{set $gf_url = $gf_img['original'].url}{/if}
                        {if $gf_url|ne('')}
                        <div class="swiper-slide">
                            <figure class="image-wrapper">
                                <img src={$gf_url|ezroot} loading="lazy" alt="{$gf_img.alternative_text|wash}" />
                            </figure>
                        </div>
                        {/if}
                        {undef $gf_img $gf_url}
                        {/if}
                    {/foreach}
                </div>
                <div class="swiper-navigation">
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
            </div>
        </div>
    </div>
    {/if}
    {undef $gf_children}

    <div class="container container-narrow">
        <div class="full-page-body">
            {if and(is_set($gf_map.teaser_intro), $gf_map.teaser_intro.has_content)}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$gf_map.teaser_intro}</div>
            </div>
            {/if}
            {if and(is_set($gf_map.description), $gf_map.description.has_content)}
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$gf_map.description}</div>
            {/if}
            {include uri='design:content/parts/tags.tpl' content=$node.object node=$node}
        </div>
    </div>
</div>
{undef $gf_map}
