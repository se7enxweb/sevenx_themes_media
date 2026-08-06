{* EXTENDS design:pagelayout/variables.tpl *}
{include uri='design:pagelayout/variables.tpl'}

{* BLOCK pagelayout_content *}
<!DOCTYPE html>
<html lang="{$app.request.locale|ristring('_', '-')}">
<head>
    <meta charset="utf-8">

    {* BLOCK page_head_title *}
        {include uri='design:pagelayout/head/title.tpl'}
    {* ENDBLOCK page_head_title *}

    {* BLOCK page_head_meta *}
        {include uri='design:pagelayout/head/meta.tpl'}
    {* ENDBLOCK page_head_meta *}

    {* BLOCK page_head_link *}
        {include uri='design:pagelayout/head/link.tpl'}
    {* ENDBLOCK page_head_link *}

    {* BLOCK page_head_style *}
        {include uri='design:pagelayout/head/style.tpl'}
    {* ENDBLOCK page_head_style *}

    {* BLOCK page_head_script *}
        {include uri='design:pagelayout/head/script.tpl'}
    {* ENDBLOCK page_head_script *}

    {* BLOCK open_graph *}
        {include uri='design:parts/opengraph.tpl'}
    {* ENDBLOCK open_graph *}

    {include uri='design:parts/google_tag_manager_code_script.tpl'}

    {* BLOCK structuredData *}{* ENDBLOCK structuredData *}
</head>
<body>

{include uri='design:pagelayout/accessibility_links.tpl'}
{include uri='design:parts/google_tag_manager_code_noscript.tpl'}
{include uri='design:parts/facebook_api.tpl'}
{include uri='design:ngtoolbar.tpl'}

<div id="page"{if $page_css_class|ne('')} class="{$page_css_class}"{/if}{if and(is_object($location), is_set($location.pathArray), $location.pathArray|count|gt(0))} data-path='["{$location.pathArray|implode('","')}"]'{/if}>
    {* BLOCK layout *}
        {* BLOCK header *}
            {include uri='design:pagelayout/header.tpl'}
        {* ENDBLOCK header *}

        {* BLOCK breadcrumb *}
            {include uri='design:pagelayout/breadcrumbs.tpl'}
        {* ENDBLOCK breadcrumb *}

        <div id="main">
            {* BLOCK content *}{* ENDBLOCK content *}
        </div>

        {* BLOCK footer *}
            {include uri='design:pagelayout/footer.tpl'}
        {* ENDBLOCK footer *}
    {* ENDBLOCK layout *}

    {include uri='design:nglayouts/preview/body.tpl'}
</div>

{* BLOCK page_footer_script *}
    {include uri='design:pagelayout/script_bottom.tpl'}
{* ENDBLOCK page_footer_script *}

{include uri='design:pagelayout/cookie_control.tpl'}
</body>
</html>
{* ENDBLOCK pagelayout_content *}