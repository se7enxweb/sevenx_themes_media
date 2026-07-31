


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} ng-recipe vl6">
    <h3 class="title"><a href={$node.url_alias|ezurl}>{title($content_fields, $content)}</a></h3>
    <div class="info">
        {include uri='design:content/parts/author.tpl'}

        <span class="recipe-details">
            {if and(is_set($node.object.data_map.preparation_time), $node.object.data_map.preparation_time.has_content)}
                <span><i class="icon-clock"></i> <span class="ibexa_integer-field">{$node.object.data_map.preparation_time.content}</span> min</span>
            {/if}
            {if and(is_set($node.object.data_map.serving_calories), $node.object.data_map.serving_calories.has_content)}
                <span><i class="icon-fire"></i> <span class="ibexa_integer-field">{$node.object.data_map.serving_calories.content}</span> cal</span>
            {/if}
        </span>
    </div>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>