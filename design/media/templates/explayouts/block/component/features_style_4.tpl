    <article class="view-component view-component-features features-style-4">
        {include uri='design:explayouts/block/component/_features_header.tpl' cmp=$cmp}
        <div class="features-grid features-grid-col-3">
            {for 1 to 8 as $fs_idx}
                {include uri='design:explayouts/block/component/_feature_item.tpl' cmp=$cmp idx=$fs_idx kind='icon'}
            {/for}
        </div>
    </article>
