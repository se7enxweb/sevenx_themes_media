


{def $node = fetch('content','node',hash('node_id',$location.node_id))}
{def $sv_ident = ''}
{if and(is_set($node.data_map.video_identifier), $node.data_map.video_identifier.has_content)}
    {set $sv_ident = $node.data_map.video_identifier.content}
{/if}
{def $sv_has_file = false()}
{if and(is_set($node.data_map.video_file), $node.data_map.video_file.has_content)}
    {set $sv_has_file = true()}
{/if}
{if or($sv_ident|ne(''), $sv_has_file)}
    <article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-{$view_type} ng-video vl1">
        <i class="icon-play article-icon" aria-hidden="true"></i>
        <figure class="image">
            <a href={$node.url_alias|ezurl} class="ratio ratio-16x9" title="Read more about {$node.name|wash}">
                {if $sv_ident|ne('')}
                    <img src="https://img.youtube.com/vi/{$sv_ident}/mqdefault.jpg" alt="">
                {elseif and(is_set($node.data_map.poster), $node.data_map.poster.has_content)}
                    {def $sv_poster = $node.data_map.poster.content}
                    {def $sv_url = ''}
                    {if is_set($sv_poster['i480'])}
                        {set $sv_url = $sv_poster['i480'].url}
                    {elseif is_set($sv_poster['original'])}
                        {set $sv_url = $sv_poster['original'].url}
                    {/if}
                    {if $sv_url|ne('')}<img src={$sv_url|ezroot} loading="lazy" alt="" class="ibexa_image-field">{/if}
                    {undef $sv_poster $sv_url}
                {/if}
            </a>
        </figure>

        <header class="article-header">
            <h3 class="title"><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
        </header>
        {if first_set($with_intro, false)}
            {if and(is_set($node.object.data_map.teaser_intro), $node.object.data_map.teaser_intro.has_content)}<div class="short"><div class="ibexa_richtext-field">{attribute_view_gui attribute=$node.object.data_map.teaser_intro}</div></div>{elseif and(is_set($node.object.data_map.full_intro), $node.object.data_map.full_intro.has_content)}<div class="short"><div class="ibexa_richtext-field">{attribute_view_gui attribute=$node.object.data_map.full_intro}</div></div>{/if}
        {/if}
    </article>
{/if}
{undef $sv_ident $sv_has_file}