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
            {* ngsite_topic_path resolves the tag to its ng_topic node URL and
               falls back to the tag's own page when no topic carries it, which
               is what the reference UrlGenerator does. *}
            {def $mt_url = ngsite_topic_path($mt_topics[0])}
            {if $mt_url|ne('')}
                <a class="main-topic" href={$mt_url|ezurl}>{$mt_topics[0].keyword|wash}</a>
            {else}
                <span class="main-topic">{$mt_topics[0].keyword|wash}</span>
            {/if}
            {undef $mt_url}
        {/if}
    </div>
{/if}
{undef $mt_map $mt_topics $mt_sponsored}
