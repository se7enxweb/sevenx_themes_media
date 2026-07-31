


{def $url = path('ngsite_view_modal', hash('contentId', $content.id))}

<a href="#" class="btn btn-default js-modal-trigger" data-url="{$url}">{first_set($label, $content.name)}</a>