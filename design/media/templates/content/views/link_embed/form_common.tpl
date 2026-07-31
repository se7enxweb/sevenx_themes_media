


{if is_set($location)}
    {ng_view_content($location, 'payload', hash('params', hash('action', path('ngsite_info_collection_ajax_submit', hash('formContentId', $content.id)), 'label', $label, 'refererLocationId', first_set($refererLocationId, null), 'class', 'embed-form js-form-embed')))}
{/if}