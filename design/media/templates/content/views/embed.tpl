{* Generic embed of any class: its image when it has one, the name linked to it and its intro.
   A class with content/views/embed/<class>.tpl is drawn by that file instead. *}
{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
<div class="view-type view-type-embed {$node.class_identifier|ristring('_', '-')}">
    {image($content_fields, $content, $location, 'i320')}
    <h3><a href="{exp_path($location)}">{title($content_fields, $content)}</a></h3>
    {if first_set($with_intro, true())}
        {intro($content_fields, $content)}
    {/if}
</div>
{undef $content_fields}
