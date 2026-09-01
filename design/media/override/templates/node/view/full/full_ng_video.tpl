{* Video full view, eZ4-native, mirroring the reference ng_video full view:
   youtube player (or file player) + centered header with title and date. *}
{def $vf_map = $node.object.data_map}
{def $vf_ident = ''}
{if and(is_set($vf_map.video_identifier), $vf_map.video_identifier.has_content)}
    {set $vf_ident = $vf_map.video_identifier.content}
{/if}
{explblock name='content'}
<div class="view-type view-type-full ng-video vf3">
    {explblock name='article_media'}
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
    {/explblock}

    {explblock name='article_header'}
    <header class="full-video-header">
        <h1 class="title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>
        <time>{$node.object.published|datetime('custom', '%j %M %Y')}</time>
    </header>
    {/explblock}

    {if $node.object.data_map.description.has_content}
    {explblock name='article_body'}
    <div class="body">
        <div class="ibexa_richtext-field">
            {attribute_view_gui attribute=$node.object.data_map.description}
        </div>
    </div>
    {/explblock}
    {/if}
</div>
{/explblock}
{undef $vf_map $vf_ident}
