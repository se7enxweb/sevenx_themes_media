


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

<article class="view-type view-type-{$view_type} ng-news vl1">

    {image($content_fields, $content, $location, null, false)}

    <header class="article-header">
        <h2 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h2>
        <div class="info">
            {if not($content.fields.authors['empty'])}
                {foreach fieldRelations($content, 'authors') as $author}
                    <a href="{ibexa_path($author)}" class="article-author">{$author.name}</a>
                {/foreach}
            {/if}
            <time>{$content.fields.publish_date.value.value|format_date}</time>
            {if not($content.fields.sponsored_content_disclosure['empty'])}
                <span class="sponsored-tag">{$'ngsite.layout.sponsored'|trans}</span>
            {elseif not($content.fields.main_topic['empty'])}
                <a href="{ngsite_topic_path($content.fields.main_topic.value.tags[0])}">{$content.fields.main_topic.value.tags[0].keyword}</a>
            {/if}
        </div>
    </header>

    {intro($content_fields, $content)}
</article>