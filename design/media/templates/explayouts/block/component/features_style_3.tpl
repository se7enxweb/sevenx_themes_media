    {def $fs3_cols = first_set($block.parameters['number_of_columns'], 3)}
    <article class="view-component view-component-features features-style-3">
        {include uri='design:explayouts/block/component/_features_header.tpl' cmp=$cmp}
        <div class="features-grid features-grid-col-{$fs3_cols}">
            {for 1 to 8 as $fs_idx}
                {include uri='design:explayouts/block/component/_feature_item.tpl' cmp=$cmp idx=$fs_idx kind='image' item_wrap=1}
            {/for}
        </div>
    </article>
