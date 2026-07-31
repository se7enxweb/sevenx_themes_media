{* Render image for list item views. Tries teaser_image, then image field.
   Optional: image_alias (defaults to i480; line views pass i320). *}
{def $ii_alias = first_set($image_alias, 'i480')}
{def $img_url = ''}
{def $img_alt = $node.name}
{if and(is_set($node.data_map.teaser_image), $node.data_map.teaser_image.has_content)}
    {def $img_obj = $node.data_map.teaser_image.content}
    {if is_set($img_obj[$ii_alias])}{set $img_url = $img_obj[$ii_alias].url}
    {elseif is_set($img_obj['large'])}{set $img_url = $img_obj['large'].url}
    {elseif is_set($img_obj['original'])}{set $img_url = $img_obj['original'].url}{/if}
    {set $img_alt = $img_obj.alternative_text|cond($img_alt)}
{elseif and(is_set($node.data_map.image), $node.data_map.image.has_content)}
    {def $img_obj = $node.data_map.image.content}
    {if is_set($img_obj[$ii_alias])}{set $img_url = $img_obj[$ii_alias].url}
    {elseif is_set($img_obj['large'])}{set $img_url = $img_obj['large'].url}
    {elseif is_set($img_obj['original'])}{set $img_url = $img_obj['original'].url}{/if}
    {set $img_alt = $img_obj.alternative_text|cond($img_alt)}
{/if}

{if $img_url|ne('')}
<figure class="image">
    <a href={$node.url_alias|ezurl} title="Read more about {$node.name|wash}"><img src={$img_url|ezroot} loading="lazy" alt="" class="ibexa_image-field"></a>
</figure>
{/if}
{undef $ii_alias $img_url $img_alt}
