{def $site_name = ezini('SiteSettings','SiteName','site.ini')}
{def $show_path = true}
{def $node = false()}
{def $content = false()}
{def $path_array = array()}
{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {set $node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
            {if $node}
                {set $content = $node.object}
                {* $node.path yields ancestor NODES; breadcrumbs.tpl and the ld+json in
                   meta.tpl both consume hash('text','url'), current page url = false. *}
                {* The reference path starts at the SITE root (e.g. Fit & Healthy,
                   depth 2), never at the shared content root node 2 (depth 1) -
                   including it makes every breadcrumb one item longer than nexus. *}
                {foreach $node.path as $path_node}
                    {if $path_node.depth|gt(1)}
                        {set $path_array = $path_array|append(hash('text', $path_node.name, 'url', $path_node.url_alias))}
                    {/if}
                {/foreach}
                {set $path_array = $path_array|append(hash('text', $node.name, 'url', false()))}
            {/if}
        {/if}
    {/if}
{/if}
{include uri='design:pagelayout/variables.tpl'}

{def $payload_view = and( is_array($module_result.content_info), is_set($module_result.content_info.viewmode), $module_result.content_info.viewmode|eq('payload') )}
{if $payload_view}
{$module_result.content}
{else}
<!DOCTYPE html>
<html lang="{ezini('RegionalSettings','Locale')|ristring(array('eng-','ger-','deu-'), array('en-','de-','de-'))}">
<head>
    <meta charset="utf-8">
    {include uri='design:pagelayout/head/title.tpl'}
    {include uri='design:pagelayout/head/meta.tpl'}
    {if and($node, $node.class_identifier|eq('ng_recipe'))}
        {include uri='design:pagelayout/head/recipe_schema.tpl' node=$node}
    {/if}
    {include uri='design:pagelayout/head/link.tpl'}
    {include uri='design:pagelayout/head/style.tpl'}
    {include uri='design:pagelayout/head/script.tpl'}
    {include uri='design:parts/opengraph.tpl'}
    {include uri='design:parts/google_tag_manager_code_script.tpl'}
</head>
<body>
{include uri='design:pagelayout/accessibility_links.tpl'}
{include uri='design:parts/google_tag_manager_code_noscript.tpl'}
{def $el_layout = false()}
{def $el_node_id = 0}
{def $mp = module_params()}
{def $el_use_layout = and( is_set($mp.module_name), $mp.module_name|eq('content'), is_set($mp.function_name), $mp.function_name|eq('view'), is_set($mp.parameters.ViewMode), $mp.parameters.ViewMode|eq('full') )}
{if $el_use_layout}
    {if and(is_array($module_result.content_info), is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
        {set $el_node_id = $module_result.content_info.node_id}
    {elseif is_set($node.node_id)}
        {set $el_node_id = $node.node_id}
    {/if}
    {if $el_node_id|gt(0)}
        {set $el_layout = fetch('explayouts','resolve_layout_for_node',hash('node_id',$el_node_id))}
    {else}
        {set $el_layout = fetch('explayouts','resolve_layout',hash())}
    {/if}
{/if}
{def $el_renderable_blocks = 0}
{if and(is_array($el_layout), is_set($el_layout.zones))}
    {foreach $el_layout.zones as $el_zone}
        {if is_set($el_zone.blocks)}
            {foreach $el_zone.blocks as $el_zone_block}
                {if and($el_zone_block.parent_id|eq(0), $el_zone_block.definition_identifier|ne(''))}
                    {set $el_renderable_blocks = $el_renderable_blocks|sum(1)}
                {/if}
            {/foreach}
        {/if}
    {/foreach}
{/if}
{if and(is_array($el_layout), $el_renderable_blocks|gt(0))}
{* Layout page: reference structure - zones carry the site header/footer via
   twig blocks, the content zones sit inside <main class="main-content-block">. *}
{def $el_path_attr = '[]'}
{if $node}{set $el_path_attr = concat('["', $node.path_array|implode('&quot;,&quot;'), '"]')}{/if}
<div id="page" role="main" data-path='{$el_path_attr}'>
    {include uri='design:explayouts/layout.tpl' layout=$el_layout module_result=$module_result}
</div>
{undef $el_path_attr}
{else}
{include uri='design:pagelayout/header.tpl'}

<div id="page" role="main">
    <div id="main" class="main-content-block">
        {$module_result.content}
    </div>

    {include uri='design:pagelayout/footer.tpl'}
</div>
{/if}
{undef $el_renderable_blocks}

{include uri='design:pagelayout/cookie_control.tpl'}
{include uri='design:pagelayout/script_bottom.tpl'}
</body>
</html>
{/if}
