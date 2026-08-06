{* Article full view, eZ4-native, mirroring the reference ng_article full view. *}
{def $af_map = $node.object.data_map}
{def $content = $node.object}
{def $view_type = 'full'}
<article class="view-type view-type-full ng-article">
    <header class="full-page-header">
        <div class="container">
            {include uri='design:content/parts/main_topic.tpl' content=$node.object}

            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>

            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl' content=$node.object node=$node}
                {include uri='design:content/parts/time.tpl'}
            </div>
        </div>
    </header>

    {def $af_img_attr = false()}
    {if and(is_set($af_map.image), $af_map.image.has_content)}
        {set $af_img_attr = $af_map.image}
    {elseif and(is_set($af_map.teaser_image), $af_map.teaser_image.has_content)}
        {set $af_img_attr = $af_map.teaser_image}
    {/if}
    {if $af_img_attr}
    {def $af_img = $af_img_attr.content}
    {def $af_url = ''}
    {if is_set($af_img['i1320'])}{set $af_url = $af_img['i1320'].url}
    {elseif is_set($af_img['large'])}{set $af_url = $af_img['large'].url}
    {elseif is_set($af_img['original'])}{set $af_url = $af_img['original'].url}{/if}
    {if $af_url|ne('')}
    <div class="full-page-image">
        <div class="container container-wide">
            <div>
                <figure class="image-wrapper">
                    <img src={$af_url|ezroot} loading="lazy" alt="{$af_img.alternative_text|wash}" />
                </figure>
            </div>
        </div>
    </div>
    {/if}
    {undef $af_img $af_url}
    {/if}
    {undef $af_img_attr}

    <div class="container container-narrow">
        <div class="full-page-body">
            {if and(is_set($af_map.full_intro), $af_map.full_intro.has_content)}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$af_map.full_intro}</div>
            </div>
            {/if}
            {if and(is_set($af_map.body), $af_map.body.has_content)}
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$af_map.body}</div>
            {/if}
            {include uri='design:content/parts/tags.tpl' content=$node.object node=$node}
        </div>
    </div>
</article>
{undef $af_map $view_type}
