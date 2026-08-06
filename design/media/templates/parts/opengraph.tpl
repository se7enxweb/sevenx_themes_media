{def $og_title = ''}
{def $og_description = ''}
{def $og_image = ''}
{def $og_type = 'website'}
{def $og_url = ''}
{def $og_site_name = ezini('SiteSettings','SiteName','site.ini')}
{def $og_content = cond(is_object($content), $content, cond(is_object($node), $node.object, false()))}

{if is_object($og_content)}
    {if is_set($og_content.name)}
        {set $og_title = $og_content.name|wash}
    {/if}
    {if is_set($og_content.class_identifier)}
        {if or($og_content.class_identifier|eq('ng_article'), $og_content.class_identifier|eq('ng_blog_post'), $og_content.class_identifier|eq('ng_recipe'), $og_content.class_identifier|eq('ng_news'))}
            {set $og_type = 'article'}
        {/if}
    {/if}
    {def $og_intro = firstNonEmptyField($og_content, 'teaser_intro', 'intro', 'description')}
    {if not($og_intro.empty)}
        {set $og_description = $og_intro.value.text|shorten(160)}
    {/if}
    {undef $og_intro}
    {if and(is_set($og_content.data_map.teaser_image), $og_content.data_map.teaser_image.has_content)}
        {set $og_image = ng_image_alias($og_content.data_map.teaser_image, 'large')}
    {elseif and(is_set($og_content.data_map.image), $og_content.data_map.image.has_content)}
        {set $og_image = ng_image_alias($og_content.data_map.image, 'large')}
    {/if}
{/if}
{if is_object($node)}
    {if is_set($node.url_alias)}
        {if $node.url_alias|ne('')}
            {set $og_url = concat('https://', ezini('SiteSettings','SiteURL'), '/', $node.url_alias)}
        {/if}
    {/if}
{/if}
{if $og_url|eq('')}
    {set $og_url = concat('https://', ezini('SiteSettings','SiteURL'), '/')}
{/if}

{if and($og_title|ne(''), is_set($open_graph), is_set($open_graph['og:title']))}
    {set $og_title = $open_graph['og:title']}
{/if}

{if $og_title|ne('')}
<meta property="og:site_name" content="{$og_site_name|wash}" />
<meta property="og:title" content="{$og_title}" />
<meta property="og:description" content="{$og_description|wash}" />
<meta property="og:type" content="{$og_type}" />
<meta property="og:url" content="{$og_url}" />
    {if $og_image|ne('')}
<meta property="og:image" content="{concat('https://', ezini('SiteSettings','SiteURL'), '/', $og_image)}" />
    {/if}
{/if}

{undef $og_title}
{undef $og_description}
{undef $og_image}
{undef $og_type}
{undef $og_url}
{undef $og_site_name}
{undef $og_node}
