{* Component <picture>: desktop source (srcset_alias) + src alias. Params: cmp, pic_class, srcset_alias (default 'original'), src_alias (default 'i1920') *}
{def $cp_map = $cmp.data_map}
{if and(is_set($cp_map.image), $cp_map.image.has_content)}
{def $cp_img = $cp_map.image.content}
{def $cp_srcset = ''}
{def $cp_src = ''}
{def $cp_srcset_alias = first_set($srcset_alias, 'original')}
{def $cp_src_alias = first_set($src_alias, 'i1920')}

{def $cp_aliases = array($cp_srcset_alias)}
{if $cp_srcset_alias|ne('original')}{set $cp_aliases = $cp_aliases|append('large')}{/if}
{if $cp_srcset_alias|ne('large')}{set $cp_aliases = $cp_aliases|append('large')}{/if}
{set $cp_aliases = $cp_aliases|append('original')}
{foreach $cp_aliases as $cp_alias}
    {if and($cp_srcset|eq(''), is_set($cp_img[$cp_alias]))}{set $cp_srcset = $cp_img[$cp_alias].url}{/if}
{/foreach}

{def $cp_src_aliases = array($cp_src_alias, 'large', 'original')}
{foreach $cp_src_aliases as $cp_alias}
    {if and($cp_src|eq(''), is_set($cp_img[$cp_alias]))}{set $cp_src = $cp_img[$cp_alias].url}{/if}
{/foreach}

{if and($cp_srcset|ne(''), $cp_src|ne(''))}
<picture{if first_set($pic_class,'')|ne('')} class="{$pic_class}"{/if}>
    <source media="(min-width: 992px)" srcset={$cp_srcset|ezroot}>
    <img
    src={$cp_src|ezroot}
    alt="{$cp_img.alternative_text|wash}"
    class="ibexa_image-field"  />
</picture>
{/if}
{undef $cp_img $cp_srcset $cp_src $cp_srcset_alias $cp_src_alias $cp_aliases $cp_src_aliases}
{/if}
{undef $cp_map}
