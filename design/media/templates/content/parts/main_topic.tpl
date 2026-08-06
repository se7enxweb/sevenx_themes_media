{* eZ4-native: sponsored disclosure text or the main topic link; tag data
   comes from the imported eztags link table (content_tags operator). *}
{def $mt_map = $content.data_map}
{def $mt_topics = content_tags($content, 'main_topic')}

{def $mt_sponsored = false()}
{if is_set($mt_map.sponsored_content_disclosure)}
    {if $mt_map.sponsored_content_disclosure.has_content}
        {set $mt_sponsored = true()}
    {/if}
{/if}

{if or($mt_sponsored, $mt_topics|count()|gt(0))}
    <div class="full-page-eyebrow">
        {if $mt_sponsored}
            <span class="important-notice">{$mt_map.sponsored_content_disclosure.content|wash}</span>
        {else}
            <a class="main-topic" href={concat('/topics/', $mt_topics[0].keyword)|ezurl}>{$mt_topics[0].keyword|wash}</a>
        {/if}
    </div>
{/if}
{undef $mt_map $mt_topics $mt_sponsored}
