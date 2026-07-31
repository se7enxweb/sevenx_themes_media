{if $block.values.title}
    {if $block.values.tag|ne('')}{def $tag = $block.values.tag}{else}{def $tag = concat('h', $block.values.level)}{/if}
    <{$tag} class="section-title text-center">{$block.values.title|wash}</{$tag}>
    {undef $tag}
{/if}
