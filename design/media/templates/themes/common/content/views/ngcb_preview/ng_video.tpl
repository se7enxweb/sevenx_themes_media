


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT content/macros/video.tpl AS video *}

{if or(not($content.fields.video_file['empty']), not($content.fields.video_identifier['empty']))}
    <article class="view-type view-type-{$view_type} ng-video vl1">
        <i class="icon-play article-icon" aria-hidden="true"></i>
        <figure class="image">
            {poster($video, $content, $location)}
        </figure>

        <header class="article-header">
            <h2 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h2>
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
{/if}