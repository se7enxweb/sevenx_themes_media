{* Blog post full view, eZ4-native, mirroring the reference (vf1 variant,
   no hero image block). *}
{def $bf_map = $node.object.data_map}
{def $content = $node.object}
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
{undef $bf_map}
