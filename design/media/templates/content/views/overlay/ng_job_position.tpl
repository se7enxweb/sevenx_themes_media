{* Job position card view for list grid (overlay), eZ4-native. *}
<article class="view-type view-type-{$view_type} ng-job-position vl8">
    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
            <div class="info">
                {if and(is_set($node.data_map.job_location), $node.data_map.job_location.has_content)}
                    <span>{$node.data_map.job_location.content|wash}</span>
                {/if}
                {if and(is_set($node.data_map.engagement_type), $node.data_map.engagement_type.has_content)}
                    <span>{$node.data_map.engagement_type.content|wash}</span>
                {/if}
            </div>
        </header>

        <div class="actions">
            <a class="btn btn-link" href={$node.url_alias|ezurl}>{'Apply now'|i18n('ngsite')}</a>
        </div>
    </div>
</article>
