{def $site_name = ezini('SiteSettings','SiteName','site.ini')}
{def $show_path = true}
{def $node = false()}
{if is_set($content)}{set $content = false()}{else}{def $content = false()}{/if}
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
{def $layout_preview_view = and( is_array($module_result.content_info), is_set($module_result.content_info.viewmode), $module_result.content_info.viewmode|eq('layout_preview') )}
{if $payload_view}
{$module_result.content}
{elseif $layout_preview_view}
<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash}">
<head>
    <meta charset="utf-8">
    {include uri='design:pagelayout/head/title.tpl'}
    {include uri='design:pagelayout/head/meta.tpl'}
    {include uri='design:pagelayout/head/link.tpl'}
    {include uri='design:pagelayout/head/style.tpl'}
    {include uri='design:pagelayout/head/script.tpl'}
</head>
<body>
<div id="page" role="main">
    {$module_result.content}
</div>
{include uri='design:pagelayout/script_bottom.tpl'}
</body>
</html>
{else}
<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash}">
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
{elseif and( is_set($mp.module_name), $mp.module_name|ne('') )}
    {* Other pages (search, user, a module of an extension) get a layout only from a mapping with a route target that
       names their module view: the path rules and the catch-all keep to content pages. *}
    {set $el_layout = fetch('explayouts','resolve_route_layout',hash())}
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
{set-block scope=global variable=exp_dynamic_parts}0{/set-block}
{if and(is_array($el_layout), $el_renderable_blocks|gt(0))}
{* Layout page: zones carry the layout blocks, including the header/footer
   tpl_block blocks from the shared layout, so the site chrome is part of the layout. *}
{def $el_path_attr = '[]'}
{if $node}{set $el_path_attr = concat('["', $node.path_array|implode('&quot;,&quot;'), '"]')}{/if}
{* The rendered layout is kept in a cache-block, per node, layout, page content (view parameters and
   paging included) and the visitor's roles and limitations; the siteaccess is part of every cache-block
   key, and a publish of content, of a layout or of a layout rule expires it. The visitor's own part, the
   user menu with the basket, is never kept: pagelayout/header.tpl writes a marker in its place while
   exp_dynamic_parts is 1, and the user menu is rendered fresh into it below, on every request. *}
{def $el_user = fetch( 'user', 'current_user' )}
{set-block scope=global variable=exp_dynamic_parts}1{/set-block}
{set-block variable=$el_layout_html}
{cache-block keys=array( 'explayouts-layout', $el_layout.id, $el_node_id, $module_result.content|md5, $el_user.role_id_list|implode( ',' ), $el_user.limited_assignment_value_list|implode( ',' ), $el_user.is_logged_in )}
<div id="page" role="main" data-path='{$el_path_attr}'>
    {include uri='design:explayouts/layout.tpl' layout=$el_layout module_result=$module_result}
</div>
{/cache-block}
{/set-block}
{set-block scope=global variable=exp_dynamic_parts}0{/set-block}
{set-block variable=$el_user_menu}{cache-block keys=array( 'user-menu', $el_user.contentobject_id, $el_user.role_id_list|implode( ',' ), $el_user.limited_assignment_value_list|implode( ',' ), $el_user.is_logged_in )}{include uri='design:pagelayout/header/user_menu.tpl'}{/cache-block}{/set-block}
{$el_layout_html|explode( '<!--exp-dynamic:user_menu-->' )|implode( $el_user_menu )}
{undef $el_path_attr $el_user $el_layout_html $el_user_menu}
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

{* The content license of the page as a visible notice, [SiteInfo] ShowLicenseNotice in menu.ini *}
{if ezini('SiteInfo','ShowLicenseNotice','menu.ini')|eq('enabled')}
<div class="container site-license-notice">
    {if $node}{include uri='design:xrowmetadata/license_notice.tpl' node=$node tag='small'}{else}{include uri='design:xrowmetadata/license_notice.tpl' tag='small'}{/if}
</div>
{/if}

{include uri='design:pagelayout/cookie_control.tpl'}
{include uri='design:pagelayout/script_bottom.tpl'}
</body>
</html>
{/if}
