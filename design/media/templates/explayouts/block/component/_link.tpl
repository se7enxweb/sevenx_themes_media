{* One enhanced-link action. Params: link (enhanced_link hash), btn_class *}
{if $link}
<div class="ngenhancedlink-field">
    {if $link.video}
        <a href="#" class="{$btn_class} js-modal-video-trigger" data-video-options="{$link.video_options|wash}">{$link.text|wash}</a>
    {elseif $link.form_modal}
        <a href="#" class="{$btn_class} js-form-modal-trigger" data-url="{concat('/info-collection/view-modal/', $link.form_object_id, '/', $link.form_node_id)|ezurl('no')}">{$link.text|wash}</a>
    {else}
        {def $ll_rel = false()}
        {if $link.rel_attribute|ne('')}{set $ll_rel = $link.rel_attribute}{/if}
        {def $ll_href = cond( and( $link.href|str_starts_with('/'), $link.href|str_starts_with('//')|not ), $link.href|ezurl('no'), $link.href|wash )}
        <a href="{$ll_href}" class="{$btn_class}"{if $link.target|ne('')} target="{$link.target}"{/if}{if $ll_rel} rel="{$ll_rel|wash}"{/if}>{$link.text|wash}</a>
    {/if}
</div>
{/if}