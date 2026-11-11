{* An image embedded inline in rich text: the small alias, linked to nothing. *}
{def $ei_image = $node.data_map.image}
{if and(is_set($ei_image), $ei_image.has_content, is_set($ei_image.content['small']))}
<img class="view-type view-type-embed-inline image" src={$ei_image.content['small'].url|ezroot} alt="{$ei_image.content.alternative_text|wash}" loading="lazy" />
{else}
<a class="view-type view-type-embed-inline image" href={$node.url_alias|ezurl}>{$node.name|wash}</a>
{/if}
{undef $ei_image}
