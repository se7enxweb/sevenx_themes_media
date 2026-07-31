


{* EXTENDS design:$nglayouts.layoutTemplate *}

{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{if not($content.fields.full_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.full_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{def $topic_tag = $content.fields.title.value.text|trim}

{* BLOCK content *}
    <div class="view-type view-type-{$view_type} ng-topic">
        {* BLOCK page_header *}
            <header class="full-page-header text-center{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
                <div class="container">
                    <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>
                    {if not($content.fields.full_intro['empty'])}
                        <div class="full-page-header-text">
                            <div class="row">
                                <div class="container container-narrow">
                                    {ng_render_field($content.fields.full_intro)}
                                </div>
                            </div>
                        </div>
                    {/if}
                </div>
            </header>
        {* ENDBLOCK page_header *}

        <div class="container">
            {* BLOCK body *}
                {if not($content.fields.body['empty'])}
                    {ng_render_field($content.fields.body)}
                {/if}
            {* ENDBLOCK body *}
        </div>
    </div>
{* ENDBLOCK content *}