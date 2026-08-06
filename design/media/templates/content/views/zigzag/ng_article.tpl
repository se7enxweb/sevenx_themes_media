


{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} ng-article vl9">
    {image($content_fields, $content, $location, 'i770')}

    <div class="article-content">
        <header class="article-header">
            <h3 class="title"><a href="{ibexa_path($location)}">{title($content_fields, $content)}</a></h3>
            <div class="info">
                {include uri='design:content/parts/author.tpl'}
            </div>
        </header>
        <div class="short">
            {intro($content_fields, $content)}
            <a class="btn btn-default" href="{ibexa_path($location)}">Find out more</a>
        </div>
    </div>
</article>