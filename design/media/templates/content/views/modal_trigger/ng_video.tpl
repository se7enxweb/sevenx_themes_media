


{if is_set($location)}
    {def $videoOptions = hash('videoTitle', $content.name, 'type', $content.fields.video_type.value.identifiers[0], 'fileLink', $content.fields.video_file.value.uri, 'mimeType', $content.fields.video_file.value.mimeType, 'identifier', $content.fields.video_identifier.value.text, 'poster', $content.fields.poster.value.uri, 'autoplay', $content.fields.autoplay.value.bool)}

    <a href="#" class="btn btn-default js-modal-video-trigger" data-video-options="{$videoOptions|json_encode}">{first_set($label, $content.name)}</a>
{/if}