


{* IMPORT content/macros/links.tpl AS links *}
{def $links = array()}

<div class="view-type view-type-{$view_type} ng-banner">
    <h3 class="title">
        {content_link($links, $content, $content.fields.title.value.text)}
    </h3>
</div>