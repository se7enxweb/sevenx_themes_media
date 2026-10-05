{* After "Stop notifications for this item" (media design). Variables: node_id, removed, redirect_uri (or
   redirect_url). *}
{def $node = fetch( 'content', 'node', hash( 'node_id', $node_id ) )}
{include uri='design:notification/parts/page_start.tpl'
         title='Notifications'|i18n( 'design/admin/notification/addingresult' )
         intro=false() wide=false()}
    <div class="nf-notice nf-notice-{if $removed}success{else}info{/if}" role="status"><p>
{if $removed}
        {'You no longer get notifications for node <%node_name>.'|i18n( 'design/admin/notification/addingresult',, hash( '%node_name', $node.name ) )|wash}
{else}
        {'You did not follow node <%node_name>.'|i18n( 'design/admin/notification/addingresult',, hash( '%node_name', $node.name ) )|wash}
{/if}
    </p></div>
    <div class="nf-actions">
        <a class="nf-btn primary" href={first_set( $redirect_uri, $redirect_url, '/' )|ezurl}>{'OK'|i18n( 'design/admin/notification/addingresult' )}</a>
        <a class="nf-btn outline" href={'notification/settings'|ezurl}>{'My notification settings'|i18n( 'design/admin/notification/addingresult' )}</a>
    </div>
{include uri='design:notification/parts/page_end.tpl'}
{undef $node}
