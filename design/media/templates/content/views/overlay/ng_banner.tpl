{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))}
{def $bn_link = false()}
{if is_set($node.data_map.link)}{set $bn_link = enhanced_link($node.data_map.link)}{/if}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-banner vl2">
    {if $bn_link}
    {include uri='design:content/parts/item_image.tpl' node=$node}
    <header class="article-header">
        <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
    </header>
    {else}
    {def $bn_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $bn_img = $node.data_map.image.content}
        {if is_set($bn_img['i480'])}{set $bn_url = $bn_img['i480'].url}
        {elseif is_set($bn_img['large'])}{set $bn_url = $bn_img['large'].url}
        {elseif is_set($bn_img['original'])}{set $bn_url = $bn_img['original'].url}{/if}
        {undef $bn_img}
    {/if}
    {if $bn_url|ne('')}
    <figure class="image">
        <span><img
            src={$bn_url|ezroot}
            loading="lazy"                                                alt=""
                    class="ibexa_image-field"  /></span>
    </figure>
    {/if}
    {undef $bn_url}
    <header class="article-header">
        <h3 class="title">
    {$node.name|wash}
            </h3>
    </header>
    {/if}
</article>
{undef $bn_link}
