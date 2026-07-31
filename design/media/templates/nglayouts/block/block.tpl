

{* IMPORT macros.tpl AS toolbar_macros *}

{def $css_id = first_set($css_id, parameter(block, 'css_id'))}
{def $set_container = parameter(block, 'set_container')}
{def $container_size = parameter(block, 'set_container:size')}
{def $is_preview = get($app.request.attributes, 'nglayouts_is_preview_request')}

{def $use_whitespace = (parameter(block, 'vertical_whitespace:enabled')|eq(true))}
{def $whitespace_top = parameter(block, 'vertical_whitespace:top')}
{def $whitespace_bottom = parameter(block, 'vertical_whitespace:bottom')}

{def $bg_image = dynamicParameter(block, 'background_image:image_content')}
{def $use_bg_image = and(hasParameter(block, 'background_image:enabled'), (parameter(block, 'background_image:enabled')|eq(true)))}
{def $use_bg_image = and(and($use_bg_image, not(($bg_image|eq(null)))), is_set($bg_image.fields.image))}

{def $bg_color = cond(hasParameter(block, 'background_color:color'), parameter(block, 'background_color:color'), null)}
{def $use_bg_color = and(hasParameter(block, 'background_color:enabled'), (parameter(block, 'background_color:enabled')|eq(true)))}
{def $use_bg_color = and($use_bg_color, not(($bg_color|count()|eq(0))))}

{def $css_classes = array('ngl-block', concat('ngl-', block.definition.identifier), concat('ngl-vt-', block.viewType), first_set($css_class, parameter(block, 'css_class')))}

{if $use_whitespace}
    {def $css_classes = $css_classes|merge(array(concat('whitespace-top-', $whitespace_top)))}
    {def $css_classes = $css_classes|merge(array(concat('whitespace-bottom-', $whitespace_bottom)))}
{/if}

{if $use_bg_image}
    {def $css_classes = $css_classes|merge(array('with-bg-image'))}
{/if}

{if $use_bg_color}
    {def $css_classes = $css_classes|merge(array(concat('bg-color-', $bg_color)))}
{/if}

{if not(is_set($show_empty_wrapper))}
    {def $show_empty_wrapper = false}
{/if}

{def $block_content = cond(is_set($twig_block_content), $twig_block_content, '')|trim}

{if $is_preview}
    {def $view_type_name = block.viewType}

    {if hasViewType(block.definition, $view_type_name, block)}
        {def $view_type_name = viewType(block.definition, $view_type_name, block)}
    {/if}

    <ngl-block
        blockId="{$block.id}"
        blockLocale="{$block.locale}"
        viewTypeName="{$view_type_name}"
        {if $block_content|count()|eq(0)}isEmpty{/if}
    >
        <div class="ngl-slotted-block">
{/if}

{if or(not(($block_content|count()|eq(0))), $show_empty_wrapper)}
    <div {component_params($toolbar_macros, block)}
        class="{$css_classes|implode(' ')}"
        {if not(($css_id|count()|eq(0)))}id="{$css_id}"{/if}
        {if $use_bg_image}
            {def $image_alias = ng_image_alias($bg_image.fields.image, 'i1920')}
            {if $image_alias}style="background-image:url('{asset($image_alias.uri)}')"{/if}
        {/if}
    >
        {if $set_container}<div class="container{if not(($container_size|count()|eq(0)))} container-{$container_size}{/if}">{/if}

        {$block_content}

        {if $set_container}</div>{/if}
    </div>
{/if}

{if $is_preview}
        </div>
    </ngl-block>
{/if}