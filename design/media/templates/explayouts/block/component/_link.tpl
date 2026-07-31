{* One enhanced-link action. Params: link (enhanced_link hash), btn_class *}
{if $link}
<div         class="ngenhancedlink-field" >{if $link.video}<a href="#" class="{$btn_class} js-modal-video-trigger" data-video-options="{ldelim}&quot;videoTitle&quot;:&quot;{$link.video_title|wash}&quot;{rdelim}">{$link.text|wash}</a>{else}<a href="{$link.href|wash}" {if $link.target|ne('')} {/if}class="{$btn_class}"{if $link.target|ne('')} target="{$link.target}"{/if}>{$link.text|wash}</a>{/if}</div>
{/if}
