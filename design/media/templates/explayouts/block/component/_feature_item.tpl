{* One features-grid item. Params: cmp, idx, kind ('icon'|'highlight'|'image') *}
{def $fi_map = $cmp.data_map}
{def $fi_title = $fi_map[concat('item_', $idx, '_title')]}
{if and(is_set($fi_title), $fi_title.has_content)}
<div class="features-grid-item">
    {if $kind|eq('icon')}
        {def $fi_icon = $fi_map[concat('item_', $idx, '_icon')]}
        {if and(is_set($fi_icon), $fi_icon.has_content)}
        <div class="item-icon">
            <img src={concat('/var/site/storage/original/image/', $fi_icon.content.filename)|ezroot} alt="" aria-hidden="true" />
        </div>
        {/if}
        {undef $fi_icon}
    {elseif $kind|eq('highlight')}
        {def $fi_hl = $fi_map[concat('item_', $idx, '_highlight_title')]}
        {if and(is_set($fi_hl), $fi_hl.has_content)}
        <div class="item-highlight-title">
            <span         class="ibexa_string-field" >{$fi_hl.content|wash}</span>
        </div>
        {/if}
        {undef $fi_hl}
    {elseif $kind|eq('image')}
        {def $fi_img_attr = $fi_map[concat('item_', $idx, '_image')]}
        {if and(is_set($fi_img_attr), $fi_img_attr.has_content)}
        {def $fi_img = $fi_img_attr.content}
        {def $fi_url = ''}
        {if is_set($fi_img['i770'])}{set $fi_url = $fi_img['i770'].url}
        {elseif is_set($fi_img['large'])}{set $fi_url = $fi_img['large'].url}
        {elseif is_set($fi_img['original'])}{set $fi_url = $fi_img['original'].url}{/if}
        {if $fi_url|ne('')}
        <div class="item-image">
            <img
            src={$fi_url|ezroot}
            loading="lazy"                                                alt="{$fi_img.alternative_text|wash}"
                    class="ibexa_image-field"  />
        </div>
        {/if}
        {undef $fi_img $fi_url}
        {/if}
        {undef $fi_img_attr}
    {/if}
    {if first_set($item_wrap, 0)}<div class="item-content">{/if}
    {def $fi_link = false()}
    {def $fi_link_attr = $fi_map[concat('item_', $idx, '_link')]}
    {if is_set($fi_link_attr)}{set $fi_link = enhanced_link($fi_link_attr)}{/if}
    {if $fi_link}
    {def $fi_link_rel = false()}
    {if and($fi_link.target|eq('_blank'), or($fi_link.href|contains('http://'), $fi_link.href|contains('https://')))}{set $fi_link_rel = 'nofollow noopener noreferrer'}{/if}
    <h3 class="item-title"><a href="{$fi_link.href|wash}"
        {if $fi_link.target|ne('')}target="{$fi_link.target}"{/if}{if $fi_link_rel} rel="{$fi_link_rel|wash}"         {/if}>
    {$fi_title.content|wash}
            </a></h3>
    {undef $fi_link_rel}
    {else}
    <h3 class="item-title">{$fi_title.content|wash}</h3>
    {/if}
    {def $fi_short = $fi_map[concat('item_', $idx, '_description')]}
    {if and(is_set($fi_short), $fi_short.has_content)}
    <div class="{first_set($short_class, 'item-short')}">
        <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$fi_short}</div>
    </div>
    {/if}
    {undef $fi_short}
    {if $fi_link}
    <div class="item-actions">
        {include uri='design:explayouts/block/component/_link.tpl' link=$fi_link btn_class='btn btn-link'}
    </div>
    {/if}
    {undef $fi_link $fi_link_attr}
    {if first_set($item_wrap, 0)}</div>{/if}
</div>
{/if}
{undef $fi_map $fi_title}
