

{* Tag associations come from the imported eztags link table via the
   content_tags() operator (no eztags extension on this install). *}
{def $tg_tags = content_tags($content, '-main_topic')}
{if $tg_tags|count()|gt(0)}
    <div class="full-page-tags" role="list" aria-label="{$'ngsite.tags.related_tags'|trans}">
        {foreach $tg_tags as $tg_tag}
            <a href={concat('/tags/', $tg_tag.keyword)|ezurl} aria-label="{$'ngsite.tags.tag'|trans}: {$tg_tag.keyword|wash}" role="listitem" >{$tg_tag.keyword|wash}</a>
        {/foreach}
    </div>
{/if}
{undef $tg_tags}