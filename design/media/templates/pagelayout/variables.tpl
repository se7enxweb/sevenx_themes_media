{if not(is_set($site_name))}
    {def $site_name = 'Fit &amp; Healthy'}
{/if}

{if not(is_set($show_path))}
    {def $show_path = true}
{/if}

{if not(is_set($path_array))}
    {def $path_array = array()}
    {def $main_category_location_id = 0}
{/if}

{if not(is_set($available_translations))}
    {def $available_translations = array()}
    {def $available_hreflang_translations = array()}
    {def $current_content_language = 'eng-GB'}
{/if}
