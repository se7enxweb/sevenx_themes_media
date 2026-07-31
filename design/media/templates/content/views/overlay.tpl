


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl2">
    {image($content_fields, $content, $location, null, null)}

    <header class="article-header">
        <h2 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h2>
    </header>
</article>