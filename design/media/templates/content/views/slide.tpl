


{* IMPORT content/macros/slide.tpl AS slide *}
{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl3">
    {image($slide, $content)}

    <div class="info">
        <h2 class="title"><a href={ibexa_path($location)}>{title($content_fields, $content)}</a></h2>
    </div>
</div>