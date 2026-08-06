


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
<div class="view-type view-type-{$view_type} ng-blog-post">
    <h3><a href="{ibexa_path($content)}">{title($content_fields, $content)}</a></h3>

    <div class="date">
        {include uri='design:content/parts/time.tpl'}
    </div>

    {include uri='design:content/parts/author.tpl'}

    {image($content_fields, $content, null, 'i320')}
</div>