{* EXTENDS design:@nglayouts/block/block.tpl *}

{* IMPORT nglayouts/parts/macros.tpl AS macros *}

{def $tag = first_set(parameter(block, 'tag'), 'h1')}
{def $link = parameter(block, 'link')}

{def $icon_css_class = cond(hasParameter(block, 'title_icon:css_class'), parameter(block, 'title_icon:css_class'), null)}
{def $use_icon = and(hasParameter(block, 'title_icon:enabled'), (parameter(block, 'title_icon:enabled')|eq(true)))}
{def $use_icon = and($use_icon, not(($icon_css_class|count()|eq(0))))}

{* BLOCK content *}
    
    {def $title = inline_template($macros, parameter(block, 'title'), $_context)}

    <{$tag} class="title">
        {if $use_icon}
            <div class="title-icon"><i class="{$icon_css_class}"></i></div>
        {/if}

        {if and(parameter(block, 'use_link'), not($link.isEmpty))}
            {nglayouts_render_parameter($link, hash('content', $title))}
        {else}
            {$title}
        {/if}
    </{$tag}>
{* ENDBLOCK content *}