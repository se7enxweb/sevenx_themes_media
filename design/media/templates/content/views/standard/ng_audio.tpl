


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-audio vl1">
    <i class="icon-volume-up article-icon" aria-hidden="true"></i>
    
{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))} 
{include uri='design:content/parts/item_image.tpl' node=$node}

    <header class="article-header">
        <h3 class="title">
            <a href={$node.url_alias|ezurl}>
                {title($content_fields, $content)}
            </a>
        </h3>
    </header>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>