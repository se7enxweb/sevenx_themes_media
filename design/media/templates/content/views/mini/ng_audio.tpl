


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-audio vl5">
    {def $au_url = ''}
    {if and(is_set($node.data_map.image), $node.data_map.image.has_content)}
        {def $au_img = $node.data_map.image.content}
        {if is_set($au_img['i160'])}{set $au_url = $au_img['i160'].url}
        {elseif is_set($au_img['large'])}{set $au_url = $au_img['large'].url}
        {elseif is_set($au_img['original'])}{set $au_url = $au_img['original'].url}{/if}
        {undef $au_img}
    {/if}
    <figure class="image">
        <i class="icon-volume-up article-icon" aria-hidden="true"></i>
        {if $au_url|ne('')}<a href={$node.url_alias|ezurl} title="Read more about {$node.name|wash}"><img src={$au_url|ezroot} loading="lazy" alt="" class="ibexa_image-field" /></a>{/if}
    </figure>
    {undef $au_url}
    <header class="article-header">
        <h2 class="title"><a href={$node.url_alias|ezurl}>{title($content_fields, $content)}</a></h2>
    </header>
</article>