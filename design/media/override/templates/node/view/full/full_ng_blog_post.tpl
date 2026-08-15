{* Blog post full view, eZ4-native, mirroring the reference (vf1 variant,
   no hero image block). *}
{def $bf_map = $node.object.data_map}
{def $content = $node.object}
{def $view_type = 'full'}
<article class="view-type view-type-full ng-blog-post vf1">
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

    {def $bf_img_attr = false()}
    {if and(is_set($bf_map.image), $bf_map.image.has_content)}
        {set $bf_img_attr = $bf_map.image}
    {elseif and(is_set($bf_map.teaser_image), $bf_map.teaser_image.has_content)}
        {set $bf_img_attr = $bf_map.teaser_image}
    {/if}
    {if $bf_img_attr}
    {def $bf_img = $bf_img_attr.content}
    {def $bf_url = ''}
    {if is_set($bf_img['i1320'])}{set $bf_url = $bf_img['i1320'].url}
    {elseif is_set($bf_img['large'])}{set $bf_url = $bf_img['large'].url}
    {elseif is_set($bf_img['original'])}{set $bf_url = $bf_img['original'].url}{/if}
    {if $bf_url|ne('')}
    <div class="full-page-image">
        <div class="container container-wide">
            <div>
                <figure class="image-wrapper">
                    <img src={$bf_url|ezroot} loading="lazy" alt="{$bf_img.alternative_text|wash}" />
                </figure>
            </div>
        </div>
    </div>
    {/if}
    {undef $bf_img $bf_url}
    {/if}
    {undef $bf_img_attr}

    <div class="container container-narrow">
        <div class="full-page-body">
            {if and(is_set($bf_map.full_intro), $bf_map.full_intro.has_content)}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$bf_map.full_intro}</div>
            </div>
            {/if}
            {if and(is_set($bf_map.body), $bf_map.body.has_content)}
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$bf_map.body}</div>
            {/if}
            {include uri='design:content/parts/tags.tpl' content=$node.object node=$node}
            <div class="sticky-sidebar-wrapper">
                <div class="sticky-sidebar">
                    <div class="sticky-sidebar-inner">
                        {include uri='design:content/parts/social_share.tpl' content=$node.object node=$node}
                    </div>
                </div>
            </div>
        </div>
    </div>
</article>
{undef $bf_map $view_type}
