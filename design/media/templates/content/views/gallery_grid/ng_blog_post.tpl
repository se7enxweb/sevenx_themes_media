


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
{if not($content.fields.image['empty'])}
    <div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-blog-post vl3">
        {if not($content.fields.authors['empty'])}
            {def $author = fieldRelations($content, 'authors')[0].name}
        {else}
            {def $author = $content.owner.name}
        {/if}

        {def $date = $content.fields.publish_date.value.value|format_date}
        {def $title = title($content_fields, $content)}

        <a href="{asset(ng_image_alias($content.fields.image, 'i1320'))}" title="{$title} by {$author} ({$date})" class="js-lightbox-item" data-pswp-width="{$content.fields.image.value.width}" data-pswp-height="{$content.fields.image.value.height}">
            {ng_render_field($content.fields.image, hash('parameters', hash('alias', 'i1320', 'alt_text', $title)))}
        </a>
    </div>
{/if}