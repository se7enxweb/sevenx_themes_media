


{* IMPORT content/macros/slide.tpl AS slide *}
{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} image vl3">
    {def $title = title($content_fields, $content)}

    <a href="{asset(ng_image_alias($content.fields.image, 'i1320'))}" title="{$title}" class="js-lightbox-item" data-pswp-width="{$content.fields.image.value.width}" data-pswp-height="{$content.fields.image.value.height}">
        {image($slide, $content)}
    </a>
</div>