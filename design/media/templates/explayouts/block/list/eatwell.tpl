{* Eat Well view matching Nexus: large overlay-ish first + 2x2 overlay grid below *}
{def $allowed_classes = array( 'ng_article', 'ng_recipe', 'ng_blog_post', 'ng_news', 'ng_video' )}
{def $excluded_names = array( 'Cookie Policy', 'Privacy Policy', 'Blog post test' )}
{def $list_items = array()}
{foreach $block.values.items as $node}
    {if and( $allowed_classes|contains( $node.class_identifier ), $excluded_names|contains( $node.name )|not, count($list_items)|lt(5) )}
        {set $list_items = $list_items|append( $node )}
    {/if}
{/foreach}
<div class="eat-well">
    {if count( $list_items )|gt(0)}
        <div class="eat-well-featured">
            {include uri='design:content/views/overlay/_item.tpl' node=$list_items[0] view_type='overlay' vl_class='vl1'}
        </div>
    {/if}
    {if count( $list_items )|gt(1)}
        <div class="eat-well-rest">
            {foreach $list_items as $idx => $node}
                {if $idx|gt(0)}
                    {include uri='design:content/views/overlay/_item.tpl' node=$node view_type='overlay' vl_class='vl2'}
                {/if}
            {/foreach}
        </div>
    {/if}
</div>
{undef $allowed_classes $excluded_names $list_items}
