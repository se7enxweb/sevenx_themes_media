


{* IMPORT content/macros/links.tpl AS links *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-banner vl5">
    {def $bn_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $bn_img = $node.data_map.image.content}
        {if is_set($bn_img['i160'])}{set $bn_url = $bn_img['i160'].url}
        {elseif is_set($bn_img['large'])}{set $bn_url = $bn_img['large'].url}
        {elseif is_set($bn_img['original'])}{set $bn_url = $bn_img['original'].url}{/if}
        {undef $bn_img}
    {/if}
    {if $bn_url|ne('')}
        <figure class="image">
            <span><img src={$bn_url|ezroot} loading="lazy" alt="" class="ibexa_image-field" /></span>
        </figure>
    {/if}
    {undef $bn_url}
    <header class="article-header">
        <h3 class="title">
            {$node.name|wash}
        </h3>
    </header>
</article>