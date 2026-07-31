


{* EXTENDS design:$nglayouts.layoutTemplate *}

{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{* BLOCK content *}
    <div class="view-type view-type-{$view_type} ng-audio">

        {* BLOCK article_header *}
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
        {* ENDBLOCK article_header *}

        {* BLOCK audio *}
            {if not($content.fields.file['empty'])}
                <div class="full-page-audio">
                    <div class="container container-narrow">
                            <audio controls>
                                <source type="audio/mpeg" src="{path('ngsite_download', hash('contentId', $content.id, 'fieldId', $content.fields.file.id))}" />
                                Your browser does not support the audio element.
                            </audio>
                    </div>
                </div>
            {/if}
        {* ENDBLOCK audio *}

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