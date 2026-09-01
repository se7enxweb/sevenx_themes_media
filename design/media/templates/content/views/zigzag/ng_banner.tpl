{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))}
{def $zb_link = false()}
{if is_set($node.data_map.link)}{set $zb_link = enhanced_link($node.data_map.link)}{/if}
<article     data-item="true"
            data-content-id="{$node.contentobject_id}"
            data-location-id="{$node.node_id}"
        class="view-type view-type-{$view_type} ng-banner vl9">
    {def $zb_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $zb_img = $node.data_map.image.content}
        {if is_set($zb_img['i770'])}{set $zb_url = $zb_img['i770'].url}
        {elseif is_set($zb_img['large'])}{set $zb_url = $zb_img['large'].url}
        {elseif is_set($zb_img['original'])}{set $zb_url = $zb_img['original'].url}{/if}
        {undef $zb_img}
    {/if}
    {if $zb_url|ne('')}
    <figure class="image">
        <span>
            <img
                src={$zb_url|ezroot}
                loading="lazy"                                                alt=""
                        class="ibexa_image-field"  />
        </span>
    </figure>
    {/if}
    {undef $zb_url}
    <div class="article-content">
        <header class="article-header">
            {if and(is_set($node.data_map.eyebrow_title), $node.data_map.eyebrow_title.has_content)}
            <span class="eyebrow-title">{$node.data_map.eyebrow_title.content|wash}</span>
            {/if}
            {if $zb_link}
            <h3 class="title"><a href="{$zb_link.href|wash}">{$node.name|wash}</a></h3>
            {else}
            <h3 class="title">
    {$node.name|wash}
            </h3>
            {/if}
        </header>
        {if and(is_set($node.data_map.description), $node.data_map.description.has_content)}
        <div class="short">
            <div         class="ibexa_richtext-field" >{attribute_view_gui attribute=$node.data_map.description}</div>
        </div>
        {/if}
    </div>
</article>
{undef $zb_link}
