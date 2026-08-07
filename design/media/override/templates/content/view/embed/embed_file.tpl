


<div class="view-type view-type-{$view_type} file">
    <div class="file mime-type-{$content.fields.file.value.mimeType|ristring('/', '-')}">
        {ng_render_field($content.fields.file)}
    </div>
</div>