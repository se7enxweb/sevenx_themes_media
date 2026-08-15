{* Full-view page image (nexus full-view left twig block #0). i1320 alias. *}
{def $fi_node = false()}
{if and(is_set($module_result.content_info.node_id), $module_result.content_info.node_id|gt(0))}
    {set $fi_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
{/if}
{if $fi_node}
{def $fi_url = ''}
{def $fi_alt = $fi_node.name}
{def $fi_attr = false()}
{if and(is_set($fi_node.data_map.image), $fi_node.data_map.image.has_content)}
    {set $fi_attr = $fi_node.data_map.image}
{elseif and(is_set($fi_node.data_map.teaser_image), $fi_node.data_map.teaser_image.has_content)}
    {set $fi_attr = $fi_node.data_map.teaser_image}
{/if}
{if $fi_attr}
    {def $fi_obj = $fi_attr.content}
    {if is_set($fi_obj['i1320'])}{set $fi_url = $fi_obj['i1320'].url}
    {elseif is_set($fi_obj['large'])}{set $fi_url = $fi_obj['large'].url}
    {elseif is_set($fi_obj['original'])}{set $fi_url = $fi_obj['original'].url}{/if}
    {set $fi_alt = $fi_obj.alternative_text|first_set($fi_alt)}
    {undef $fi_obj}
{/if}
{if $fi_url|ne('')}
<div class="full-page-image">
    <div>
        <figure class="image-wrapper">
        <img
            src={$fi_url|ezroot}
            loading="lazy" alt="{$fi_alt|wash}"
        />
        </figure>
    </div>
</div>
{/if}
{undef $fi_url $fi_alt}
{/if}
{undef $fi_node}
