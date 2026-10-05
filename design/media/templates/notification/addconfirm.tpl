{* Asks before a notification is added or removed (media design): opening /notification/addtonotification/<node>
   changes nothing; the buttons are a POST that carries the form token. Variables: node, node_id, already_exists,
   redirect_uri. *}
{include uri='design:notification/parts/page_start.tpl'
         title='Add to my notifications'|i18n( 'design/admin/notification/addconfirm' )
         intro=false() wide=false()}
    <form class="nf-card" method="post" action={concat( 'notification/addtonotification/', $node_id )|ezurl}>
        <input type="hidden" name="RedirectURI" value="{first_set( $redirect_uri, '/' )|wash}" />
{if $already_exists}
        <h2>{'You already follow this item'|i18n( 'design/admin/notification/addconfirm' )}</h2>
        <p class="nf-lead"><span class="nf-box-node">{$node.name|wash}</span> <span class="nf-badge">{$node.class_name|wash}</span></p>
        <p class="nf-lead">{'You get an e-mail when something is published below it. You can stop that here.'|i18n( 'design/admin/notification/addconfirm' )}</p>
        <div class="nf-actions">
            <input class="nf-btn danger" type="submit" name="ConfirmRemoveNotification" value="{'Stop notifications for this item'|i18n( 'design/admin/notification/addconfirm' )}" />
            <input class="nf-btn outline" type="submit" name="CancelNotification" value="{'Back'|i18n( 'design/admin/notification/addconfirm' )}" />
        </div>
{else}
        <h2>{'Notify me about updates'|i18n( 'design/admin/notification/addconfirm' )}</h2>
        <p class="nf-lead"><span class="nf-box-node">{$node.name|wash}</span> <span class="nf-badge">{$node.class_name|wash}</span></p>
        <p class="nf-lead">{'You get an e-mail when something new is published below this item, as long as you may read it. You can change this under My notification settings.'|i18n( 'design/admin/notification/addconfirm' )}</p>
        <div class="nf-actions">
            <input class="nf-btn primary" type="submit" name="ConfirmAddNotification" value="{'Notify me'|i18n( 'design/admin/notification/addconfirm' )}" />
            <input class="nf-btn outline" type="submit" name="CancelNotification" value="{'Cancel'|i18n( 'design/admin/notification/addconfirm' )}" />
        </div>
{/if}
    </form>
    <p class="nf-hint"><a href={'notification/settings'|ezurl}>{'My notification settings'|i18n( 'design/admin/notification/addingresult' )}</a></p>
{include uri='design:notification/parts/page_end.tpl'}
