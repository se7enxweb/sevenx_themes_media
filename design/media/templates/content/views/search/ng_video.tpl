{def $content_fields = array()}
{def $link_title = concat( 'Read more about ', title( $content_fields, $content ) )}
{def $short_text = ''}
{if and( hasField($content, 'teaser_intro'), not( $content.fields.teaser_intro['empty'] ) )}
    {set $short_text = $content.fields.teaser_intro.value.xml|strip_tags|trim|shorten(210)}
{elseif and( hasField($content, 'full_intro'), not( $content.fields.full_intro['empty'] ) )}
    {set $short_text = $content.fields.full_intro.value.xml|strip_tags|trim|shorten(210)}
{elseif and( hasField($content, 'body'), not( $content.fields.body['empty'] ) )}
    {set $short_text = $content.fields.body.value.xml|strip_tags|trim|shorten(210)}
{/if}
<article class="view-type view-type-search ng-video vl7">
    <div class="article-content">
        <div class="article-content-text">
            <header class="article-header">
                <h3 class="title"><a href="{ibexa_path($location)}" title="{$link_title|wash}">{title($content_fields, $content)}</a></h3>
                <div class="info">
                    {include uri='design:content/parts/time.tpl'}
                    <span class="type">{$content.contentInfo.contentTypeName}</span>
                </div>
            </header>
            {if $short_text|ne('')}
                <div class="short">{$short_text}</div>
            {/if}
        </div>

        {def $poster_url = ''}

        {if not($content.fields.poster['empty'])}
            {set $poster_url = ng_image_alias($content.fields.poster, 'i480')}
        {/if}

        {if and($poster_url|eq(''), not($content.fields.video_identifier['empty']))}
            {def $video_id = $content.fields.video_identifier.value.text}
            {def $video_types = $content.fields.video_type.value.identifiers}

            {if and(is_array($video_types), $video_types|contains('youtube'))}
                {set $poster_url = concat('https://img.youtube.com/vi/', $video_id, '/mqdefault.jpg')}
            {/if}
        {/if}

        {if $poster_url|eq('')}
            {set $poster_url = concat('/', asset('images/video_poster.png'))}
        {/if}

        {if $poster_url|ne('')}
            <figure class="image">
                <a href="{ibexa_path($location)}" class="ratio ratio-16x9" title="{$link_title|wash}">
                    <img src="{$poster_url}" alt="{$content.name|wash}" />
                </a>
                <i class="icon-play article-icon" aria-hidden="true"></i>
            </figure>
        {/if}
    </div>
</article>
