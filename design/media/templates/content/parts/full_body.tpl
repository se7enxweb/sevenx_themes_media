{* Full-view page body (nexus full-view left twig block #1):
   intro richtext + body richtext + tags. *}
{def $fb_node = false()}
{if and(is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {set $fb_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
{/if}
{if $fb_node}
{explblock name='article_body'}
<div class="full-page-body">
    {if is_set($fb_node.data_map.full_intro)}
        {if $fb_node.data_map.full_intro.has_content}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$fb_node.data_map.full_intro}</div>
            </div>
        {/if}
    {/if}
    {if is_set($fb_node.data_map.body)}
        {if $fb_node.data_map.body.has_content}
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$fb_node.data_map.body}</div>
        {/if}
    {/if}
    {include uri='design:content/parts/tags.tpl' node=$fb_node content=$fb_node.object}
</div>
{/explblock}
{/if}
{undef $fb_node}
