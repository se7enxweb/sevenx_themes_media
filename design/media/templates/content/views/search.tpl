{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
<article class="view-type view-type-search {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl7">
    <div class="article-content">
        <div class="article-content-text">
            <header class="article-header">
                <h2 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h2>
                <div class="info">
                    {include uri='design:content/parts/time.tpl'}
                    <span class="type">{$content.contentInfo.contentTypeName}</span>
                </div>
            </header>
            <div class="short">
                {if hasField($content, 'teaser_intro')}
                    {if not($content.fields.teaser_intro['empty'])}
                        {ng_render_field($content.fields.teaser_intro)}
                    {/if}
                {else}
                    {if hasField($content, 'full_intro')}
                        {if not($content.fields.full_intro['empty'])}
                            {ng_render_field($content.fields.full_intro)}
                        {/if}
                    {else}
                        {if hasField($content, 'body')}
                            {if not($content.fields.body['empty'])}
                                {saveXML($content.fields.body.value.xml)|strip_tags|trim|u.truncate(210)}
                            {/if}
                        {/if}
                    {/if}
                {/if}
            </div>
        </div>
        {image($content_fields, $content, $location, 'i480', true, 'ratio ratio-16x9')}
    </div>
</article>
