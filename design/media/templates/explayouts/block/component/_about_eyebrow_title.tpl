{def $ae_map = $cmp.data_map}
{if and(is_set($ae_map.eyebrow_title), $ae_map.eyebrow_title.has_content)}
<div class="eyebrow-title">
    <span         class="ibexa_string-field" >{$ae_map.eyebrow_title.content|wash}</span>
</div>
{/if}
{if and(is_set($ae_map.title), $ae_map.title.has_content)}
<h2 class="title">
    <span         class="ibexa_string-field" >{$ae_map.title.content|wash}</span>
</h2>
{/if}
{undef $ae_map}
