{* Line banner: unlinked span-wrapped image + plain title + description short *}
{def $node = fetch('content','node',hash('node_id',$location.node_id))}
{def $bn_url = ''}
{if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
    {def $bn_img = $node.data_map.image.content}
    {if is_set($bn_img['i480'])}{set $bn_url = $bn_img['i480'].url}
    {elseif is_set($bn_img['large'])}{set $bn_url = $bn_img['large'].url}
    {elseif is_set($bn_img['original'])}{set $bn_url = $bn_img['original'].url}{/if}
    {undef $bn_img}
{/if}
<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} ng-banner vl4">
    {if $bn_url|ne('')}
    <figure class="image">
        <span><img src={$bn_url|ezroot} loading="lazy" alt="" class="ibexa_image-field" /></span>
    </figure>
    {/if}
    <div class="article-content">
        <header class="article-header">
            <h3 class="title">
                {$node.name|wash}
            </h3>
        </header>
        {intro('', $content, 'description')}
    </div>
</article>
{undef $bn_url}
