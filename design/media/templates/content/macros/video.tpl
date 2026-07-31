


{* MACRO poster($content, $location, $alias_name, $image_ratio) *}
    {if and(is_set($content.fields.title), not(($content.fields.title|count()|eq(0))))}
        {def $link_title = concat('ngsite.read_more_about'|trans, ' ', $content.fields.title.value.text)}
    {else}
        {def $link_title = concat('ngsite.read_more_about'|trans, ' ', $content.name)}
    {/if}

    {def $alias_name = first_set($alias_name, 'i480')}
    {def $image_ratio = first_set($image_ratio, 'ratio-16x9')}

    <a href="{ibexa_path(cond(not(($location|count()|eq(0))), $location, $content))}" class="ratio {$image_ratio}" title="{$link_title}">
        {if not($content.fields.poster['empty'])}
            {ng_render_field($content.fields.poster, hash('parameters', hash('alias', $alias_name)))}
        {elseif not($content.fields.video_identifier['empty'])}
            {def $video_identifier = $content.fields.video_identifier.value.text}
            {def $video_types = $content.fields.video_type.value.identifiers}

            {if 'youtube'|contains($video_types)}
                <img src="https://img.youtube.com/vi/{$video_identifier}/mqdefault.jpg" alt="" />
            {elseif 'vimeo'|contains($video_types)}
                <img src="" class="vimeo-poster" data-id="{$video_identifier}" data-thumbname="thumbnail_large" alt="" />
            {elseif 'dailymotion'|contains($video_types)}
                <img src="" class="dailymotion-poster" data-id="{$video_identifier}" data-thumbname="thumbnail_360_url" alt="" />
            {/if}
        {else}
                <img src="{asset('images/video_poster.png')}" alt="" />
        {/if}
    </a>
{* ENDMACRO *}

{* MACRO poster_slide($content, $use_lazy_load) *}
    {* IMPORT content/macros/slide.tpl AS slide *}

    {def $use_lazy_load = first_set($use_lazy_load, false)}

    {if not($content.fields.poster['empty'])}
        {image($slide, $content, 'poster', 'i1320', $use_lazy_load)}
    {elseif not($content.fields.video_identifier['empty'])}
        {def $video_identifier = $content.fields.video_identifier.value.text}
        {def $video_types = $content.fields.video_type.value.identifiers}

        {if 'youtube'|contains($video_types)}
            <img {if $use_lazy_load}loading="lazy"{/if} src="https://img.youtube.com/vi/{$video_identifier}/mqdefault.jpg" alt="" />
        {elseif 'vimeo'|contains($video_types)}
            <img src="" class="vimeo-poster" data-id="{$video_identifier}" data-thumbname="thumbnail_large" alt="" />
        {elseif 'dailymotion'|contains($video_types)}
            <img src="" class="dailymotion-poster" data-id="{$video_identifier}" data-thumbname="thumbnail_720_url" alt="" />
        {/if}
    {else}
            <img {if $use_lazy_load}loading="lazy"{/if} src="{asset('images/video_poster.png')}" alt="" />
    {/if}
{* ENDMACRO *}

