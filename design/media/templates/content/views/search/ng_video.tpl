


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT content/macros/video.tpl AS video *}

<article class="view-type view-type-search ng-video vl7">
    <div class="article-content">
        <div class="article-content-text">
            <header class="article-header">
                <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
                <div class="info">
                    {include uri='design:content/parts/time.tpl'}
                    <span class="type">{$content.contentInfo.contentTypeName}</span>
                </div>
            </header>
            <div class="short">
                {if and(hasField($content, 'teaser_intro'), not($content.fields.teaser_intro['empty']))}
                    {ng_render_field($content.fields.teaser_intro)}
                {elseif and(hasField($content, 'full_intro'), not($content.fields.full_intro['empty']))}
                    {ng_render_field($content.fields.full_intro)}
                {elseif and(hasField($content, 'body'), not($content.fields.body['empty']))}
                    {saveXML($content.fields.body.value.xml)|strip_tags|trim|u.truncate(210)}
                {/if}
            </div>
        </div>
        {if or(not($content.fields.video_file['empty']), not($content.fields.video_identifier['empty']))}
            <figure class="image">
                <i class="icon-play article-icon" aria-hidden="true"></i>
                {poster($video, $content, $location)}
            </figure>
        {/if}
    </div>
</article>