{* Render image for list item views. Tries teaser_image, then image field.
   Optional: image_alias (defaults to i480; line views pass i320).
   Optional: eager - pass true() for an image that is above the fold. A lazy
   image is not fetched until layout reaches it, so if the largest contentful
   element is lazy the browser discovers it late and LCP suffers. Everything
   stays lazy by default; only a caller that knows its image is first should
   opt out. *}
{def $ii_alias = first_set($image_alias, 'i480')}
{def $ii_eager = first_set($eager, false())}
{def $img_url = ''}
{def $img_alt = $node.name}
{def $img_attr = false()}
{def $img_srcset = ''}
{def $img_w = 0}
{def $img_h = 0}
{if and(is_set($node.data_map.teaser_image), $node.data_map.teaser_image.has_content)}
    {set $img_attr = $node.data_map.teaser_image}
      {set $img_url = ng_image_alias($node.data_map.teaser_image, $ii_alias)}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.teaser_image, 'large')}{/if}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.teaser_image, 'original')}{/if}
    {if $img_url|ne('')}
        {def $img_obj = $node.data_map.teaser_image.content}
        {set $img_alt = $img_obj.alternative_text|first_set($img_alt)}
        {undef $img_obj}
    {/if}
{elseif and(is_set($node.data_map.image), $node.data_map.image.has_content)}
    {set $img_attr = $node.data_map.image}
      {set $img_url = ng_image_alias($node.data_map.image, $ii_alias)}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.image, 'large')}{/if}
    {if $img_url|eq('')}{set $img_url = ng_image_alias($node.data_map.image, 'original')}{/if}
    {if $img_url|ne('')}
        {def $img_obj = $node.data_map.image.content}
        {set $img_alt = $img_obj.alternative_text|first_set($img_alt)}
        {undef $img_obj}
    {/if}
{/if}

{* Offer the smaller renditions as well, and let the browser choose.

   Measured in a real browser at a 1280px viewport: 28 of 43 images arrived at
   480px and were drawn at 352-356px, so roughly 46% of the delivered pixels
   were discarded during scaling. Images are about three quarters of what this
   page actually puts on the wire, so that is the largest single waste on it.

   srcset rather than a smaller alias outright, because the right size depends
   on things only the browser knows: the viewport, the pixel density, and how
   wide this slot ended up. A retina display still gets i480 and still looks
   right; a phone gets i320 and stops paying for pixels it cannot show.

   sizes describes the slot, and has to, or the browser assumes full width and
   picks the largest candidate every time -- which is what we have today. The
   grid is one column on a phone, two on a tablet and three above that, and
   28vw is the measured 352px of 1280. *}
{if $img_url|ne('')}
{if $img_attr}
    {* Width and height, so the browser can reserve the space before the image
       arrives. Without them every image on this page pushed the content below
       it down as it loaded, which is layout shift -- the thing that makes a
       page feel unfinished even when it is fast. The numbers are the alias's
       own, read off the same rendition that src points at; any of the three
       would give the same aspect ratio, which is what the browser derives
       from them. *}
    {set $img_w = $img_attr.content[$ii_alias].width}
    {set $img_h = $img_attr.content[$ii_alias].height}
    {* ezroot('no') because the default wraps each url in quotes of its own,
       and three quoted urls inside one quoted attribute is a srcset the
       browser discards without complaint -- it simply keeps using src. *}
    {set $img_srcset = concat(
        ng_image_alias($img_attr, 'i320')|ezroot('no'), ' 320w, ',
        ng_image_alias($img_attr, 'i400')|ezroot('no'), ' 400w, ',
        ng_image_alias($img_attr, 'i480')|ezroot('no'), ' 480w'
    )}
{/if}
<figure class="image">
    <a href={$node.url_alias|ezurl} title="Read more about {$node.name|wash}"><img src={$img_url|ezroot}{if and($img_w|gt(0), $img_h|gt(0))} width="{$img_w}" height="{$img_h}"{/if}{if $img_srcset|ne('')} srcset="{$img_srcset}" sizes="(max-width: 767px) 100vw, (max-width: 1199px) 50vw, 28vw"{/if}{if $ii_eager} fetchpriority="high"{else} loading="lazy"{/if} alt="{$img_alt|wash}" class="ibexa_image-field"></a>
</figure>
{/if}
{undef $ii_alias $ii_eager $img_url $img_alt $img_attr $img_srcset $img_w $img_h}
