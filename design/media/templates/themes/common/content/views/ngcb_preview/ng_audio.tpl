


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

<article class="view-type view-type-{$view_type} ng-audio vl1">
    <i class="icon-volume-up article-icon" aria-hidden="true"></i>
    {image($content_fields, $content, $location, null, false)}

    <header class="article-header">
        <h2 class="title">
            <a href="{ibexa_path($location)}">
                {title($content_fields, $content)}
            </a>
        </h2>
    </header>

    {intro($content_fields, $content)}
</article>