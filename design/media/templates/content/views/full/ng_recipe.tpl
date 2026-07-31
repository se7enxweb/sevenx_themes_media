


{* EXTENDS design:$nglayouts.layoutTemplate *}

{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{elseif not($content.fields.full_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.full_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{* BLOCK content *}
    <article class="view-type view-type-{$view_type} ng-recipe">
        {* BLOCK article_header *}
            <header class="full-page-header{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
                <div class="container">
                    {include uri='design:content/parts/main_topic.tpl'}

                    <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>

                    <div class="full-page-info">
                        {include uri='design:content/parts/author.tpl'}
                    </div>
                </div>
            </header>
        {* ENDBLOCK article_header *}

        {* BLOCK image *}
            {if or(not($content.fields.image['empty']), not($content.fields.related_multimedia['empty']))}
                <div class="full-page-image">
                    {render(controller('ngsite.controller.relations.related_multimedia_items', hash('locationId', $location.id, 'includeChildren', true, 'contentTypeIdentifiers', array('image', 'ng_video'), 'template', '@ibexadesign/content/parts/related_multimedia.html.twig')))}
                </div>
            {/if}
        {* ENDBLOCK image *}

        <div class="container container-narrow">
            {* BLOCK body *}
                <div class="full-page-body">
                    {if not($content.fields.full_intro['empty'])}
                        <div class="full-page-intro">
                            {ng_render_field($content.fields.full_intro)}
                        </div>
                    {/if}

                    {if not($content.fields.body['empty'])}
                        {ng_render_field($content.fields.body)}
                    {/if}

                    {include uri='design:content/parts/tags.tpl'}
                </div>
            {* ENDBLOCK body *}

            {* BLOCK recipe_info *}
                <div class="full-recipe-info">
                    {if not($content.fields.serving_calories['empty'])}
                        <div class="recipe-calories">
                            {ng_render_field($content.fields.serving_calories)} {$'ngsite.layout.recipe.cal'|trans}
                        </div>
                    {/if}

                    <ul class="recipe-serving-info">
                        {if not($content.fields.serving_fat['empty'])}
                            <li>{ng_render_field($content.fields.serving_fat)} <span class="tt">{$'ngsite.layout.recipe.fat'|trans}</span></li>
                        {/if}
                        {if not($content.fields.serving_carbohydrates['empty'])}
                            <li>{ng_render_field($content.fields.serving_carbohydrates)} <span class="tt">{$'ngsite.layout.recipe.carbs'|trans}</span></li>
                        {/if}
                        {if not($content.fields.serving_protein['empty'])}
                            <li>{ng_render_field($content.fields.serving_protein)} <span class="tt">{$'ngsite.layout.recipe.protein'|trans}</span></li>
                        {/if}
                    </ul>

                    {if not($content.fields.preparation_time['empty'])}
                        <div class="recipe-time">
                            {$'ngsite.layout.recipe.preparation_time'|trans}
                            <time>{ng_render_field($content.fields.preparation_time)} {$'ngsite.layout.recipe.min'|trans}</time>
                        </div>
                    {/if}
                    {include uri='design:content/parts/social_share.tpl'}
                </div>
            {* ENDBLOCK recipe_info *}
        </div>
    </article>
{* ENDBLOCK content *}

{* BLOCK structuredData *}
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "Recipe",
            "name": "{$content.fields.title.value.text}",
            {if $content.contentInfo.publishedDate}
                "datePublished": "{$content.contentInfo.publishedDate|format_date}",
            {/if}
            "totalTime": "PT{$content.fields.preparation_time.value.value}M",
            "nutrition": {
                "@type": "NutritionInformation",
                "calories": "{$content.fields.serving_calories.value.value}",
                "fatContent": "{$content.fields.serving_fat.value.value}",
                "carbohydrateContent": "{$content.fields.serving_carbohydrates.value.value}",
                "proteinContent": "{$content.fields.serving_protein.value.value}"
            },
            "description": "{ng_render_field($content.fields.full_intro)|strip_tags}",
            {if not($content.fields.authors['empty'])}
                "author": {
                    "@type": "Person",
                    "name": "{foreach fieldRelations($content, 'authors') as $author}{if $loop.index0|gt(0)} ,{/if}{$author.name}{/foreach}"
                },
            {/if}
            {if not($content.fields.image['empty'])}
                "image": "{absolute_url(ng_image_alias($content.fields.image, 'i1320'))}",
            {/if}
            "publisher": {
                "type": "Organization",
                "name": "{$site_name}"
            }
        }
    </script>
{* ENDBLOCK structuredData *}