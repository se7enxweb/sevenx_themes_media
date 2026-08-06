


{* IMPORT content/macros/video.tpl AS video *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
{if or(not($content.fields.video_file['empty']), not($content.fields.video_identifier['empty']))}
    <div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-video vl3">
        <a href="#" class="js-lightbox-item js-video-poster" title="{$content.fields.title.value.text}">
            {poster_slide($video, $content, first_set($use_lazy_load, false))}
        </a>
    </div>
{/if}