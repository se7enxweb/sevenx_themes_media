


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-audio vl1">
    <i class="icon-volume-up article-icon" aria-hidden="true"></i>
    
{def $node = fetch('content','node',hash('node_id',$location.node_id))} 
{include uri='design:content/parts/item_image.tpl' node=$node}$content_fields, $content, $location)}

    <header class="article-header">
        <h3 class="title">
            <a href="{$node.url_alias|ezurl}">
                {title($content_fields, $content)}
            </a>
        </h3>
    </header>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>