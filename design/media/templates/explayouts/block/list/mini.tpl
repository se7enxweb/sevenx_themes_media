{* Mini list matching Nexus ng_recipe view *}
{def $excluded_names = array( 'Cookie Policy', 'Privacy Policy', 'Blog post test' )}
{def $list_items = array()}
{foreach $block.values.items as $node}
    {if and( $node.class_identifier|eq('ng_recipe'), $excluded_names|contains( $node.name )|not, count($list_items)|lt(6) )}
        {set $list_items = $list_items|append( $node )}
    {/if}
{/foreach}
<div class="list-row">
{foreach $list_items as $node}
    {def $mini_image = ''}
    {def $recipe_time = ''}
    {def $recipe_cal = ''}
    {foreach array('image','teaser_image','cover_image') as $attr_name}
        {if and( is_set( $node.data_map[$attr_name] ), $node.data_map[$attr_name].has_content, $mini_image|eq('') )}
            {def $img = $node.data_map[$attr_name].content}
            {if is_set( $img.i160 )}
                {set $mini_image = $img.i160.url}
            {elseif is_set( $img.small )}
                {set $mini_image = $img.small.url}
            {elseif is_set( $img.original )}
                {set $mini_image = $img.original.url}
            {/if}
            {undef $img}
        {/if}
    {/foreach}
    {if and( is_set( $node.data_map.preparation_time ), $node.data_map.preparation_time.has_content )}
        {def $raw_time = $node.data_map.preparation_time.content}
        {if $raw_time|is_numeric|and($raw_time|gt(0))}
            {set $recipe_time = $raw_time}
        {/if}
        {undef $raw_time}
    {/if}
    {if and( is_set( $node.data_map.serving_calories ), $node.data_map.serving_calories.has_content )}
        {def $raw_cal = $node.data_map.serving_calories.content}
        {if $raw_cal|is_numeric|and($raw_cal|gt(0))}
            {set $recipe_cal = $raw_cal}
        {/if}
        {undef $raw_cal}
    {/if}
    <div class="list-item">
        <article data-item="true" data-content-id="{$node.contentobject_id}" data-location-id="{$node.node_id}" class="view-type view-type-mini ng-recipe vl5">
            {if $mini_image|ne('')}
                <figure class="image">
                    <a href={$node.url_alias|ezurl()} title="{$node.name|wash}"><img src={$mini_image|ezroot} alt="{$node.name|wash}" loading="lazy" class="ibexa_image-field" /></a>
                </figure>
            {/if}
            <header class="article-header">
                <h3 class="title"><a href={$node.url_alias|ezurl()}>{$node.name|wash}</a></h3>
                <div class="info">
                    {if and( is_set( $node.object.owner ), $node.object.owner.is_in_version )}
                        <a class="author" href={concat( '/content/view/full/', $node.object.owner.id )|ezurl()}>{$node.object.owner.name|wash}</a>
                    {/if}
                    <span class="recipe-details">
                        {if $recipe_time|ne('')}<span><i class="icon-clock"></i> <span class="ibexa_integer-field">{$recipe_time}</span> min</span>{/if}
                        {if $recipe_cal|ne('')}<span><i class="icon-fire"></i> <span class="ibexa_integer-field">{$recipe_cal}</span> cal</span>{/if}
                    </span>
                </div>
            </header>
        </article>
    </div>
    {undef $mini_image $recipe_time $recipe_cal}
{/foreach}
</div>
{undef $excluded_names $list_items}
