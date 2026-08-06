


{* IMPORT content/macros/video.tpl AS video *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
{if or(not($content.fields.video_file['empty']), not($content.fields.video_identifier['empty']))}
    <div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-video vl3  {if $show_details_on_hover}show_details_on_hover{/if}">
        {if $image_type|eq('main')}
            {poster_slide($video, $content, true)}

            {if $show_details}
                <div class="info">
                    <h2 class="title">
                        <a href={ibexa_path($location)}>
                            {$content.fields.title.value.text}
                        </a>
                    </h2>
                </div>
            {/if}
        {elseif $image_type|eq('thumb')}
            {poster_slide($video, $content, false)}
        {/if}
    </div>
{/if}