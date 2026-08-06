<meta name="generator" content="{'Exponential powered by 7x'|i18n('design/media/pagelayout')}">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2">
<meta name="theme-color" content="#ffffff">

{def $mt_info = fetch('content','object',hash('object_id',839))}
{def $mt_meta = false()}
{if is_object($mt_info)}
    {if $mt_info.data_map.metadata.has_content}
        {set $mt_meta = $mt_info.data_map.metadata.content}
    {/if}
{/if}
{def $mt_description = ''}
{def $mt_content = cond(is_object($content), $content, cond(is_object($node), $node.object, false()))}
{if is_object($mt_content)}
    {def $mt_intro = firstNonEmptyField($mt_content, 'teaser_intro', 'intro', 'description')}
    {if not($mt_intro.empty)}
        {set $mt_description = $mt_intro.value.text|shorten(160)}
    {/if}
    {undef $mt_intro}
{/if}
{undef $mt_content}
{if $mt_description|ne('')}
<meta name="description" content="{$mt_description|wash}" />
{elseif $mt_meta}
    {if is_set($mt_meta.metas.keywords)}
<meta name="keywords" content="{$mt_meta.metas.keywords.content|wash}" />
    {/if}
    {if is_set($mt_meta.metas.description)}
<meta name="description" content="{$mt_meta.metas.description.content|wash}" />
    {/if}
{/if}
{undef $mt_description}
{undef $mt_meta}
{undef $mt_info}

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
