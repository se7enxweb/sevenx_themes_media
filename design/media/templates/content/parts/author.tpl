{if and(hasField($content, 'authors'), not($content.fields.authors['empty']))}
    {foreach fieldRelations($content, 'authors') as $author}
        {def $author_rel = ''}
        {if and(is_set($view_type), $view_type|eq('full'))}
            {set $author_rel = ' rel="author" itemprop="author"'}
        {/if}
        <a class="author" href="{ibexa_path($author)}"{$author_rel}>{$author.name}</a>
        {undef $author_rel}
    {/foreach}
{/if}
