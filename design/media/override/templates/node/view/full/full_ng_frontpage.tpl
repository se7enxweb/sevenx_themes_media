{def $view_type = 'full'}
{explblock name='content'}
<div class="view-type view-type-{$view_type} ng-frontpage">
    {explblock name='article_header'}
    <div class="container">
        <h1 class="full-page-title">{$node.object.data_map.title.content|wash}</h1>
    </div>
    {/explblock}
    {if and(is_set($node.object.data_map['body']), $node.object.data_map['body'].has_content)}
        {explblock name='article_body'}
        <div class="container">
            <div class="full-page-content">
                {attribute_view_gui attribute=$node.object.data_map['body']}
            </div>
        </div>
        {/explblock}
    {/if}
</div>
{/explblock}
