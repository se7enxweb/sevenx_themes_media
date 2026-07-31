{* Running carousel list *}
{def $allowed_list_classes = array( 'ng_article', 'ng_blog_post', 'ng_news', 'ng_recipe', 'ng_video', 'ng_topic', 'ng_gallery' )}
{def $excluded_names = array( 'Cookie Policy', 'Privacy Policy', 'Blog post test' )}
{def $list_items = array()}
{foreach $block.values.items as $node}
    {if and( $allowed_list_classes|contains( $node.class_identifier ), $excluded_names|contains( $node.name )|not, count($list_items)|lt(3) )}
        {set $list_items = $list_items|append( $node )}
    {/if}
{/foreach}
<div class="running-track">
{foreach $list_items as $node}
    {def $running_image = ''}
    {foreach array('image','teaser_image','cover_image') as $attr_name}
        {if and( is_set( $node.data_map[$attr_name] ), $node.data_map[$attr_name].has_content, $running_image|eq('') )}
            {def $img = $node.data_map[$attr_name].content}
            {if is_set( $img.small )}
                {set $running_image = $img.small.url}
            {elseif is_set( $img.original )}
                {set $running_image = $img.original.url}
            {/if}
            {undef $img}
        {/if}
    {/foreach}
    <article class="running-item">
        <a href={$node.url_alias|ezurl()} class="running-link">
            {if $running_image|ne('')}
                <figure class="running-image"><img src={$running_image|ezroot} alt="" /></figure>
            {/if}
            <h3 class="running-title">{$node.name|wash}</h3>
        </a>
    </article>
    {undef $running_image}
{/foreach}
</div>
{undef $allowed_list_classes $excluded_names $list_items}
