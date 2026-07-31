


{* IMPORT content/macros/video.tpl AS video *}

{if or(not($content.fields.video_file['empty']), not($content.fields.video_identifier['empty']))}
    {if $is_slider}
        <div class="swiper-slide">
            {player_slide($video, $content, true)}
        </div>
    {else}
        {player($video, $content)}
    {/if}
{/if}