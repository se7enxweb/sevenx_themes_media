{* Full recipe info box (nexus full-view right twig block):
   calories, serving macros, preparation time, social share. *}
{def $fr_node = false()}
{if and(is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {set $fr_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
{/if}
{if $fr_node}
{def $fr_map = $fr_node.data_map}
<div class="full-recipe-info">
    {if is_set($fr_map['serving_calories'])}
    {if $fr_map['serving_calories'].has_content}
    <div class="recipe-calories">
        <span class="ibexa_integer-field">{$fr_map['serving_calories'].content}</span> cal
    </div>
    {/if}
    {/if}
    <ul class="recipe-serving-info">
        {if is_set($fr_map['serving_fat'])}
        {if $fr_map['serving_fat'].has_content}
        <li><span class="ibexa_integer-field">{$fr_map['serving_fat'].content}</span> <span class="tt">fat</span></li>
        {/if}
        {/if}
        {if is_set($fr_map['serving_carbohydrates'])}
        {if $fr_map['serving_carbohydrates'].has_content}
        <li><span class="ibexa_integer-field">{$fr_map['serving_carbohydrates'].content}</span> <span class="tt">carbs</span></li>
        {/if}
        {/if}
        {if is_set($fr_map['serving_protein'])}
        {if $fr_map['serving_protein'].has_content}
        <li><span class="ibexa_integer-field">{$fr_map['serving_protein'].content}</span> <span class="tt">protein</span></li>
        {/if}
        {/if}
    </ul>
    {if is_set($fr_map['preparation_time'])}
    {if $fr_map['preparation_time'].has_content}
    <div class="recipe-time">
        Preparation time
        <time><span class="ibexa_integer-field">{$fr_map['preparation_time'].content}</span> min</time>
    </div>
    {/if}
    {/if}
    {include uri='design:content/parts/social_share.tpl' node=$fr_node content=$fr_node.object}
</div>
{undef $fr_map}
{/if}
{undef $fr_node}
