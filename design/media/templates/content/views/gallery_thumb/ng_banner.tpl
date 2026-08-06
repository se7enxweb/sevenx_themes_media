


{* IMPORT content/macros/slide.tpl AS slide *}
{* IMPORT content/macros/links.tpl AS links *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-banner vl3 {if $show_details_on_hover}show_details_on_hover{/if}">
    {if $image_type|eq('main')}
        {image($slide, $content, 'image', 'i1320', true)}

        {if $show_details}
            <div class="info">
                <h2 class="title">
                    {content_link($links, $content, $content.fields.title.value.text)}
                </h2>
            </div>
        {/if}
    {elseif $image_type|eq('thumb')}
        {image($slide, $content, 'image', 'i320')}
    {/if}
</div>