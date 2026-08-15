{def $as_map = $cmp.data_map}
{if and(is_set($as_map.description), $as_map.description.has_content)}
<div class="short">
    <div class="ibexa_richtext-field">{attribute_view_gui attribute=$as_map.description}</div>
</div>
{/if}
{undef $as_map}
