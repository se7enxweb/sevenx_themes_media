


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $node = fetch('content','node',hash('node_id',$location.node_id))}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-gallery vl4">
    <i class="icon-camera article-icon" aria-hidden="true"></i>

    {def $children = filterChildren($location, array('image'), 1)}

    {if $children|count()|gt(0)}
        {def $gl_img_node = $children[0]}
        {def $gl_url = ''}
        {if and(is_set($gl_img_node.data_map.image), $gl_img_node.data_map.image.has_content)}
            {def $gl_obj = $gl_img_node.data_map.image.content}
            {if is_set($gl_obj['i320'])}{set $gl_url = $gl_obj['i320'].url}
            {elseif is_set($gl_obj['large'])}{set $gl_url = $gl_obj['large'].url}
            {elseif is_set($gl_obj['original'])}{set $gl_url = $gl_obj['original'].url}{/if}
        {/if}
        {if $gl_url|ne('')}
        <figure class="image">
            <a href={$node.url_alias|ezurl} title="Read more about {$node.name|wash}"><img src={$gl_url|ezroot} loading="lazy" alt="" class="ibexa_image-field"></a>
        </figure>
        {/if}
        {undef $gl_img_node $gl_url}
    {/if}
    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
        </header>
        {intro($content_fields, $content)}
    </div>
</article>