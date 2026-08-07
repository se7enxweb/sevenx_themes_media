


{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-htmlbox vl1">
    <header class="article-header">
        {$content.fields.html_code.value.text}
    </header>
</article>