<article class="view-component view-component-about about-style-5">
    <header class="article-header">
        <div class="row justify-content-center">
            {if and(is_set($cmp.data_map.title), $cmp.data_map.title.has_content)}
            <h2 class="title col-lg-6">
                <span         class="ibexa_string-field" >{$cmp.data_map.title.content|wash}</span>
            </h2>
            {/if}
            {if and(is_set($cmp.data_map.description), $cmp.data_map.description.has_content)}
            <div class="short col-lg-6">
                <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$cmp.data_map.description}</div>
            </div>
            {/if}
        </div>
    </header>
</article>
