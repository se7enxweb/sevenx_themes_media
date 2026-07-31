{* Button block - bare anchor like the reference (no slb wrapper; the
   ngl-block wrapper and container come from block.tpl). *}
{if and( $block.values.text|ne(''), $block.values.link|ne('') )}
        <a href={$block.values.link|ezurl}
                             class="{$block.values.class|wash}"
                    >
                        {$block.values.text|wash}
    </a>
{elseif $block.values.text|ne('')}
        <span class="{$block.values.class|wash}">{$block.values.text|wash}</span>
{/if}
