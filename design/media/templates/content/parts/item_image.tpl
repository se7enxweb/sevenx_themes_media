{* Render image for list item views. Tries teaser_image, then image field.
   Optional: image_alias (defaults to i480; line views pass i320). *}
{def $ii_alias = first_set($image_alias, 'i480')}
{def $img_url = ''}
{def $img_alt = $node.name}
{if and(is_set($node.data_map.teaser_image), $node.data_map.teaser_image.has_content)}
    {set $img_url = ng_image_alias($node.data_map.teaser_image, $ii_alias)}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.teaser_image, 'large')}{/if}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.teaser_image, 'original')}{/if}
    {if $img_url|ne('')}
        {def $img_obj = $node.data_map.teaser_image.content}
        {set $img_alt = $img_obj.alternative_text|cond($img_alt)}
        {undef $img_obj}
    {/if}
{elseif and(is_set($node.data_map.image), $node.data_map.image.has_content)}
    {set $img_url = ng_image_alias($node.data_map.image, $ii_alias)}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.image, 'large')}{/if}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.image, 'original')}{/if}
    {if $img_url|ne('')}
        {def $img_obj = $node.data_map.image.content}
        {set $img_alt = $img_obj.alternative_text|cond($img_alt)}
        {undef $img_obj}
    {/if}
{/if}

{if $img_url|ne('')}
<figure class="image">
    <a href={$node.url_alias|ezurl} title="Read more about {$node.name|wash}"><img src={$img_url|ezroot} loading="lazy" alt="" class="ibexa_image-field"></a>
</figure>
{/if}
{undef $ii_alias $img_url $img_alt}
