


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} ng-blog-post vl6">
    <h3 class="title"><a href={$node.url_alias|ezurl}>{title($content_fields, $content)}</a></h3>
    <div class="info">
        {include uri='design:content/parts/author.tpl'}
        {include uri='design:content/parts/time.tpl'}
    </div>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>