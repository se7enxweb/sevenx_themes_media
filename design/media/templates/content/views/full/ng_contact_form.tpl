


{* EXTENDS design:$nglayouts.layoutTemplate *}

{* BLOCK content *}
    <div class="view-type view-type-{$view_type} ng-contact-form">
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

        <div class="full-form-content">
            <div class="container">
                {ng_view_content($content, 'payload', hash('params', hash('action', path('ngsite_info_collection_ajax_submit', hash('formContentId', $content.id)), 'refererLocationId', $location.id, 'class', 'embed-form js-form-embed')))}
            </div>
        </div>
    </div>
{* ENDBLOCK content *}
