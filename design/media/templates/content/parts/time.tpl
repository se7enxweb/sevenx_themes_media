{if is_set($node.object.data_map['publish_date'])}
    {if $node.object.data_map['publish_date'].has_content}
        <time>{$node.object.data_map['publish_date'].content.timestamp|datetime('custom', '%j %M %Y')}</time>
    {else}
        <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
    {/if}
{else}
    <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
{/if}
