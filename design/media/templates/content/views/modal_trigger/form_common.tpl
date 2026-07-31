


{if is_set($location)}
    {def $url = path('ngsite_info_collection_view_modal', hash('formContentId', $content.id, 'refererLocationId', $refererLocationId))}

    <a href="#" class="{$css_class} js-form-modal-trigger" data-url="{$url}">{first_set($label, $content.name)}</a>
{/if}