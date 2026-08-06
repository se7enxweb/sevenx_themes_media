


{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} image vl1">
    <i class="icon-camera article-icon" aria-hidden="true"></i>
    {def $im_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $im_img = $node.data_map.image.content}
        {if is_set($im_img['i480'])}{set $im_url = $im_img['i480'].url}
        {elseif is_set($im_img['large'])}{set $im_url = $im_img['large'].url}
        {elseif is_set($im_img['original'])}{set $im_url = $im_img['original'].url}{/if}
        {undef $im_img}
    {/if}
    <figure class="image">
        {if $im_url|ne('')}<a href={$node.url_alias|ezurl} title="{$node.name|wash}"><img src={$im_url|ezroot} loading="lazy" alt="{$node.name|wash}" class="ibexa_image-field" /></a>{/if}
    </figure>
    {undef $im_url}
    <header class="article-header">
        <h2 class="title"><a href={$node.url_alias|ezurl}><span class="ibexa_string-field">{$node.name|wash}</span></a></h2>
    </header>
</article>