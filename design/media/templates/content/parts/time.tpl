{if is_set($node.object.data_map['publish_date'])}
    {if $node.object.data_map['publish_date'].has_content}
        {def $time_stamp = $node.object.data_map['publish_date'].content.timestamp}
    {else}
        {def $time_stamp = $node.object.published}
    {/if}
{else}
    {def $time_stamp = $node.object.published}
{/if}
{def $time_iso = $time_stamp|datetime('custom', '%Y-%m-%d')}
{def $time_human = $time_stamp|datetime('custom', '%j %M %Y')}
{def $time_attr = ''}
{if and(is_set($view_type), $view_type|eq('full'))}
    {set $time_attr = ' itemprop="datePublished"'}
{/if}
<time{$time_attr} datetime="{$time_iso}">{$time_human}</time>
{undef $time_stamp $time_iso $time_human $time_attr}
