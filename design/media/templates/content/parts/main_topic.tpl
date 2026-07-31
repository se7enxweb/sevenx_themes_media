


{* eZ4-native: sponsored disclosure text or the main topic link; tag data
   comes from the imported eztags link table (content_tags operator). *}
{def $mt_map = $content.data_map}
{def $mt_topics = content_tags($content, 'main_topic')}

{if or(and(is_set($mt_map.sponsored_content_disclosure), $mt_map.sponsored_content_disclosure.has_content), $mt_topics|count()|gt(0))}
    <div class="full-page-eyebrow">
        {if and(is_set($mt_map.sponsored_content_disclosure), $mt_map.sponsored_content_disclosure.has_content)}
            <span class="important-notice">{$mt_map.sponsored_content_disclosure.content|wash}</span>
        {else}
            <a class="main-topic" href={concat('/topics/', $mt_topics[0].keyword)|ezurl}>{$mt_topics[0].keyword|wash}</a>
        {/if}
    </div>
{/if}
{undef $mt_map $mt_topics}