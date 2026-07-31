

{* MACRO image($content, $field_name, $alias_name, $use_lazy_load) *}
    {* IMPORT content/macros/content_fields.tpl AS content_fields *}

    {def $field_name = first_set($field_name, 'image')}
    {def $alias_name = first_set($alias_name, 'i1320')}

    {if and(hasField($content, $field_name), not($content.fields[$field_name]['empty']))}
        {ng_render_field($content.fields[$field_name], hash('parameters', hash('alias', $alias_name, 'lazy_loading', first_set($use_lazy_load, false))))}
    {/if}
{* ENDMACRO *}