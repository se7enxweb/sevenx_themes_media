{* News full view, eZ4-native, mirroring the reference ng_news full view. *}
{def $nf_map = $node.object.data_map}
{def $content = $node.object}
{def $view_type = 'full'}
{explblock name='content'}
<article class="view-type view-type-full ng-news">
    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            {include uri='design:content/parts/main_topic.tpl' content=$content}

            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>

            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl' content=$content node=$node}
                {include uri='design:content/parts/time.tpl' node=$node}
            </div>
        </div>
    </header>
    {/explblock}

    {def $nf_img_attr = false()}
    {if and(is_set($nf_map.image), $nf_map.image.has_content)}
        {set $nf_img_attr = $nf_map.image}
    {elseif and(is_set($nf_map.teaser_image), $nf_map.teaser_image.has_content)}
        {set $nf_img_attr = $nf_map.teaser_image}
    {/if}
    {if $nf_img_attr}
    {def $nf_img = $nf_img_attr.content}
    {def $nf_url = ''}
    {if is_set($nf_img['i1320'])}{set $nf_url = $nf_img['i1320'].url}
    {elseif is_set($nf_img['large'])}{set $nf_url = $nf_img['large'].url}
    {elseif is_set($nf_img['original'])}{set $nf_url = $nf_img['original'].url}{/if}
    {if $nf_url|ne('')}
    {explblock name='article_media'}
    <div class="full-page-image" itemprop="image">
        <div class="container container-wide">
            <div>
                <figure class="image-wrapper">
                    <img src={$nf_url|ezroot} loading="lazy" alt="{$nf_img.alternative_text|wash}" />
                </figure>
            </div>
        </div>
    </div>
    {/explblock}
    {/if}
    {undef $nf_img $nf_url}
    {/if}
    {undef $nf_img_attr}

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">
            {if and(is_set($nf_map.full_intro), $nf_map.full_intro.has_content)}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$nf_map.full_intro}</div>
            </div>
            {/if}
            {if and(is_set($nf_map.body), $nf_map.body.has_content)}
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$nf_map.body}</div>
            {/if}
            {include uri='design:content/parts/tags.tpl' content=$content node=$node}
            <div class="sticky-sidebar-wrapper">
                <div id="sticky-sidebar" class="sticky-sidebar">
                    <div class="sticky-sidebar-inner">
                        {include uri='design:content/parts/social_share.tpl' content=$content node=$node}
                    </div>
                </div>
            </div>
        </div>
        {/explblock}
    </div>
</article>
{/explblock}
{undef $nf_map $view_type}
