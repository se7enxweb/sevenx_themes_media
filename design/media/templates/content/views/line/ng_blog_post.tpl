


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $node = fetch('content','node',hash('node_id',$location.node_id))}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-blog-post vl4">
    {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i320'}

    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
            <div class="info">
                {include uri='design:content/parts/author.tpl'}
                {include uri='design:content/parts/time.tpl'}
            </div>
        </header>
        {intro($content_fields, $content)}
    </div>
</article>