{* MACRO player($content) *}
    {def $video_types = $content.fields.video_type.value.identifiers}
    {def $autoplay = $content.fields.autoplay.value.bool}

    {if not($content.fields.title['empty'])}
        {def $video_title = $content.fields.title.value.text}
    {else}
        {def $video_title = $content.name}
    {/if}

    {def $image_path = asset('images/video_poster.png')}
    {if not($content.fields.poster['empty'])}
        {def $poster_alias = ng_image_alias($content.fields.poster, 'i1320')}

        {if $poster_alias}
            {def $image_path = asset($poster_alias.uri)}
        {/if}
    {/if}

    {if 'upload'|contains($video_types)}
        {if not($content.fields.video_file['empty'])}
            <video
                id="video-{$content.id}"
                class="video-js vjs-fill ratio ratio-16x9"
                data-setup='{}'
                controls
                preload="auto"
                width="100%"
                poster="{$image_path}"
                autoplay="{if $autoplay}true{else}false{/if}">
                <source
                    src="{path('ngsite_download', hash('contentId', $content.id, 'fieldId', $content.fields.video_file.id))}"
                    type="{$content.fields.video_file.value.mimeType}"
                />
            </video>

            <link href="https://vjs.zencdn.net/7.20.3/video-js.css" rel="stylesheet" />
            <script src="https://vjs.zencdn.net/7.20.3/video.min.js"></script>
            <style>
                .video-js .vjs-big-play-button {
                    left: 50%; top: 50%;
                    transform: translateX(-50%) translateY(-50%);
                    border: none;
                    background-color: #FED82F;
                    font-size: 5rem;
                    height: 2em;
                    width: 2em;
                    line-height: 2em;
                    border-radius: 50%;
                    filter: brightness(75%);
                }
                .video-js:hover .vjs-big-play-button {
                    background-color: #FED82F;
                    filter: brightness(100%);
                }
                .video-js .vjs-poster {
                    background-size: cover;
                }
            </style>

        {/if}
    {elseif not($content.fields.video_identifier['empty'])}
        {def $video_identifier = $content.fields.video_identifier.value.text}

        {if 'youtube'|contains($video_types)}
            <div class="video-youtube ratio ratio-16x9">
                <iframe frameborder="0" src="https://www.youtube.com/embed/{$video_identifier}{if $autoplay}?autoplay=1{/if}" title="{$video_title}" width="770" height="433" allowfullscreen></iframe>
            </div>
        {elseif 'vimeo'|contains($video_types)}
            <div class="video-vimeo ratio ratio-16x9">
                <iframe frameborder="0" src="https://player.vimeo.com/video/{$video_identifier}{if $autoplay}?autoplay=1{/if}" title="{$video_title}" width="770" height="433" allowfullscreen></iframe>
            </div>
        {elseif 'dailymotion'|contains($video_types)}
            <div class="video-dailymotion ratio ratio-16x9">
                <iframe frameborder="0" src="https://www.dailymotion.com/embed/video/{$video_identifier}{if $autoplay}?autoplay=1{/if}" title="{$video_title}" width="770" height="433" allowfullscreen></iframe>
            </div>
        {/if}
    {/if}
{* ENDMACRO *}

{* MACRO player_slide($content) *}
    {def $video_types = $content.fields.video_type.value.identifiers}

    {if not($content.fields.title['empty'])}
        {def $video_title = $content.fields.title.value.text}
    {else}
        {def $video_title = $content.name}
    {/if}

    {def $image_path = asset('images/video_poster.png')}
    {if not($content.fields.poster['empty'])}
        {def $poster_alias = ng_image_alias($content.fields.poster, 'i1320')}

        {if $poster_alias}
            {def $image_path = asset($poster_alias.uri)}
        {/if}
    {/if}

    {if 'upload'|contains($video_types)}
        {if not($content.fields.video_file['empty'])}
            <video
                id="video-{$content.id}"
                class="video-js vjs-fill ratio ratio-16x9"
                data-setup='{}'
                controls
                preload="auto"
                width="100%"
                poster="{$image_path}"
                autoplay="{if $autoplay}true{else}false{/if}">
                <source
                    src="{path('ngsite_download', hash('contentId', $content.id, 'fieldId', $content.fields.video_file.id))}"
                    type="{$content.fields.video_file.value.mimeType}"
                />
            </video>

            <link href="https://vjs.zencdn.net/7.20.3/video-js.css" rel="stylesheet" />
            <script src="https://vjs.zencdn.net/7.20.3/video.min.js"></script>
            <style>
                .video-js .vjs-big-play-button {
                    left: 50%; top: 50%;
                    transform: translateX(-50%) translateY(-50%);
                    border: none;
                    background-color: #FED82F;
                    font-size: 5rem;
                    height: 2em;
                    width: 2em;
                    line-height: 2em;
                    border-radius: 50%;
                    filter: brightness(75%);
                }
                .video-js:hover .vjs-big-play-button {
                    background-color: #FED82F;
                    filter: brightness(100%);
                }
                .video-js .vjs-poster {
                    background-size: cover;
                }
            </style>
        {/if}
    {elseif not($content.fields.video_identifier['empty'])}
        {def $video_identifier = $content.fields.video_identifier.value.text}

        {if 'youtube'|contains($video_types)}
            <div class="video-youtube ratio ratio-16x9">
                <iframe frameborder="0" src="https://www.youtube.com/embed/{$video_identifier}" title="{$video_title}" width="770" height="433" allowfullscreen></iframe>
            </div>
        {elseif 'vimeo'|contains($video_types)}
            <div class="video-vimeo ratio ratio-16x9">
                <iframe frameborder="0" src="https://player.vimeo.com/video/{$video_identifier}" title="{$video_title}" width="770" height="433" allowfullscreen></iframe>
            </div>
        {elseif 'dailymotion'|contains($video_types)}
            <div class="video-dailymotion ratio ratio-16x9">
                <iframe frameborder="0" src="https://www.dailymotion.com/embed/video/{$video_identifier}" title="{$video_title}" width="770" height="433" allowfullscreen></iframe>
            </div>
        {/if}
    {/if}
{* ENDMACRO *}