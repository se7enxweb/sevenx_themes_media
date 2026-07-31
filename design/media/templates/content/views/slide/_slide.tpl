{* Shared slide item. Params: node, with_link, show_info, date_mode ('', 'author_time', 'time_first') *}
<div     data-item="true"
            data-content-id="{$node.contentobject_id}"
            data-location-id="{$node.node_id}"
        class="view-type view-type-slide {$node.class_identifier|ristring('_','-')} vl3">
    {def $sl_ident = ''}
    {if and(is_set($node.data_map.video_identifier), $node.data_map.video_identifier.has_content)}
        {set $sl_ident = $node.data_map.video_identifier.content}
    {/if}
    {if $sl_ident|ne('')}
    <img  src="https://img.youtube.com/vi/{$sl_ident}/mqdefault.jpg" alt="" />
    {else}
    {def $sl_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $sl_img = $node.data_map.image.content}
        {if is_set($sl_img['i1320'])}{set $sl_url = $sl_img['i1320'].url}
        {elseif is_set($sl_img['large'])}{set $sl_url = $sl_img['large'].url}
        {elseif is_set($sl_img['original'])}{set $sl_url = $sl_img['original'].url}{/if}
        {undef $sl_img}
    {elseif and(is_set($node.data_map.teaser_image), $node.data_map.teaser_image.has_content)}
        {def $sl_img = $node.data_map.teaser_image.content}
        {if is_set($sl_img['i1320'])}{set $sl_url = $sl_img['i1320'].url}
        {elseif is_set($sl_img['large'])}{set $sl_url = $sl_img['large'].url}
        {elseif is_set($sl_img['original'])}{set $sl_url = $sl_img['original'].url}{/if}
        {undef $sl_img}
    {/if}
    {if $sl_url|ne('')}
    <img
            src={$sl_url|ezroot}
            alt=""
                    class="ibexa_image-field"  />
    {/if}
    {undef $sl_url}
    {/if}
    {undef $sl_ident}
    {if first_set($show_info, 1)}
    <div class="info">
        {if first_set($date_mode, '')|eq('time_first')}
        <div class="date">
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </div>
        {/if}
        {if first_set($with_link, 1)}
        <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
        {else}
        <h3 class="title">
    {$node.name|wash}
            </h3>
        {/if}
        {if first_set($date_mode, '')|eq('author_time')}
        <div class="date">
            {include uri='design:content/parts/author.tpl' content=$node.object node=$node}
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </div>
        {/if}
    </div>
    {/if}
</div>
