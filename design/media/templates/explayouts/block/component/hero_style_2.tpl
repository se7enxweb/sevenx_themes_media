<article class="view-component view-component-hero hero-style-2">
    <div class="container">
        <header class="article-header">
            <div class="row justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    {include uri='design:explayouts/block/component/_header.tpl' cmp=$cmp title_tag='h1'}
                </div>
            </div>
        </header>
        {if and(is_set($cmp.data_map.image), $cmp.data_map.image.has_content)}
        <figure>
            {include uri='design:explayouts/block/component/_picture.tpl' cmp=$cmp pic_class='' srcset_alias='i1920'}
        </figure>
        {/if}
    </div>
</article>
