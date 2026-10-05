{* A notice of the notification pages (media design): $notice is hash( 'type', success|warning|error|info, 'text', ... )
   or false. Shown once, as a status message that a screen reader announces. *}
{if and( is_set( $notice ), $notice )}
<div class="nf-notice nf-notice-{$notice.type|wash}" role="{if $notice.type|eq( 'error' )}alert{else}status{/if}">
    <p>{$notice.text|wash}</p>
</div>
{/if}
