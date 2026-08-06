


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl5">
    {image($content_fields, $content, $location, 'i160')}

    <header class="article-header">
        <h2 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h2>
    </header>

</article>