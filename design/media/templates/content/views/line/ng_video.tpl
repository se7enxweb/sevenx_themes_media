


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT content/macros/video.tpl AS video *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
{def $vd_node = fetch('content','node',hash('node_id',$location.node_id))}
{def $vd_youtube = ''}
{if and(is_set($vd_node.data_map.video_identifier), $vd_node.data_map.video_identifier.has_content)}
    {set $vd_youtube = $vd_node.data_map.video_identifier.content}
{/if}
{if $vd_youtube|ne('')}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-video vl4">
    <i class="icon-play article-icon" aria-hidden="true"></i>
    <figure class="image">
    <a href={$vd_node.url_alias|ezurl} class="ratio ratio-16x9" title="Read more about {$vd_node.name|wash}">
        <img src="https://img.youtube.com/vi/{$vd_youtube|wash}/mqdefault.jpg" alt="" />
    </a>
    </figure>
    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
        </header>
        {intro($content_fields, $content)}
    </div>
</article>
{/if}
{undef $vd_youtube}
{undef $vd_node}