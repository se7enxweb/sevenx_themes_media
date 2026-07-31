<!doctype html>
<html lang="{$app.request.locale|ristring('_', '-')}">
<head>
    <link rel="icon" type="image/x-icon" href="{asset('bundles/ibexaadminui/img/favicon.ico')}" />
    <meta charset="utf-8">

    {* BLOCK meta *}{* ENDBLOCK meta *}

    {if and(is_set($content), not(is_set($title)))}
        {def $title = ibexa_content_name($content)}
    {/if}
    <title>{first_set($title, 'Home')}</title>
    <meta name="generator" content="Exponential Platform DXP"/>
    {if and(is_set($content), $content.contentInfo.mainLocationId)}
        <link rel="canonical" href="{ibexa_path($content)}" />
    {/if}

    {* BLOCK stylesheets *}
        {encore_entry_link_tags('app')}
    {* ENDBLOCK stylesheets *}
</head>
<body>
{* BLOCK content *}
{* ENDBLOCK content *}

{* BLOCK javascripts *}
    {encore_entry_script_tags('app')}
{* ENDBLOCK javascripts *}
</body>
</html>