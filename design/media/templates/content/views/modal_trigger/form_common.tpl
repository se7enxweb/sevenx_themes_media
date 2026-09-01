{if is_set($location)}
    {def $url = concat('/info-collection/view-modal/', $content.id, '/', first_set($refererLocationId, $location.id))|ezurl('no')}

    <a href="#" class="{$css_class} js-form-modal-trigger" data-url="{$url}">{first_set($label, $content.name)}</a>
{/if}
