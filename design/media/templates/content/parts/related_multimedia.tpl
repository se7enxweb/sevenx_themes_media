<div class="related-multimedia">
{if not($content.fields.image['empty'])}
    <figure class="image-wrapper">
        {ng_render_field($content.fields.image)}
    </figure>
{/if}

{def $relatedMultimedia = fieldRelations($content, 'related_multimedia')}
{if $relatedMultimedia|count|gt(0)}
    {foreach $relatedMultimedia as $multimediaItem}
        {if not($multimediaItem.dataMap.image['empty'])}
            <figure class="image-wrapper">
                {ng_render_field($multimediaItem.dataMap.image)}
            </figure>
        {/if}
    {/foreach}
{/if}
</div>
