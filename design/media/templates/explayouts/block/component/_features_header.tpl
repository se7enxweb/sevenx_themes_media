{* Features/about-style header: title+short in .text, both actions btn-default *}
{def $fh_map = $cmp.data_map}
<header class="article-header">
    <div class="text">
        {if and(is_set($fh_map.eyebrow_title), $fh_map.eyebrow_title.has_content)}
        <div class="eyebrow-title">
            <span         class="ibexa_string-field" >{$fh_map.eyebrow_title.content|wash}</span>
        </div>
        {/if}
        {if and(is_set($fh_map.title), $fh_map.title.has_content)}
        <h2 class="title">                <span         class="ibexa_string-field" >{$fh_map.title.content|wash}</span>
</h2>
        {/if}
        {if and(is_set($fh_map.description), $fh_map.description.has_content)}
        <div class="short">
            <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$fh_map.description}</div>
        </div>
        {/if}
    </div>
    {def $fh_l1 = false()}
    {def $fh_l2 = false()}
    {if is_set($fh_map.link_1)}{set $fh_l1 = enhanced_link($fh_map.link_1)}{/if}
    {if is_set($fh_map.link_2)}{set $fh_l2 = enhanced_link($fh_map.link_2)}{/if}
    {def $fh_show_actions = cond( is_set( $show_actions ), $show_actions, true )}
    {if and( $fh_show_actions, or( $fh_l1, $fh_l2 ) )}
    <div class="actions">
        {include uri='design:explayouts/block/component/_link.tpl' link=$fh_l1 btn_class=first_set($btn1, 'btn btn-default')}
        {include uri='design:explayouts/block/component/_link.tpl' link=$fh_l2 btn_class=first_set($btn2, 'btn btn-default')}
    </div>
    {/if}
    {undef $fh_show_actions}
    {undef $fh_l1 $fh_l2}
</header>
{undef $fh_map}
