


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-recipe vl4">
    {include uri='design:content/parts/item_image.tpl' node=$node image_alias='i320'}

    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
            <div class="info">
                {include uri='design:content/parts/author.tpl'}

                <span class="recipe-details">
                    {if and(is_set($node.data_map.preparation_time), $node.data_map.preparation_time.has_content)}
                        <span><i class="icon-clock"></i> <span class="ibexa_integer-field">{$node.data_map.preparation_time.content}</span> min</span>
                    {/if}
                    {if and(is_set($node.data_map.serving_calories), $node.data_map.serving_calories.has_content)}
                        <span><i class="icon-fire"></i> <span class="ibexa_integer-field">{$node.data_map.serving_calories.content}</span> cal</span>
                    {/if}
                </span>
            </div>
        </header>
        {intro($content_fields, $content)}
    </div>
</article>