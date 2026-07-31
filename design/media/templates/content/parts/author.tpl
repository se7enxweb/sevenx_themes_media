

{if and(hasField($content, 'authors'), not($content.fields.authors['empty']))}
    {foreach fieldRelations($content, 'authors') as $author}
        <a class="author" href="{ibexa_path($author)}">{$author.name}</a>
    {/foreach}
{/if}