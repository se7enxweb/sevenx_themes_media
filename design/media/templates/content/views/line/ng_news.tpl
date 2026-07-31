


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-news vl4">
    {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i320'}

    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
            <div class="info">
                {include uri='design:content/parts/author.tpl'}
                {include uri='design:content/parts/time.tpl'}
            </div>
        </header>
        {intro($content_fields, $content)}
    </div>
</article>