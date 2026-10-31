{* One consent record in the media design, as an event of Security activity (acc-event in stylesheets/account.css):
   what changed and in which category, when, where, and the text the person saw, quoted. The edge is green for a
   consent given, yellow for one withdrawn or waiting, red for a block or an erasure.
   Used by parts/preferences.tpl (the consent history) and admin/consent.tpl (the consent log).
   Variables: row (Exponential\Service\MailPreferencesPage::logRow(); in the consent log with who and actor),
   log (true in the consent log: the person and the IP address are shown too). *}
<li class="acc-event{if or( $row.action|eq( 'on' ), $row.action|eq( 'confirm' ), $row.action|eq( 'master_on' ), $row.action|eq( 'unsuppress' ) )} is-ok{elseif or( $row.action|eq( 'off' ), $row.action|eq( 'master_off' ), $row.action|eq( 'pending' ) )} is-warn{elseif or( $row.action|eq( 'suppress' ), $row.action|eq( 'erase' ) )} is-bad{/if}">
    <div class="acc-event-head">
        <p class="mp-event-what"><strong>{$row.change|wash}</strong> &middot; {$row.category|wash}</p>
        <span class="acc-when">{if $row.time}{$row.time|l10n( 'shortdatetime' )}{/if}</span>
    </div>
    <p class="acc-event-meta">
{if $log}
        <span>{'Person'|i18n( 'design/admin/mailpreferences' )}: {if $row.user_id}<a href={concat( 'mailpreferences/admin/user/', $row.user_id )|ezurl}>{$row.who|wash}</a>{else}{$row.who|wash}{/if}{if $row.actor} ({'by %actor'|i18n( 'design/admin/mailpreferences',, hash( '%actor', $row.actor ) )|wash}){/if}</span>
{/if}
        <span>{'Where'|i18n( 'design/standard/mailpreferences' )}: {$row.source_name|wash}</span>
{if and( $log, $row.ip )}
        <span>{'IP address'|i18n( 'design/admin/mailpreferences' )}: <code>{$row.ip|wash}</code></span>
{/if}
    </p>
{if $row.wording|ne( '' )}
    <blockquote class="mp-event-wording"><span class="acc-sr-only">{'Text shown'|i18n( 'design/standard/mailpreferences' )}: </span>{$row.wording|wash}</blockquote>
{/if}
</li>
