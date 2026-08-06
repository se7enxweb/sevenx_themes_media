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
    {if $mt_meta.og_image|ne('')}
        {def $mt_image_object = fetch('content','object',hash('id',$mt_meta.og_image|int))}
        {if and($mt_image_object, is_set($mt_image_object.data_map))}
            {def $mt_image_attr = false()}
            {if is_set($mt_image_object.data_map.site_opengraph_image)}{set $mt_image_attr = $mt_image_object.data_map.site_opengraph_image}{/if}
            {if and(not($mt_image_attr), is_set($mt_image_object.data_map.site_logo))}{set $mt_image_attr = $mt_image_object.data_map.site_logo}{/if}
            {if and(not($mt_image_attr), is_set($mt_image_object.data_map.file))}{set $mt_image_attr = $mt_image_object.data_map.file}{/if}
            {if and(not($mt_image_attr), is_set($mt_image_object.data_map.image))}{set $mt_image_attr = $mt_image_object.data_map.image}{/if}
            {if $mt_image_attr}
                {def $mt_image_path = ''}
                {def $mt_image_width = ''}
                {def $mt_image_height = ''}
                {def $mt_image_type = ''}
                {if eq($mt_image_attr.data_type_string, 'ezbinaryfile')}
                    {set $mt_image_path = $mt_image_attr.content.filepath}
                    {set $mt_image_type = $mt_image_attr.content.mime_type}
                {elseif eq($mt_image_attr.data_type_string, 'ezimage')}
                    {if $mt_image_attr.content.original}
                        {set $mt_image_path = $mt_image_attr.content.original.full_path}
                        {set $mt_image_width = cond( is_set($mt_image_attr.content.original.info.Width), $mt_image_attr.content.original.info.Width, $mt_image_attr.content.original.width )}
                        {set $mt_image_height = cond( is_set($mt_image_attr.content.original.info.Height), $mt_image_attr.content.original.info.Height, $mt_image_attr.content.original.height )}
                        {set $mt_image_type = $mt_image_attr.content.original.mime_type}
                    {/if}
                {/if}
                {if $mt_image_path|ne('')}
                    {def $mt_image_url = concat('https://', ezini('SiteSettings','SiteURL'), '/', $mt_image_path)}
<meta property="og:image" content="{$mt_image_url|wash}" />
                    {if $mt_meta.og_image_type|ne('')}<meta property="og:image:type" content="{$mt_meta.og_image_type|wash}" />{elseif $mt_image_type|ne('')}<meta property="og:image:type" content="{$mt_image_type|wash}" />{/if}
                    {if $mt_meta.og_image_width|ne('')}<meta property="og:image:width" content="{$mt_meta.og_image_width|wash}" />{elseif $mt_image_width|ne('')}<meta property="og:image:width" content="{$mt_image_width|wash}" />{/if}
                    {if $mt_meta.og_image_height|ne('')}<meta property="og:image:height" content="{$mt_meta.og_image_height|wash}" />{elseif $mt_image_height|ne('')}<meta property="og:image:height" content="{$mt_image_height|wash}" />{/if}
                    {if $mt_meta.og_image_alt|ne('')}<meta property="og:image:alt" content="{$mt_meta.og_image_alt|wash}" />{elseif $mt_image_object.name|ne('')}<meta property="og:image:alt" content="{$mt_image_object.name|wash}" />{/if}
                {/if}
            {/if}
        {/if}
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
