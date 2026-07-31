


{if is_set($location)}
    {ng_view_content($location, 'payload', hash('params', hash('label', $label, 'suffix', $suffix, 'refererLocationId', first_set($refererLocationId, null))))}
{/if}