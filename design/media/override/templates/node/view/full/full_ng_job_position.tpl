{* Job position full view, eZ4-native. *}
{def $jp_map = $node.object.data_map}
{explblock name='content'}
<article class="view-type view-type-full ng-job-position vf1">
    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>

            <div class="full-page-info">
                {if and(is_set($jp_map.job_location), $jp_map.job_location.has_content)}
                    <span>{$jp_map.job_location.content|wash}</span>
                {/if}
                {if and(is_set($jp_map.engagement_type), $jp_map.engagement_type.has_content)}
                    <span>{$jp_map.engagement_type.content|wash}</span>
                {/if}
                {if and(is_set($jp_map.application_deadline), $jp_map.application_deadline.has_content)}
                    <span>{'Application deadline'|i18n('ngsite')}: {$jp_map.application_deadline.content.timestamp|l10n('shortdate')}</span>
                {/if}
            </div>
        </div>
    </header>
    {/explblock}

    {if and(is_set($jp_map.image), $jp_map.image.has_content)}
    {def $jp_img = $jp_map.image.content}
    {def $jp_url = ''}
    {if is_set($jp_img['i1320'])}{set $jp_url = $jp_img['i1320'].url}
    {elseif is_set($jp_img['large'])}{set $jp_url = $jp_img['large'].url}
    {elseif is_set($jp_img['original'])}{set $jp_url = $jp_img['original'].url}{/if}
    {if $jp_url|ne('')}
    {explblock name='article_media'}
    <div class="full-page-image">
        <div class="container container-wide">
            <figure class="image-wrapper">
                <img src={$jp_url|ezroot} loading="lazy" alt="{$jp_img.alternative_text|wash}" />
            </figure>
        </div>
    </div>
    {/explblock}
    {/if}
    {undef $jp_img $jp_url}
    {/if}

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">
            {if and(is_set($jp_map.full_intro), $jp_map.full_intro.has_content)}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$jp_map.full_intro}</div>
            </div>
            {/if}

            {if and(is_set($jp_map.job_overview), $jp_map.job_overview.has_content)}
            <h3 class="job-details">{'Job overview'|i18n('ngsite')}</h3>
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$jp_map.job_overview}</div>
            {/if}

            {if and(is_set($jp_map.requirements), $jp_map.requirements.has_content)}
            <h3 class="job-details">{'Requirements'|i18n('ngsite')}</h3>
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$jp_map.requirements}</div>
            {/if}

            {if and(is_set($jp_map.responsibilities), $jp_map.responsibilities.has_content)}
            <h3 class="job-details">{'Responsibilities'|i18n('ngsite')}</h3>
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$jp_map.responsibilities}</div>
            {/if}
        </div>
        {/explblock}
    </div>
</article>
{/explblock}
{undef $jp_map}
