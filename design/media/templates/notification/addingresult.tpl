{* After "Notify me" (media design): the item was added, or was already followed. Variables: node_id,
   already_exists, redirect_uri (or redirect_url). *}
{def $node = fetch( 'content', 'node', hash( 'node_id', $node_id ) )}
{include uri='design:notification/parts/page_start.tpl'
         title='Add to my notifications'|i18n( 'design/admin/notification/addingresult' )
         intro=false() wide=false()}
    <div class="nf-notice nf-notice-{if $already_exists}info{else}success{/if}" role="status"><p>
{if $already_exists}
        {'Notification for node <%node_name> already exists.'|i18n( 'design/admin/notification/addingresult',, hash( '%node_name', $node.name ) )|wash}
{else}
        {'Notification for node <%node_name> was added successfully.'|i18n( 'design/admin/notification/addingresult',, hash( '%node_name', $node.name ) )|wash}
{/if}
    </p></div>
    <div class="nf-actions">
        <a class="nf-btn primary" href={first_set( $redirect_uri, $redirect_url, '/' )|ezurl}>{'OK'|i18n( 'design/admin/notification/addingresult' )}</a>
        <a class="nf-btn outline" href={'notification/settings'|ezurl}>{'My notification settings'|i18n( 'design/admin/notification/addingresult' )}</a>
    </div>
{include uri='design:notification/parts/page_end.tpl'}
{undef $node}
