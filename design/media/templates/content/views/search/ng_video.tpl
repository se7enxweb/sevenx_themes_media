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

        {* Poster: the poster image, else the video service's own thumbnail,
           else the theme's placeholder -- the same order as the video poster
           macro. Vimeo and Dailymotion have no URL to build here, so the img
           carries the video id and the VideoPoster script (selector
           .video-poster) fetches the thumbnail. Without that class nothing
           filled it, and a Vimeo result fell through to the placeholder.
           Read from the node's data map, as the other video views do:
           video_type keeps the option id in data_int (1 YouTube, 2 Vimeo,
           3 Dailymotion, 4 uploaded) and its text is usually empty, so the
           field-API identifiers came back empty for every video. *}
        {def $poster_url = ''}
        {def $poster_service = ''}
        {def $video_id = ''}
        {def $sr_map = $node.data_map}

        {if and(is_set($sr_map.poster), $sr_map.poster.has_content)}
            {def $sr_poster = $sr_map.poster.content}
            {if is_set($sr_poster['i480'])}
                {set $poster_url = $sr_poster['i480'].url|ezroot(no)}
            {elseif is_set($sr_poster['original'])}
                {set $poster_url = $sr_poster['original'].url|ezroot(no)}
            {/if}
        {/if}

        {if and($poster_url|eq(''), is_set($sr_map.video_identifier), $sr_map.video_identifier.has_content)}
            {set $video_id = $sr_map.video_identifier.content}
            {def $sr_type = ''}
            {if is_set($sr_map.video_type)}
                {set $sr_type = $sr_map.video_type.data_text}
                {if $sr_type|eq('')}
                    {set $sr_type = cond( $sr_map.video_type.data_int|eq(2), 'vimeo',
                                          $sr_map.video_type.data_int|eq(3), 'dailymotion',
                                          $sr_map.video_type.data_int|eq(4), 'upload',
                                          'youtube' )}
                {/if}
            {/if}

            {* Vimeo and Dailymotion: a copy of the thumbnail kept on this site,
               so the preview does not depend on the browser being allowed to
               reach those services. Only if that fails is it left to the
               VideoPoster script. *}
            {if or($sr_type|contains('vimeo'), $sr_type|contains('dailymotion'))}
                {set $poster_url = video_thumbnail(cond($sr_type|contains('vimeo'), 'vimeo', 'dailymotion'), $video_id)}
                {if $poster_url|eq('')}
                    {set $poster_service = cond($sr_type|contains('vimeo'), 'vimeo', 'dailymotion')}
                {/if}
            {elseif $sr_type|ne('upload')}
                {set $poster_url = concat('https://img.youtube.com/vi/', $video_id, '/mqdefault.jpg')}
            {/if}
        {/if}

        {if and($poster_url|eq(''), $poster_service|eq(''))}
            {set $poster_url = concat('/', asset('images/video_poster.png'))}
        {/if}

        <figure class="image">
            <a href="{ibexa_path($location)}" class="ratio ratio-16x9" title="{$link_title|wash}">
                {if $poster_service|eq('vimeo')}
                    <img src="" class="video-poster vimeo-poster" data-id="{$video_id|wash}" data-thumbname="thumbnail_large" alt="{$content.name|wash}" />
                {elseif $poster_service|eq('dailymotion')}
                    <img src="" class="video-poster dailymotion-poster" data-id="{$video_id|wash}" data-thumbname="thumbnail_360_url" alt="{$content.name|wash}" />
                {else}
                    <img src="{$poster_url}" alt="{$content.name|wash}" />
                {/if}
            </a>
            <i class="icon-play article-icon" aria-hidden="true"></i>
        </figure>
    </div>
</article>
