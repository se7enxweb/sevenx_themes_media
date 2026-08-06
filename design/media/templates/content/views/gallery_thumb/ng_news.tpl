


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT content/macros/slide.tpl AS slide *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-news vl3 {if $show_details_on_hover}show_details_on_hover{/if}">
    {if $image_type|eq('main')}
        {image($slide, $content, 'image', 'i1320', true)}

        {if $show_details}
            <div class="info">
                <div class="date">
                    {include uri='design:content/parts/time.tpl'}
                </div>
                <h2 class="title"><a href={ibexa_path($location)}>{title($content_fields, $content)}</a></h2>
            </div>
        {/if}
    {elseif $image_type|eq('thumb')}
        {image($slide, $content, 'image', 'i320')}
    {/if}
</div>