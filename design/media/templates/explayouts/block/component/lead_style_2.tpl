<article class="view-component view-component-lead lead-style-2">
    <div class="row">
        <div class="col-lg-5">
            <header class="article-header">
                {if and(is_set($cmp.data_map.title), $cmp.data_map.title.has_content)}
                <h2 class="title">
                    <span         class="ibexa_string-field" >{$cmp.data_map.title.content|wash}</span>
                </h2>
                {/if}
            </header>
            <div class="article-info">
                {include uri='design:explayouts/block/component/_about_short.tpl' cmp=$cmp}
            </div>
        </div>
        <div class="col-lg-5 offset-lg-1 mt-5 mt-lg-0">
            {include uri='design:explayouts/block/component/_lead_action.tpl' cmp=$cmp}
        </div>
    </div>
</article>
