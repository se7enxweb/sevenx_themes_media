


{* IMPORT content/macros/slide.tpl AS slide *}
{* IMPORT macros.tpl AS toolbar_macros *}

<div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} image vl3">
    {if $image_type|eq('main')}
        {image($slide, $content, 'image', 'i1320', true)}
    {elseif $image_type|eq('thumb')}
        {image($slide, $content, 'image', 'i320')}
    {/if}
</div>