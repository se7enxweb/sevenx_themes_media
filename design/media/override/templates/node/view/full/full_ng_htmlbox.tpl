{explblock name='content'}
<div class="view-type view-type-full ng-htmlbox">
    {explblock name='article_header'}
    <h1 class="full-page-title">{$node.name|wash}</h1>
    {/explblock}
    {explblock name='article_body'}
    <div class="attribute-html-code">
        {$node.object.data_map.html_code.data_text}
    </div>
    {/explblock}
</div>
{/explblock}
