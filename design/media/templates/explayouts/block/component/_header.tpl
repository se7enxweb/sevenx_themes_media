{* Component header: eyebrow, title (tag param, default h1), short, actions.
   Params: cmp (object), title_tag *}
{def $ch_map = $cmp.data_map}
{def $ch_tag = first_set($title_tag, 'h1')}
{if and(is_set($ch_map.eyebrow_title), $ch_map.eyebrow_title.has_content)}
    <div class="eyebrow-title">
        <span         class="ibexa_string-field" >{$ch_map.eyebrow_title.content|wash}</span>
    </div>
{/if}
{if and(is_set($ch_map.title), $ch_map.title.has_content)}
    <{$ch_tag} class="title">
        <span         class="ibexa_string-field" >{$ch_map.title.content|wash}</span>
    </{$ch_tag}>
{/if}
{if and(is_set($ch_map.description), $ch_map.description.has_content)}
    <div class="short">
        <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$ch_map.description}</div>
    </div>
{/if}
{def $ch_l1 = false()}
{def $ch_l2 = false()}
{if is_set($ch_map.link_1)}{set $ch_l1 = enhanced_link($ch_map.link_1)}{/if}
{if is_set($ch_map.link_2)}{set $ch_l2 = enhanced_link($ch_map.link_2)}{/if}
{if or($ch_l1, $ch_l2)}
<div class="actions">
    {include uri='design:explayouts/block/component/_link.tpl' link=$ch_l1 btn_class='btn btn-primary'}
    {include uri='design:explayouts/block/component/_link.tpl' link=$ch_l2 btn_class='btn btn-default'}
</div>
{/if}
{undef $ch_map $ch_tag $ch_l1 $ch_l2}
