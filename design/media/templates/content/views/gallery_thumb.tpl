


{* IMPORT content/macros/slide.tpl AS slide *}
{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
{if not(is_set($node))}{def $node = false()}{/if}
{set $node = fetch('content','node',hash('node_id',$location.node_id))}

<div {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl3 {if $show_details_on_hover}show_details_on_hover{/if}">
    {if $image_type|eq('main')}
        {image($slide, $content, 'image', 'i1320', true)}

        {if $show_details}
            <div class="info">
                <h2 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>
            </div>
        {/if}
    {elseif $image_type|eq('thumb')}
        {image($slide, $content, 'image', 'i320')}
    {/if}
</div>