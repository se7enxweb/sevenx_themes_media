<meta name="generator" content="{'Exponential powered by 7x'|i18n('design/media/pagelayout')}">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2">
<meta name="theme-color" content="#ffffff">

{def $mt_meta = false()}
{if $node}
    {set $mt_meta = metadata($node.node_id)}
{/if}

{def $mt_description = ''}
{if $mt_meta}
    {if $mt_meta.description|ne('')}
        {set $mt_description = $mt_meta.description}
    {/if}
{/if}
{if $mt_description|eq('')}
    {if $node}
        {def $mt_intro = firstNonEmptyField($node.object, 'teaser_intro', 'intro', 'description')}
        {if not($mt_intro.empty)}
            {set $mt_description = $mt_intro.value.text|shorten(160)}
        {/if}
        {undef $mt_intro}
    {/if}
{/if}

{if $mt_description|ne('')}
<meta name="description" content="{$mt_description|wash}" />
{/if}

{if $mt_meta}
    {if $mt_meta.keywords|count|gt(0)}
<meta name="keywords" content="{$mt_meta.keywords|implode(', ')|wash}" />
    {/if}
    {if $mt_meta.canonical_url|ne('')}
<link rel="canonical" href="{$mt_meta.canonical_url|wash}" />
    {/if}
{/if}

{undef $mt_meta}
{undef $mt_description}

{def $mt_last = $path_array|count|sub(1)}
<script type="application/ld+json">
{literal}{{/literal}
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
    {foreach $path_array as $mt_index => $mt_item}
        {ldelim}
            "@type": "ListItem",
            "name": "{$mt_item.text|wash}",
            {if $mt_item.url|ne(false)}"item": "https://{ezini('SiteSettings','SiteURL')}/{$mt_item.url}",{/if}
            "position": {$mt_index|sum(1)}
        {rdelim}{if $mt_index|lt($mt_last)},{/if}
    {/foreach}
    ]
{literal}}{/literal}
</script>
{undef $mt_last}
