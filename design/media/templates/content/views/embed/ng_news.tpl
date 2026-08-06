


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
<div class="view-type view-type-{$view_type} ng-news">

    {image($content_fields, $content, null, 'i320')}

    <h3><a href="{ibexa_path($content)}">{title($content_fields, $content)}</a></h3>

</div>