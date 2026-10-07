{* An embedded video. A YouTube video is shown click to load, as on its own
   page: nothing comes from Google until the visitor plays it. The other
   services and uploaded files are not drawn here (they never were). *}
{def $ve_map = $node.object.data_map}
{def $ve_ident = ''}
{if and(is_set($ve_map.video_identifier), $ve_map.video_identifier.has_content)}
    {set $ve_ident = $ve_map.video_identifier.content}
{/if}
{* video_type keeps the option id in data_int (1 YouTube, 2 Vimeo,
   3 Dailymotion, 4 uploaded); an id with no type is YouTube. *}
{def $ve_youtube = true()}
{if and(is_set($ve_map.video_type), $ve_map.video_type.data_int|gt(1))}
    {set $ve_youtube = false()}
{/if}
<div class="view-type view-type-{$view_type} ng-video">
    {if and($ve_youtube, $ve_ident|youtube_id|ne(''))}
        {include uri='design:content/parts/youtube_player.tpl' yt_id=$ve_ident yt_title=$node.name}
    {/if}
</div>
{undef $ve_map $ve_ident $ve_youtube}
