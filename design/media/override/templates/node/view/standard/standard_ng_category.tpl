


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-category vl1">
    <header class="article-header">
        <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
    </header>

    {if first_set($with_intro, false)}
        {intro($content_fields, $content)}
    {/if}
</article>