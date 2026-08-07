


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-recipe vl4">
    {image($content_fields, $content, $location, 'i320')}

    <div class="article-content">
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
        {intro($content_fields, $content)}
    </div>
</article>