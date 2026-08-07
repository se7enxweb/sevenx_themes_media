


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-recipe vl1">
    {image($content_fields, $content, $location)}

    <header class="article-header">
        <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
        <div class="info">
            {include uri='design:content/parts/author.tpl'}

            <span class="recipe-details">
                {if not($content.fields.preparation_time['empty'])}
                    <span><i class="icon-clock"></i> {ng_render_field($content.fields.preparation_time)} {$'ngsite.layout.recipe.min'|trans}</span>
                {/if}
                {if not($content.fields.serving_calories['empty'])}
                    <span><i class="icon-fire"></i> {ng_render_field($content.fields.serving_calories)} {$'ngsite.layout.recipe.cal'|trans}</span>
                {/if}
            </span>
        </div>
    </header>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>