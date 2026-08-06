{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-article vl2">
    <i class="icon-camera article-icon" aria-hidden="true"></i>

    {def $children = fetch('content','list',hash('parent_node_id',$location.node_id,'class_filter_type','include','class_filter_array',array('image'),'limit',1,'sort_by',array('priority',true())))}

    {if $children|count()|gt(0)}
        {def $first_node = $children[0]}
        {def $img_url = ''}
        {if and(is_set($first_node.data_map.image), $first_node.data_map.image.has_content)}
            {set $img_url = ng_image_alias($first_node.data_map.image, 'i480')}
            {if $img_url|eq('')}{set $img_url = ng_image_alias($first_node.data_map.image, 'large')}{/if}
            {if $img_url|eq('')}{set $img_url = ng_image_alias($first_node.data_map.image, 'original')}{/if}
        {/if}

        {if $img_url|ne('')}
        <figure class="image">
            <a href={$node.url_alias|ezurl} aria-label="{$first_node.name|wash}">
                <img src={$img_url|ezroot} alt="{$first_node.name|wash}" class="ibexa_image-field" />
            </a>
        </figure>
        {/if}
    {/if}

    <header class="article-header">
        <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
    </header>
</article>
