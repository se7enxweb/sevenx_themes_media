{def $aa_l1 = false()}
{def $aa_l2 = false()}
{if is_set($cmp.data_map.link_1)}{set $aa_l1 = enhanced_link($cmp.data_map.link_1)}{/if}
{if is_set($cmp.data_map.link_2)}{set $aa_l2 = enhanced_link($cmp.data_map.link_2)}{/if}
{if or($aa_l1, $aa_l2)}
<div class="actions">
    {include uri='design:explayouts/block/component/_link.tpl' link=$aa_l1 btn_class=first_set($btn1_class, first_set($btn_class, 'btn btn-primary'))}
    {include uri='design:explayouts/block/component/_link.tpl' link=$aa_l2 btn_class=first_set($btn2_class, 'btn btn-default')}
</div>
{/if}
{undef $aa_l1 $aa_l2}
