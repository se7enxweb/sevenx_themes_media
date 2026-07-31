<article class="view-component view-component-hero hero-style-1{if and(is_set($cmp.data_map.image), $cmp.data_map.image.has_content)} bg-with-media{/if}">
    <div class="container">
        <div class="row">
            <div class="col-md-10 col-lg-8 col-xl-7">
                <header class="article-header">
                    {include uri='design:explayouts/block/component/_header.tpl' cmp=$cmp title_tag='h1'}
                </header>
            </div>
        </div>
    </div>
    {if and(is_set($cmp.data_map.image), $cmp.data_map.image.has_content)}
    <figure>
        {include uri='design:explayouts/block/component/_picture.tpl' cmp=$cmp pic_class=''}
        <span class="overlay"></span>
    </figure>
    {/if}
</article>
