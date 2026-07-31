<article class="view-component view-component-quote quote-style-1">
    <div class="quote-swiper swiper"
        data-effect="slide"
        data-loop="true"
        data-autoplay="5000"
    >
        <div class="swiper-wrapper">
            {def $qs_map = $cmp.data_map}
            {for 1 to 8 as $qs_idx}
                {def $qs_title = $qs_map[concat('item_', $qs_idx, '_title')]}
                {if and(is_set($qs_title), $qs_title.has_content)}
                <div class="swiper-slide">
                    <div class="container container-narrow">
                        <div class="quote-item">
                            <img class="quote-icon" src={'images/quote.svg'|ezdesign(no)} alt="" />
                            <h3 class="item-title">                <span         class="ibexa_string-field" >{$qs_title.content|wash}</span>
</h3>
                            {def $qs_desc = $qs_map[concat('item_', $qs_idx, '_description')]}
                            {if and(is_set($qs_desc), $qs_desc.has_content)}
                            <div class="item-short">
                                <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$qs_desc}</div>
                            </div>
                            {/if}
                            {undef $qs_desc}
                            <div class="quote-person">
                                {def $qs_pimg_attr = $qs_map[concat('item_', $qs_idx, '_person_image')]}
                                {if and(is_set($qs_pimg_attr), $qs_pimg_attr.has_content)}
                                {def $qs_pimg = $qs_pimg_attr.content}
                                {def $qs_purl = ''}
                                {if is_set($qs_pimg['i160'])}{set $qs_purl = $qs_pimg['i160'].url}
                                {elseif is_set($qs_pimg['original'])}{set $qs_purl = $qs_pimg['original'].url}{/if}
                                {if $qs_purl|ne('')}
                                <div class="quote-person-image">
                                    <img
            src={$qs_purl|ezroot}
            loading="lazy"                                                alt=""
                    class="ibexa_image-field"  />
                                </div>
                                {/if}
                                {undef $qs_pimg $qs_purl}
                                {/if}
                                {undef $qs_pimg_attr}
                                <div class="quote-person-info">
                                    {def $qs_pname = $qs_map[concat('item_', $qs_idx, '_person_name')]}
                                    {if and(is_set($qs_pname), $qs_pname.has_content)}
                                    <div class="quote-person-info-name">{$qs_pname.content|wash}</div>
                                    {/if}
                                    {undef $qs_pname}
                                    {def $qs_pdesc = $qs_map[concat('item_', $qs_idx, '_person_description')]}
                                    {if and(is_set($qs_pdesc), $qs_pdesc.has_content)}
                                    <span         class="ibexa_string-field" >{$qs_pdesc.content|wash}</span>
                                    {/if}
                                    {undef $qs_pdesc}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {/if}
                {undef $qs_title}
            {/for}
            {undef $qs_map}
        </div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
</article>
