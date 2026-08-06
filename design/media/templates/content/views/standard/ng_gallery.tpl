{def $content_fields = array()}
{def $toolbar_macros = array()}

{set $node = fetch('content','node',hash('node_id',$location.node_id))}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-gallery vl1">
    <i class="icon-camera article-icon" aria-hidden="true"></i>

    {def $children = filterChildren($location, array('image'), 1)}
    {if $children|count|gt(0)}
        {def $gs_img_node = $children[0]}
        {def $gs_url = ''}
        {if and(is_set($gs_img_node.data_map.image), $gs_img_node.data_map.image.has_content)}
            {def $gs_obj = $gs_img_node.data_map.image.content}
            {if is_set($gs_obj['i480'])}{set $gs_url = $gs_obj['i480'].url}
            {elseif is_set($gs_obj['large'])}{set $gs_url = $gs_obj['large'].url}
            {elseif is_set($gs_obj['original'])}{set $gs_url = $gs_obj['original'].url}{/if}
        {/if}
        {if $gs_url|ne('')}
        <figure class="image">
            <a href={$node.url_alias|ezurl} title="Read more about {$node.name|wash}"><img src={$gs_url|ezroot} loading="lazy" alt="" class="ibexa_image-field"></a>
        </figure>
        {/if}
        {undef $gs_img_node $gs_url}
    {/if}

    <header class="article-header">
        <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
    </header>
    {if first_set($with_intro, false)}
        {intro('', $content)}
    {/if}
</article>
