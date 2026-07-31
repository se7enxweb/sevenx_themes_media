<article class="view-component view-component-about about-style-4">
    <header class="article-header">
        {if and(is_set($cmp.data_map.title), $cmp.data_map.title.has_content)}
        <h2 class="title">
            <span         class="ibexa_string-field" >{$cmp.data_map.title.content|wash}</span>
        </h2>
        {/if}
        <div class="text">
            {include uri='design:explayouts/block/component/_about_short.tpl' cmp=$cmp}
            {if and(is_set($cmp.data_map.description_2), $cmp.data_map.description_2.has_content)}
            <div class="short">
                <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$cmp.data_map.description_2}</div>
            </div>
            {/if}
        </div>
        {include uri='design:explayouts/block/component/_about_actions.tpl' cmp=$cmp btn_class='btn btn-primary'}
    </header>
</article>
