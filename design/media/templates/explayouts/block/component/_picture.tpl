{* Component <picture>: desktop source + i1920 img. Params: cmp, pic_class *}
{def $cp_map = $cmp.data_map}
{if and(is_set($cp_map.image), $cp_map.image.has_content)}
{def $cp_img = $cp_map.image.content}
{def $cp_url = ''}
{if is_set($cp_img['i1920'])}{set $cp_url = $cp_img['i1920'].url}
{elseif is_set($cp_img['large'])}{set $cp_url = $cp_img['large'].url}
{elseif is_set($cp_img['original'])}{set $cp_url = $cp_img['original'].url}{/if}
{if $cp_url|ne('')}
<picture{if first_set($pic_class,'')|ne('')} class="{$pic_class}"{/if}>
    <source media="(min-width: 992px)" srcset={$cp_url|ezroot}>
    <img
    src={$cp_url|ezroot}
    alt="{$cp_img.alternative_text|wash}"
    class="ibexa_image-field"  />
</picture>
{/if}
{undef $cp_img $cp_url}
{/if}
{undef $cp_map}
