


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-job-position vl8">
    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
            <div class="info">
                {if not($content.fields.job_location['empty'])}
                    {ng_render_field($content.fields.job_location)}
                {/if}
                {if not($content.fields.engagement_type['empty'])}
                    {ng_render_field($content.fields.engagement_type)}
                {/if}
            </div>
        </header>

        <div class="actions">
            <a class="btn btn-link" href="{ibexa_path($location)}">{$'ngsite.card.apply_now'|trans}</a>
        </div>
    </div>
</article>