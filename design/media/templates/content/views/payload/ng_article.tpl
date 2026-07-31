


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

<article class="view-type view-type-{$view_type} ng-article vl4">

    {image($content_fields, $content, $location, 'i320')}

    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
            <div class="info">
                {include uri='design:content/parts/author.tpl'}
            </div>
        </header>
        <div class="short">
            {intro($content_fields, $content)}
        </div>
    </div>
</article>