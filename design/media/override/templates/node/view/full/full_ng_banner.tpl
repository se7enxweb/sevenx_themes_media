{* Banner full view, eZ4-native. *}
{def $bf_map = $node.object.data_map}
{def $view_type = 'full'}
{explblock name='content'}
<div class="view-type view-type-{$view_type} ng-banner">
    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            {if and(is_set($bf_map.eyebrow_title), $bf_map.eyebrow_title.has_content)}
                <div class="full-page-eyebrow"><span class="important-notice">{$bf_map.eyebrow_title.content|wash}</span></div>
            {/if}
            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>
        </div>
    </header>
    {/explblock}

    {if and(is_set($bf_map.image), $bf_map.image.has_content)}
        {def $bf_img = $bf_map.image.content}
        {def $bf_url = ''}
        {if is_set($bf_img['i1320'])}{set $bf_url = $bf_img['i1320'].url}
        {elseif is_set($bf_img['large'])}{set $bf_url = $bf_img['large'].url}
        {elseif is_set($bf_img['original'])}{set $bf_url = $bf_img['original'].url}{/if}
        {if $bf_url|ne('')}
            {explblock name='article_media'}
            <div class="full-page-image">
                <div class="container container-wide">
                    <div>
                        <figure class="image-wrapper">
                            <img src={$bf_url|ezroot} loading="lazy" alt="{$bf_img.alternative_text|wash}" />
                        </figure>
                    </div>
                </div>
            </div>
            {/explblock}
        {/if}
        {undef $bf_img $bf_url}
    {/if}

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">
            {if and(is_set($bf_map.description), $bf_map.description.has_content)}
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$bf_map.description}</div>
            {/if}
        </div>
        {/explblock}
    </div>
</div>
{/explblock}
{undef $bf_map}
