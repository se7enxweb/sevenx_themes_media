


{* EXTENDS design:$nglayouts.layoutTemplate *}

{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{elseif not($content.fields.description['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.description.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{* BLOCK content *}
    <div class="view-type view-type-{$view_type} ng-gallery">
        {* BLOCK article_header *}
            <header class="full-page-header{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
                <div class="container">
                    {include uri='design:content/parts/main_topic.tpl'}

                    <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>

                    <div class="full-page-info">
                        {include uri='design:content/parts/time.tpl'}
                    </div>
                </div>
            </header>
        {* ENDBLOCK article_header *}

        {* BLOCK image *}
            <div class="full-page-image">
                <div class="container container-wide">
                    {render(controller('ngsite.controller.relations.related_multimedia_items', hash('locationId', $location.id, 'includeChildren', true, 'contentTypeIdentifiers', array('image', 'ng_video'), 'template', '@ibexadesign/content/parts/related_multimedia.html.twig')))}
                </div>
            </div>
        {* ENDBLOCK image *}

        <div class="container container-narrow">

            {* BLOCK body *}
                <div class="full-page-body">
                    {if not($content.fields.teaser_intro['empty'])}
                        <div class="full-page-intro">
                            {ng_render_field($content.fields.teaser_intro)}
                        </div>
                    {/if}

                    {if not($content.fields.description['empty'])}
                        {ng_render_field($content.fields.description)}
                    {/if}

                    {include uri='design:content/parts/tags.tpl'}
                </div>
            {* ENDBLOCK body *}

        </div>
    </div>
{* ENDBLOCK content *}