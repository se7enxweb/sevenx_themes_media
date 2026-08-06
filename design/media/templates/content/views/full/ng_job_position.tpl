


{* EXTENDS design:$nglayouts.layoutTemplate *}

{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{elseif not($content.fields.full_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.full_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{* BLOCK content *}
    <article class="view-type view-type-{$view_type} ng-job-position vf1">
        {* BLOCK article_header *}
            <header class="full-page-header{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
                <div class="container">
                    <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>
                    <div class="full-page-info">
                        {if not($content.fields.job_location['empty'])}
                            <span>{ng_render_field($content.fields.job_location)}</span>
                        {/if}
                        {if not($content.fields.engagement_type['empty'])}
                            <span>{ng_render_field($content.fields.engagement_type)}</span>
                        {/if}
                        {if not($content.fields.application_deadline['empty'])}
                            <span>{$'ngsite.job_application.deadline'|trans}: {ng_render_field($content.fields.application_deadline)}</span>
                        {/if}
                    </div>
                </div>
            </header>
        {* ENDBLOCK article_header *}

        {* BLOCK image *}
            {if not($content.fields.image['empty'])}
                <div class="full-page-image">
                    <div class="container container-wide">
                        {ng_render_field($content.fields.image)}
                    </div>
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

                    {if not($content.fields.job_overview['empty'])}
                        <h3 class="job-details">{$'ngsite.job_application.job_overview'|trans}</h3>
                        {ng_render_field($content.fields.job_overview)}
                    {/if}

                    {if not($content.fields.requirements['empty'])}
                        <h3 class="job-details">{$'ngsite.job_application.requirements'|trans}</h3>
                        {ng_render_field($content.fields.requirements)}
                    {/if}

                    {if not($content.fields.responsibilities['empty'])}
                        <h3 class="job-details">{$'ngsite.job_application.responsibilities'|trans}</h3>
                        {ng_render_field($content.fields.responsibilities)}
                    {/if}
                </div>
            {* ENDBLOCK body *}
        </div>
    </article>
{* ENDBLOCK content *}

{* BLOCK structuredData *}
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "Article",
            "headline": "{$content.fields.title.value.text}",
            {if $content.contentInfo.publishedDate}"datePublished": "{$content.contentInfo.publishedDate|format_date}",
            {/if}{if not($content.fields.image['empty'])}
                "image": "{absolute_url(ng_image_alias($content.fields.image, 'i1320'))}",
            {/if}
            "publisher": {
                "type": "Organization",
                "name": "{$site_name}"
            }
        }
    </script>
{* ENDBLOCK structuredData *}