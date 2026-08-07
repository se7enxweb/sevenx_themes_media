


{* IMPORT content/macros/content_fields.tpl AS content_fields *}

<div class="view-type view-type-{$view_type} ng-audio">
    <h3 class="title">{title($content_fields, $content)}</h3>

    {if not($content.fields.file['empty'])}
        <audio controls>
            <source type="audio/mpeg" src="{path('ngsite_download', hash('contentId', $content.id, 'fieldId', $content.fields.file.id))}" />
            Your browser does not support the audio element.
        </audio>
    {/if}

    {if not($content.fields.description['empty'])}
        <div class="short">
            {ng_render_field($content.fields.description)}
        </div>
    {/if}
</div>