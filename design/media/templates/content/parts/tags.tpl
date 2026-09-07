{* Tag associations come from the imported eztags link table via the
   content_tags() operator (no eztags extension on this install). *}
{def $tg_tags = content_tags($content, '-main_topic')}
{if $tg_tags|count()|gt(0)}
    <div class="full-page-tags" role="list" aria-label="{'ngsite.tags.related_tags'|trans}">
        {def $tg_url = ''}
        {foreach $tg_tags as $tg_tag}
            {* Every tag links to its own tag page, which is what the reference
               does here (ibexa_path(tag)). Only main_topic.tpl prefers an
               ng_topic node over the tag page. *}
            {set $tg_url = tag_url($tg_tag)}
            {if $tg_url|ne('')}
                <a href={$tg_url|ezurl} aria-label="{'ngsite.tags.tag'|trans} {$tg_tag.keyword|wash}" role="listitem" >{$tg_tag.keyword|wash}</a>
            {else}
                <span aria-label="{'ngsite.tags.tag'|trans} {$tg_tag.keyword|wash}" role="listitem" >{$tg_tag.keyword|wash}</span>
            {/if}
        {/foreach}
        {undef $tg_url}
    </div>
{/if}
{undef $tg_tags}
