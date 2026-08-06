{* Full-view page header (nexus full-view post_header twig block):
   topic eyebrow, h1 title, author line. Receives module_result. *}
{def $fh_node = false()}
{if and(is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {set $fh_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
{/if}
{if $fh_node}
{if not(is_set($node))}{def $node = $fh_node}{/if}
{if not(is_set($content))}{def $content = $fh_node.object}{/if}
<header class="full-page-header">
    <div class="container">
        {include uri='design:content/parts/main_topic.tpl'}

        <h1 class="full-page-title"><span class="ibexa_string-field">{$fh_node.name|wash}</span></h1>

        <div class="full-page-info">
            {include uri='design:content/parts/author.tpl'}
        </div>
    </div>
</header>
{/if}
{undef $fh_node}
