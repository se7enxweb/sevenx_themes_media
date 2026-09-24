{* Video full view, eZ4-native, mirroring the reference ng_video full view:
   youtube player (or file player) + centered header with title and date. *}
{def $vf_map = $node.object.data_map}
{def $vf_ident = ''}
{if and(is_set($vf_map.video_identifier), $vf_map.video_identifier.has_content)}
    {set $vf_ident = $vf_map.video_identifier.content}
{/if}
{* Which service the id belongs to. video_type keeps the option id in
   data_int (1 YouTube, 2 Vimeo, 3 Dailymotion, 4 uploaded -- the reference
   class's options) and data_text is usually empty, so reading only the text
   played every Vimeo and Dailymotion id in a YouTube player that could not
   load it. An id with no type is YouTube, as the older videos are. *}
{def $vf_type = ''}
{if is_set($vf_map.video_type)}
    {set $vf_type = $vf_map.video_type.data_text}
    {if $vf_type|eq('')}
        {set $vf_type = cond( $vf_map.video_type.data_int|eq(2), 'vimeo',
                              $vf_map.video_type.data_int|eq(3), 'dailymotion',
                              $vf_map.video_type.data_int|eq(4), 'upload',
                              'youtube' )}
    {/if}
{/if}
{explblock name='content'}
<div class="view-type view-type-full ng-video vf3">
    {* The reference wraps the player and header in a .container inside the
       view-type div (see content/views/full/ng_video.tpl, which carries it
       too); without it the full view spans the viewport instead of the grid. *}
    <div class="container">
    {explblock name='article_media'}
    <div class="full-video-player">
        {if and($vf_ident|ne(''), $vf_type|ne('upload'))}
        {if $vf_type|contains('vimeo')}
        <div class="video-vimeo ratio ratio-16x9">
            <iframe frameborder="0" src="https://player.vimeo.com/video/{$vf_ident|wash}" title="{$node.name|wash}" width="770" height="433" allowfullscreen></iframe>
        </div>
        {elseif $vf_type|contains('dailymotion')}
        <div class="video-dailymotion ratio ratio-16x9">
            <iframe frameborder="0" src="https://www.dailymotion.com/embed/video/{$vf_ident|wash}" title="{$node.name|wash}" width="770" height="433" allowfullscreen></iframe>
        </div>
        {else}
        <div class="video-youtube ratio ratio-16x9">
            <iframe frameborder="0" src="https://www.youtube.com/embed/{$vf_ident|wash}" title="{$node.name|wash}" width="770" height="433" allowfullscreen></iframe>
        </div>
        {/if}
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
</div>
{/explblock}
{undef $vf_map $vf_ident $vf_type}
