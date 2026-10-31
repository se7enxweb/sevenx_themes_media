{* mailpreferences/admin/status in the media design: the state of the e-mail preferences for administrators, drawn
   with the account pages' furniture (stylesheets/account.css) instead of the kernel's mp-stats and mp-problems, which
   the media design does not load: the problems as account notices, the figures as the tiles of Security activity,
   the sender details and the settings in account cards, the settings as the account facts list.
   Variables: problems (hash( level: error|warning|info, text )), stats (hash( label, value, level: ''|bad )),
   facts (hash( label, value )), notice (or false), links (hash( url, text ): the related pages),
   sender (hash( name, address, name_source, name_setting, site_name ): the form "Sender details"). *}
{include uri='design:mailpreferences/parts/page_start.tpl'
         title='E-mail preferences: status'|i18n( 'design/admin/mailpreferences' )
         intro='Every e-mail the system sends passes the mail gate: it checks the main switch, the category and the suppression list of the recipient, and adds the footer and the unsubscribe links to optional e-mail. This page shows whether that works and what it did.'|i18n( 'design/admin/mailpreferences' )
         crumb=false() wide=true() admin_tab='status'}

{include uri='design:mailpreferences/parts/notice.tpl' notice=first_set( $notice, false() )}

{if $problems|count|gt( 0 )}
    <ul class="acc-problems">
{foreach $problems as $problem}
        <li class="acc-notice {$problem.level|wash}"><p><b>{if $problem.level|eq( 'error' )}{'Problem'|i18n( 'design/admin/mailpreferences' )}{elseif $problem.level|eq( 'warning' )}{'Attention'|i18n( 'design/admin/mailpreferences' )}{else}{'Note'|i18n( 'design/admin/mailpreferences' )}{/if}:</b> {$problem.text|wash}</p></li>
{/foreach}
    </ul>
{else}
    <div class="acc-notice success" role="status"><p>{'Nothing looks wrong.'|i18n( 'design/admin/mailpreferences' )}</p></div>
{/if}

{if $stats|count|gt( 0 )}
    <ul class="acc-figures">
{foreach $stats as $stat}
        <li class="acc-figure{if $stat.level|eq( 'bad' )} is-bad{/if}"><strong>{$stat.value|wash}</strong> <span>{$stat.label|wash}</span></li>
{/foreach}
    </ul>
{/if}

{if is_set( $sender )}
    <section class="mp-card" id="mp-sender" aria-labelledby="mp-sender-title">
        <h2 id="mp-sender-title">{'Sender details'|i18n( 'design/admin/mailpreferences' )}</h2>
        <p class="mp-hint">{'Every optional e-mail names who sends it and their postal address, as the law requires. Without an organization name the site name is used.'|i18n( 'design/admin/mailpreferences' )}</p>
        <form method="post" action={'mailpreferences/admin/status'|ezurl}>
            <div class="mp-field">
                <label for="mp-sender-name">{'Organization name'|i18n( 'design/admin/mailpreferences' )}</label>
                <input type="text" id="mp-sender-name" name="OrganisationName" value="{$sender.name_setting|wash}" placeholder="{$sender.site_name|wash}" maxlength="255" />
            </div>
            <div class="mp-field">
                <label for="mp-sender-address">{'Postal address'|i18n( 'design/admin/mailpreferences' )}</label>
                <textarea id="mp-sender-address" name="OrganisationAddress" rows="4" cols="40">{$sender.address|wash}</textarea>
            </div>
            <div class="mp-actions"><input class="mp-btn primary" type="submit" name="StoreSenderDetailsButton" value="{'Save the sender details'|i18n( 'design/admin/mailpreferences' )}" /></div>
        </form>
    </section>
{/if}

{if $facts|count|gt( 0 )}
    <section class="mp-card" aria-labelledby="mp-facts-title">
        <h2 id="mp-facts-title">{'Settings in use'|i18n( 'design/admin/mailpreferences' )}</h2>
        <dl class="acc-facts">
{foreach $facts as $fact}
            <dt>{$fact.label|wash}</dt><dd>{$fact.value|wash}</dd>
{/foreach}
        </dl>
        <p class="mp-hint">{'The settings are in mailpreferences.ini; the organization, the postal address, the bounce mailbox and the site secret belong in a settings override.'|i18n( 'design/admin/mailpreferences' )}</p>
    </section>
{/if}

{if $links|count|gt( 0 )}
    <section class="mp-card" aria-labelledby="mp-links-title">
        <h2 id="mp-links-title">{'Related pages'|i18n( 'design/admin/mailpreferences' )}</h2>
        <div class="mp-actions">
{foreach $links as $link}
            <a class="mp-btn small outline" href={$link.url|ezurl}>{$link.text|wash}</a>
{/foreach}
        </div>
    </section>
{/if}

{include uri='design:mailpreferences/parts/page_end.tpl'}
