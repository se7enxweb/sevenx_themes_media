{def $show_path = false}
{def $view_type = 'full'}



{* EXTENDS design:$nglayouts.layoutTemplate *}

{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{elseif not($content.fields.full_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.full_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{explblock name='content'}
    <article class="view-type view-type-{$view_type} ng-news">
        {explblock name='article_header'}
            <header class="full-page-header{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
                <div class="container">
                    {include uri='design:content/parts/main_topic.tpl'}

                    <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>

                    <div class="full-page-info">
                        {include uri='design:content/parts/author.tpl'}
                        {include uri='design:content/parts/time.tpl'}
                    </div>
                </div>
            </header>
        {/explblock}

        {explblock name='article_media'}
            {if or(not($content.fields.image['empty']), not($content.fields.related_multimedia['empty']))}
                <div class="full-page-image">
                    <div class="container container-wide">
                        {render(controller('ngsite.controller.relations.related_multimedia_items', hash('locationId', $location.id, 'includeChildren', true, 'contentTypeIdentifiers', array('image', 'ng_video'), 'template', '@ibexadesign/content/parts/related_multimedia.html.twig')))}
                    </div>
                </div>
            {/if}
        {/explblock}

        <div class="container container-narrow">
            {explblock name='article_body'}
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

                    <div class="sticky-sidebar-wrapper">
                        <div id="sticky-sidebar" class="sticky-sidebar">
                            <div class="sticky-sidebar-inner">
                                {include uri='design:content/parts/social_share.tpl'}
                            </div>
                        </div>
                    </div>
                </div>
            {/explblock}
        </div>
    </article>
{/explblock}

{* BLOCK structuredData *}
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "NewsArticle",
            "headline": "{$content.fields.title.value.text}",
            {if $content.contentInfo.publishedDate}
                "datePublished": "{$content.contentInfo.publishedDate|format_date}",
            {/if}
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