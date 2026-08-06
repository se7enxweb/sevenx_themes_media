


{* IMPORT content/macros/links.tpl AS links *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} ng-banner vl6">
    <h3 class="title">
        {$node.name|wash}
    </h3>
    {if first_set($with_intro, false)}
        {intro('', $content, 'description')}
    {/if}
</article>