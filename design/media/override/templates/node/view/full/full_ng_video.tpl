{* Video full view, eZ4-native, mirroring the reference ng_video full view:
   youtube player (or file player) + centered header with title and date. *}
{def $vf_map = $node.object.data_map}
{def $vf_ident = ''}
{if and(is_set($vf_map.video_identifier), $vf_map.video_identifier.has_content)}
    {set $vf_ident = $vf_map.video_identifier.content}
{/if}
<div class="view-type view-type-full ng-video vf3">
    <div class="container">
        <div class="full-video-player">
            {if $vf_ident|ne('')}
            <div class="video-youtube ratio ratio-16x9">
                <iframe frameborder="0" src="https://www.youtube.com/embed/{$vf_ident}" title="{$node.name|wash}" width="770" height="433" allowfullscreen></iframe>
            </div>
            {elseif and(is_set($vf_map.video_file), $vf_map.video_file.has_content)}
            <div class="ratio ratio-16x9">
                <video controls width="770" height="433">
                    <source src={concat('content/download/', $node.contentobject_id, '/', $vf_map.video_file.id, '/version/', $node.object.current_version, '/file/', $vf_map.video_file.content.original_filename|urlencode)|ezurl(no)} />
                </video>
            </div>
            {/if}
        </div>
        <header class="full-video-header">
            <h1 class="title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>
            <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
        </header>
    </div>
</div>
{undef $vf_map $vf_ident}
