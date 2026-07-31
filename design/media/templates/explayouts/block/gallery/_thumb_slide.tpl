{* One thumb-gallery slide. Params: node, alias, show_info *}
<div     data-item="true"
            data-content-id="{$node.contentobject_id}"
            data-location-id="{$node.node_id}"
        class="view-type view-type-gallery_thumb {$node.class_identifier|ristring('_','-')} vl3 ">
    {def $ts_ident = ''}
    {if and(is_set($node.data_map.video_identifier), $node.data_map.video_identifier.has_content)}
        {set $ts_ident = $node.data_map.video_identifier.content}
    {/if}
    {if $ts_ident|ne('')}
    <img  src="https://img.youtube.com/vi/{$ts_ident}/mqdefault.jpg" alt="" />
    {else}
    {def $ts_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $ts_img = $node.data_map.image.content}
        {if is_set($ts_img[$alias])}{set $ts_url = $ts_img[$alias].url}
        {elseif is_set($ts_img['original'])}{set $ts_url = $ts_img['original'].url}{/if}
        {undef $ts_img}
    {elseif and(is_set($node.data_map.teaser_image), $node.data_map.teaser_image.has_content)}
        {def $ts_img = $node.data_map.teaser_image.content}
        {if is_set($ts_img[$alias])}{set $ts_url = $ts_img[$alias].url}
        {elseif is_set($ts_img['original'])}{set $ts_url = $ts_img['original'].url}{/if}
        {undef $ts_img}
    {/if}
    {if $ts_url|ne('')}
    <img
            src={$ts_url|ezroot}
            {if $show_info}loading="lazy"                                                {/if}alt=""
                    class="ibexa_image-field"  />
    {/if}
    {undef $ts_url}
    {/if}
    {if and($show_info, $node.class_identifier|ne('image'))}
    <div class="info">
        {if $node.class_identifier|eq('ng_news')}
        <div class="date">
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </div>
        {/if}
        {if $node.class_identifier|eq('ng_banner')}
        <h2 class="title">
    {$node.name|wash}
            </h2>
        {else}
        <h2 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>
        {/if}
        {if $node.class_identifier|eq('ng_blog_post')}
        <div class="date">
            {include uri='design:content/parts/author.tpl' content=$node.object node=$node}
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </div>
        {/if}
    </div>
    {/if}
    {undef $ts_ident}
</div>
