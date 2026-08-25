{def $content_fields = array()}
{def $link_title = concat( 'Read more about ', title( $content_fields, $content ) )}
{def $short_text = ''}
{if and( hasField($content, 'teaser_intro'), not( $content.fields.teaser_intro['empty'] ) )}
    {set $short_text = $content.fields.teaser_intro.value.xml|strip_tags|trim|shorten(210)}
{elseif and( hasField($content, 'full_intro'), not( $content.fields.full_intro['empty'] ) )}
    {set $short_text = $content.fields.full_intro.value.xml|strip_tags|trim|shorten(210)}
{elseif and( hasField($content, 'body'), not( $content.fields.body['empty'] ) )}
    {set $short_text = $content.fields.body.value.xml|strip_tags|trim|shorten(210)}
{/if}
<article class="view-type view-type-search {$content.contentInfo.contentTypeIdentifier|ristring('_', '-')} vl7">
    <div class="article-content">
        <div class="article-content-text">
            <header class="article-header">
                <h2 class="title"><a href="{ibexa_path($location)}" title="{$link_title|wash}">{title($content_fields, $content)}</a></h2>
                <div class="info">
                    {include uri='design:content/parts/time.tpl'}
                    <span class="type">{$content.contentInfo.contentTypeName}</span>
                </div>
            </header>
            {if $short_text|ne('')}
                <div class="short">{$short_text}</div>
            {/if}
        </div>

        {def $image_field = firstNonEmptyField($content, 'teaser_image', 'image')}
        {if not($image_field.empty)}
            <figure class="image">
                <a href="{ibexa_path($location)}" class="ratio ratio-16x9" title="{$link_title|wash}">
                    {ng_render_field($image_field, hash('parameters', hash('alias', 'i480', 'alt_text', $image_field.value.alternativeText)))}
                </a>
            </figure>
        {/if}
    </div>
</article>
