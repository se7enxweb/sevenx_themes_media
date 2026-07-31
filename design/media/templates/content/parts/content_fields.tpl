

{* EXTENDS design:@IbexaCore/content_fields.tpl *}

{* BLOCK ngenhancedlink_field *}
{* FILTER $None|spaceless *}
    {if and(not(ibexa_field_is_empty($content, $field)), $parameters.available)}
        {def $css_class = first_set($parameters.css_class, '')}
        <div {$twig_block_field_attributes}>
            {if $field.value.isTypeInternal}
                {def $label = cond(and(and(is_set($fieldSettings.enableLabelInternal), $fieldSettings.enableLabelInternal), $field.value.label), $field.value.label, ngsite_content_name($field.value.reference))}
                {def $suffix = first_set($field.value.suffix, '')}
                {if $field.value.isTargetModal}
                    {ng_view_content_embedded('modal_trigger', hash('contentId', $field.value.reference, 'params', hash('label', $label, 'suffix', $suffix, 'refererLocationId', get($app.request.attributes, 'locationId'), 'css_class', $css_class)))}
                {elseif $field.value.isTargetEmbed}
                    {ng_view_content_embedded('link_embed', hash('contentId', $field.value.reference, 'params', hash('label', $label, 'suffix', $suffix, 'refererLocationId', get($app.request.attributes, 'locationId'))))}
                {else}
                    {if ng_enhancedlink_has_location($field.value.reference)}
                        {def $href = concat(path('ibexa.url.alias', hash('contentId', $field.value.reference)), $suffix)}
                        <a href="{$href}"{if not(($css_class|count()|eq(0)))} class="{$css_class}"{/if}{if $field.value.isTargetLinkInNewTab} target="_blank"{/if}>{$label}</a>
                    {/if}
                {/if}
            {elseif $field.value.isTypeExternal}
                {def $label = cond(and(and(is_set($fieldSettings.enableLabelExternal), $fieldSettings.enableLabelExternal), $field.value.label), $field.value.label, $field.value.reference)}

                {if $field.value.isTargetModal}
                    <div>{$label}</div>
                {elseif $field.value.isTargetEmbed}
                    <div>{$label}</div>
                {else}
                    <a href="{$field.value.reference}" {if not(($css_class|count()|eq(0)))} class="{$css_class}"{/if}{if $field.value.isTargetLinkInNewTab} target="_blank"{/if}>{$label}</a>
                {/if}
            {/if}
        </div>
    {/if}
{* ENDFILTER *}
{* ENDBLOCK ngenhancedlink_field *}

{* BLOCK ibexa_image_field *}
{* FILTER $None|spaceless *}
    {if not(ibexa_field_is_empty($content, $field))}
        {def $link_href = first_set($parameters.link_href, '')}
        {def $link_target = first_set($parameters.link_target, '')}
        {def $link_title = first_set($parameters.alt_text, cond($field.value.alternativeText, $field.value.alternativeText, concat('ngsite.read_more_about'|trans, ' ', $content.name)))}
        {def $use_image_size = first_set($parameters.use_image_size, false)}
        {def $image_alias = ibexa_image_alias($field, $versionInfo, first_set($parameters.alias, 'original'))}
        {def $alt_text = first_set($parameters.alt_text, cond($field.value.alternativeText, $field.value.alternativeText, ''))}
        {def $lazy_loading = getParameter($ibexa.configResolver, 'lazy_loading.enabled', 'ngsite')}
        {if is_set($parameters.lazy_loading)}
            {def $lazy_loading = $parameters.lazy_loading}
        {/if}

        {if not(($link_href|count()|eq(0)))}
            <a href="{$link_href}"
                {if not(($link_target|count()|eq(0)))} target="{$link_target}" {if $link_target|eq('_blank')}rel="nofollow noopener noreferrer"{/if} {/if}
                {if not((first_set($parameters.link_id, '')|count()|eq(0)))} id="{$parameters.link_id}" {/if}
                {if not((first_set($parameters.link_class, '')|count()|eq(0)))} class="{$parameters.link_class}" {/if}
                {if not((first_set($parameters.link_title, '')|count()|eq(0)))} title="{$parameters.link_title}" {/if}
                title="{$link_title}"
            >
        {elseif not((first_set($parameters.ezlink, hash())|count()|eq(0)))}
            <a
                href="{$parameters.ezlink.href}"
                {if is_set($parameters.ezlink.title)} title="{$parameters.ezlink.title|wash('html_attr')}"{/if}
                {if is_set($parameters.ezlink.target)} target="{$parameters.ezlink.target|wash('html_attr')}"{/if}
            >
        {/if}

        <img
            src="{if $image_alias}{asset($image_alias.uri)}{else}//:0{/if}"
            {if $lazy_loading}loading="lazy"{/if}
            {if not((first_set($parameters.image_class, '')|count()|eq(0)))} class="{$parameters.image_class}" {/if}
            {if and($use_image_size, not((first_set($image_alias.width, '')|count()|eq(0))))} width="{$image_alias.width}" {/if}
            {if and($use_image_size, not((first_set($image_alias.height, '')|count()|eq(0))))} height="{$image_alias.height}" {/if}
            alt="{$alt_text}"
            {$twig_block_field_attributes} />

        {if or(not(($link_href|count()|eq(0))), not((first_set($parameters.ezlink, hash())|count()|eq(0))))}
            </a>
        {/if}

    {elseif first_set($parameters.force_tag, false)}
        <img src="//:0" alt="" />
    {/if}
{* ENDFILTER *}
{* ENDBLOCK ibexa_image_field *}

{* BLOCK ibexa_gmap_location_field *}
{* FILTER $None|spaceless *}
    {def $map_height = first_set($map_height, 500)}
    {def $zoom = first_set($zoom, false)}
    {def $map_type = first_set($map_type, false)}

    {def $latitude = first_set($field.value.latitude, false)}
    {def $longitude = first_set($field.value.longitude, false)}

    {include uri='design:parts/google_maps.tpl'}
{* ENDFILTER *}
{* ENDBLOCK ibexa_gmap_location_field *}

{* BLOCK ibexa_binaryfile_field *}
{* FILTER $None|spaceless *}
    {if not(ibexa_field_is_empty($content, $field))}
        <a href="{path('ngsite_download', hash('contentId', $contentInfo.id, 'fieldId', $field.id))}" {$twig_block_field_attributes}>
            {$field.value.fileName}
        </a>&nbsp;({$field.value.fileSize|ibexa_file_size(1)})
    {/if}
{* ENDFILTER *}
{* ENDBLOCK ibexa_binaryfile_field *}