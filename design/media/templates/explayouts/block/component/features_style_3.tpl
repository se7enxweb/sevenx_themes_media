    <article class="view-component view-component-features features-style-3">
        {include uri='design:explayouts/block/component/_features_header.tpl' cmp=$cmp btn1='btn btn-primary'}
        <div class="features-grid features-grid-col-2">
            {for 1 to 8 as $fs_idx}
                {include uri='design:explayouts/block/component/_feature_item.tpl' cmp=$cmp idx=$fs_idx kind='image' item_wrap=1}
            {/for}
        </div>
    </article>
