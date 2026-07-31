


{* IMPORT macros.tpl AS toolbar_macros *}

<article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} file vl6">
    <h3 class="title">
        <a href={$node.url_alias|ezurl}>
            <span class="ibexa_string-field">{$node.name|wash}</span>
        </a>
    </h3>
</article>