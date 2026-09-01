{* Audio full view, eZ4-native: header, audio player, intro/description, tags. *}
{def $view_type = 'full'}
{def $content = $node.object}
{def $audio_map = $node.object.data_map}
{explblock name='content'}
<div class="view-type view-type-{$view_type} ng-audio">
    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            {include uri='design:content/parts/main_topic.tpl' content=$content}

            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>

            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl' content=$content node=$node}
                {include uri='design:content/parts/time.tpl' node=$node}
            </div>
        </div>
    </header>
    {/explblock}

    {if and(is_set($audio_map.image), $audio_map.image.has_content)}
        {explblock name='article_media'}
        <div class="full-page-image">
            <div class="container container-wide">
                {attribute_view_gui attribute=$audio_map.image}
            </div>
        </div>
        {/explblock}
    {/if}

    {if and(is_set($audio_map.file), $audio_map.file.has_content)}
        {def $audio_media = $audio_map.file.content}
        {def $audio_url = concat('/content/download/', $node.object.id, '/', $audio_map.file.id, '/', $audio_map.file.version, '/', $audio_media.original_filename|urlencode)}
        {explblock name='article_media'}
        <div class="full-page-audio">
            <div class="container container-narrow">
                <audio controls>
                    <source type="{$audio_media.mime_type|wash}" src="{$audio_url|ezroot(no)}" />
                    Your browser does not support the audio element.
                </audio>
            </div>
        </div>
        {/explblock}
        {undef $audio_media $audio_url}
    {/if}

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">
            {if and(is_set($audio_map.teaser_intro), $audio_map.teaser_intro.has_content)}
                <div class="full-page-intro">
                    <div class="ibexa_richtext-field">{attribute_view_gui attribute=$audio_map.teaser_intro}</div>
                </div>
            {/if}
            {if and(is_set($audio_map.description), $audio_map.description.has_content)}
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$audio_map.description}</div>
            {/if}
            {include uri='design:content/parts/tags.tpl' content=$content node=$node}
        </div>
        {/explblock}
    </div>
</div>
{/explblock}
{undef $content $audio_map}
