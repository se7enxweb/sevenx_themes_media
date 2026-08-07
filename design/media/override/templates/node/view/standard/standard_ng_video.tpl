


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT content/macros/video.tpl AS video *}
{* IMPORT macros.tpl AS toolbar_macros *}

{if or(not($content.fields.video_file['empty']), not($content.fields.video_identifier['empty']))}
    <article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-video vl1">
        <i class="icon-play article-icon" aria-hidden="true"></i>
        <figure class="image">
            {poster($video, $content, $location, 'i480')}
        </figure>

        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
        </header>
        {if first_set($with_intro, false)}
            {intro($content_fields, $content)}
        {/if}
    </article>
{/if}