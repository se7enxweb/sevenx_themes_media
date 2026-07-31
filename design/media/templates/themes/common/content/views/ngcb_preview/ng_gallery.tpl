


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $location_path = ibexa_path($location)}
{def $children = filterChildren($location, array('image'), 1)}

<article class="view-type view-type-{$view_type} ng-gallery vl1">
    <i class="icon-camera article-icon" aria-hidden="true"></i>
    {if not(($children.searchHits|count()|eq(0)))}
        {def $first_image = $children[0].content}

        <figure class="image">
            {ng_render_field($first_image.fields.image, hash('parameters', hash('alias', 'i480', 'alt_text', $first_image.fields.name.value, 'link_href', $location_path, 'lazy_loading', false)))}
        </figure>
    {/if}
    <header class="article-header">
        <h2 class="title"><a href="{$location_path}">{title($content_fields, $content)}</a></h2>
        <div class="info">
            {if not($content.fields.sponsored_content_disclosure['empty'])}
                <span class="sponsored-tag">{$'ngsite.layout.sponsored'|trans}</span>
            {elseif not($content.fields.main_topic['empty'])}
                <a href="{ngsite_topic_path($content.fields.main_topic.value.tags[0])}">{$content.fields.main_topic.value.tags[0].keyword}</a>
            {/if}
        </div>
    </header>

    {intro($content_fields, $content)}
</article>