


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-gallery vl5">
    {def $gl_children = fetch('content','list',hash('parent_node_id',$location.node_id,'class_filter_type','include','class_filter_array',array('image'),'limit',1,'sort_by',array('priority',true())))}
    {if $gl_children|count()|gt(0)}
        {def $gl_img_node = $gl_children[0]}
        {def $gl_url = ''}
        {if and(is_set($gl_img_node.data_map.image), $gl_img_node.data_map.image.has_content)}
            {def $gl_obj = $gl_img_node.data_map.image.content}
            {if is_set($gl_obj['i480'])}{set $gl_url = $gl_obj['i480'].url}
            {elseif is_set($gl_obj['large'])}{set $gl_url = $gl_obj['large'].url}
            {elseif is_set($gl_obj['original'])}{set $gl_url = $gl_obj['original'].url}{/if}
            {undef $gl_obj}
        {/if}
        {if $gl_url|ne('')}
        <figure class="image">
            <i class="icon-camera article-icon" aria-hidden="true"></i>
            <a href={$node.url_alias|ezurl} title="{$gl_img_node.name|wash}"><img src={$gl_url|ezroot} loading="lazy" alt="{$gl_img_node.name|wash}" class="ibexa_image-field" /></a>
        </figure>
        {/if}
        {undef $gl_img_node $gl_url}
    {/if}
    {undef $gl_children}
    <header class="article-header">
        <h3 class="title"><a href={$node.url_alias|ezurl}>{title($content_fields, $content)}</a></h3>
    </header>
</article>