{def $content_fields = array()}
{def $video = array()}
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
                {if hasField($content, 'teaser_intro')}
                    {if not($content.fields.teaser_intro['empty'])}
                        {ng_render_field($content.fields.teaser_intro)}
                    {/if}
                {else}
                    {if hasField($content, 'full_intro')}
                        {if not($content.fields.full_intro['empty'])}
                            {ng_render_field($content.fields.full_intro)}
                        {/if}
                    {else}
                        {if hasField($content, 'body')}
                            {if not($content.fields.body['empty'])}
                                {saveXML($content.fields.body.value.xml)|strip_tags|trim|u.truncate(210)}
                            {/if}
                        {/if}
                    {/if}
                {/if}
            </div>
        </div>
        {def $has_video_file = false()}
        {def $has_video_ident = false()}
        {if hasField($content, 'video_file')}
            {if not($content.fields.video_file['empty'])}
                {set $has_video_file = true()}
            {/if}
        {/if}
        {if hasField($content, 'video_identifier')}
            {if not($content.fields.video_identifier['empty'])}
                {set $has_video_ident = true()}
            {/if}
        {/if}
        {if or($has_video_file, $has_video_ident)}
            <figure class="image">
                <i class="icon-play article-icon" aria-hidden="true"></i>
                {poster($video, $content, $location)}
            </figure>
        {/if}
    </div>
</article>
