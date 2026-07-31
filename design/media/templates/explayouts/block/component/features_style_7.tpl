    <article class="view-component view-component-features features-style-7">
        {include uri='design:explayouts/block/component/_features_header.tpl' cmp=$cmp}
        <div class="list-zigzag">
            {def $fz_map = $cmp.data_map}
            {for 1 to 8 as $fz_idx}
                {def $fz_title = $fz_map[concat('item_', $fz_idx, '_title')]}
                {if and(is_set($fz_title), $fz_title.has_content)}
                <div class="list-item">
                    <div class="view-type view-type-zigzag vl9">
                        {def $fz_img_attr = $fz_map[concat('item_', $fz_idx, '_image')]}
                        {if and(is_set($fz_img_attr), $fz_img_attr.has_content)}
                        {def $fz_img = $fz_img_attr.content}
                        {def $fz_url = ''}
                        {if is_set($fz_img['i770'])}{set $fz_url = $fz_img['i770'].url}
                        {elseif is_set($fz_img['large'])}{set $fz_url = $fz_img['large'].url}
                        {elseif is_set($fz_img['original'])}{set $fz_url = $fz_img['original'].url}{/if}
                        {if $fz_url|ne('')}
                        <figure class="image">
                            <a href="#"
                                title="{$fz_img.alternative_text|wash}"
            ><img
            src={$fz_url|ezroot}
            loading="lazy"                                                alt="{$fz_img.alternative_text|wash}"
                    class="ibexa_image-field"  /></a>
                        </figure>
                        {/if}
                        {undef $fz_img $fz_url}
                        {/if}
                        {undef $fz_img_attr}
                        <div class="article-content">
                            <header class="article-header">
                                {def $fz_hl = $fz_map[concat('item_', $fz_idx, '_highlight_title')]}
                                {if and(is_set($fz_hl), $fz_hl.has_content)}
                                <span class="eyebrow-title">{$fz_hl.content|wash}</span>
                                {/if}
                                {undef $fz_hl}
                                {def $fz_link = false()}
                                {def $fz_link_attr = $fz_map[concat('item_', $fz_idx, '_link')]}
                                {if is_set($fz_link_attr)}{set $fz_link = enhanced_link($fz_link_attr)}{/if}
                                {if $fz_link}
                                <h3 class="title"><a href="{$fz_link.href|wash}"
                >
    {$fz_title.content|wash}
            </a></h3>
                                {else}
                                <h3 class="title">{$fz_title.content|wash}</h3>
                                {/if}
                            </header>
                            {def $fz_short = $fz_map[concat('item_', $fz_idx, '_description')]}
                            {if and(is_set($fz_short), $fz_short.has_content)}
                            <div class="short">
                                <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$fz_short}</div>
                            </div>
                            {/if}
                            {undef $fz_short}
                            {if $fz_link}
                            <div class="actions">
                                {include uri='design:explayouts/block/component/_link.tpl' link=$fz_link btn_class='btn btn-link'}
                            </div>
                            {/if}
                            {undef $fz_link $fz_link_attr}
                        </div>
                    </div>
                </div>
                {/if}
                {undef $fz_title}
            {/for}
            {undef $fz_map}
        </div>
    </article>
