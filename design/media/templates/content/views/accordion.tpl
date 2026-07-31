


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl10">
    <h3 class="title">
        <a role="button" href="#collapse-{$location.id}" role="button" class="collapsed" data-bs-toggle="collapse" aria-expanded="false" aria-controls="collapse-{$location.id}">
            {title($content_fields, $content)}
        </a>
    </h3>

    <div id="collapse-{$location.id}" class="collapse" aria-labelledby="heading-{$location.id}" data-bs-parent=".list-accordion">
        <div class="short">
            {intro($content_fields, $content)}
        </div>
    </div>
</article>