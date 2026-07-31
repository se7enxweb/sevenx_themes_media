{* Topic landing header (nexus topic twig block): centered h1 + full intro. *}
{def $th_node = false()}
{if and(is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {set $th_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
{/if}
{if $th_node}
<header class="full-page-header no-breadcrumbs text-center">
    <div class="container">
        <h1 class="full-page-title"><span class="ibexa_string-field">{$th_node.name|wash}</span></h1>
        {if and(is_set($th_node.data_map.full_intro), $th_node.data_map.full_intro.has_content)}
            <div class="full-page-header-text">
                <div class="row">
                    <div class="container container-narrow">
                        <div class="ibexa_richtext-field">{attribute_view_gui attribute=$th_node.data_map.full_intro}</div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
</header>
{/if}
{undef $th_node}
