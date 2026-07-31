<article class="view-component view-component-hero hero-style-3">
    <div class="container">
        <div class="row align-items-center">
            {if and(is_set($cmp.data_map.image), $cmp.data_map.image.has_content)}
            <div class="col-md-6 order-md-2">
                {include uri='design:explayouts/block/component/_picture.tpl' cmp=$cmp pic_class='image ratio ratio-1x1'}
            </div>
            {/if}
            <div class="col-md-6 order-md-1">
                <header class="article-header">
                    {include uri='design:explayouts/block/component/_header.tpl' cmp=$cmp title_tag='h1'}
                </header>
            </div>
        </div>
    </div>
</article>
