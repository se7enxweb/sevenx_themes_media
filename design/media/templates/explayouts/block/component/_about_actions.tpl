{def $aa_l1 = false()}
{if is_set($cmp.data_map.link_1)}{set $aa_l1 = enhanced_link($cmp.data_map.link_1)}{/if}
{if $aa_l1}
<div class="actions">
    {include uri='design:explayouts/block/component/_link.tpl' link=$aa_l1 btn_class=first_set($btn_class, 'btn btn-primary')}
</div>
{/if}
{undef $aa_l1}
