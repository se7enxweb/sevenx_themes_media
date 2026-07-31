{if is_set($open_graph)}
    {foreach $open_graph as $key => $value}
        <meta property="{$key|trim}" content="{$value|trim}" />
    {/foreach}
{/if}

{if is_set($content)}
    {def $meta_tags = get_netgen_open_graph($content.innerContent)}

    {foreach $meta_tags as $meta_tag}
        {if or(not(is_set($open_graph)), not(is_set($open_graph[$meta_tag.tagName])))}
            <meta property="{$meta_tag.tagName|trim}" content="{$meta_tag.tagValue|trim}" />
        {/if}
    {/foreach}
{/if}