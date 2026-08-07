


{* IMPORT macros.tpl AS toolbar_macros *}

<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} file vl4">
    <div class="article-content">
        <header class="article-header">
            <h2 class="title">
                <a href="{ibexa_path($location)}">
                    {$content.fields.name.value.text}
                </a>
            </h2>
        </header>
    </div>
</article>