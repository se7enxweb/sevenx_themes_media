


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-article vl5">
    {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i160'}

    <header class="article-header">
        <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
        <div class="info">
            {include uri='design:content/parts/author.tpl'}
        </div>
    </header>
</article>