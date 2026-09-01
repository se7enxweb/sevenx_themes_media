{* Lead action: embedded form or modal trigger button. Param: cmp *}
{def $la_link = false()}
{if is_set($cmp.data_map.link_1)}{set $la_link = enhanced_link($cmp.data_map.link_1)}{/if}
{if $la_link}
    {if $la_link.form_embed}
    <div class="embedded-form">
        {include uri='design:explayouts/block/component/_lead_form.tpl' form_object_id=$la_link.form_object_id}
    </div>
    {elseif $la_link.form_modal}
    <div class="actions">
        <div         class="ngenhancedlink-field" ><a href="#" class="btn btn-primary js-form-modal-trigger" data-url="{concat('/info-collection/view-modal/', $la_link.form_object_id, '/', $la_link.form_node_id)|ezurl('no')}">{$la_link.text|wash}</a></div>
    </div>
    {else}
    <div class="actions">
        {include uri='design:explayouts/block/component/_link.tpl' link=$la_link btn_class='btn btn-primary'}
    </div>
    {/if}
{/if}
{undef $la_link}
