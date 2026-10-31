{* mailpreferences/admin/consent in the media design: the consent log, every change of every person, with a CSV
   export of what the filters select. The filter is an account card with the fields in a grid; the records are the
   timeline of the consent history (parts/consent_event.tpl, with the person and the IP address), 50 to a page.
   Replaces the kernel's template, whose seven-column table and mp-filters the media design does not draw.
   Variables: rows (hash( time, who, user_id, category, action, source, wording, ip, actor )), total, offset, limit,
   filters (hash( person, category, source, from, to )), category_names (hash( identifier => name )),
   source_names (hash( source => label )), export_uri, query, page_uri, notice. *}
{include uri='design:mailpreferences/parts/page_start.tpl'
         title='E-mail preferences: consent log'|i18n( 'design/admin/mailpreferences' )
         intro='Every change of an e-mail preference: when, by whom, where, the exact text the person saw and the address the request came from. The log is kept for the life of the account and the retention time after it; a removed account leaves an anonymised record that proves the withdrawal.'|i18n( 'design/admin/mailpreferences' )
         crumb=false() wide=true() admin_tab='consent'}

{include uri='design:mailpreferences/parts/notice.tpl' notice=first_set( $notice, false() )}

<section class="mp-card" aria-labelledby="mp-log-filter-title">
    <h2 id="mp-log-filter-title">{'Filter'|i18n( 'design/admin/mailpreferences' )}</h2>
    <form method="post" action={'mailpreferences/admin/consent'|ezurl}>
        <div class="mp-filters">
            <div class="mp-field">
                <label for="mp-log-person">{'E-mail address or user ID'|i18n( 'design/admin/mailpreferences' )}</label>
                <input type="text" id="mp-log-person" name="person" value="{$filters.person|wash}" />
            </div>
            <div class="mp-field">
                <label for="mp-log-category">{'Category'|i18n( 'design/admin/mailpreferences' )}</label>
                <select id="mp-log-category" name="category">
                    <option value="">{'All'|i18n( 'design/admin/mailpreferences' )}</option>
{foreach $category_names as $identifier => $name}
                    <option value="{$identifier|wash}"{if $filters.category|eq( $identifier )} selected="selected"{/if}>{$name|wash}</option>
{/foreach}
                </select>
            </div>
            <div class="mp-field">
                <label for="mp-log-source">{'Where'|i18n( 'design/admin/mailpreferences' )}</label>
                <select id="mp-log-source" name="source">
                    <option value="">{'All'|i18n( 'design/admin/mailpreferences' )}</option>
{foreach $source_names as $source => $label}
                    <option value="{$source|wash}"{if $filters.source|eq( $source )} selected="selected"{/if}>{$label|wash}</option>
{/foreach}
                </select>
            </div>
            <div class="mp-field">
                <label for="mp-log-from">{'From'|i18n( 'design/admin/mailpreferences' )}</label>
                <input type="date" id="mp-log-from" name="from" value="{$filters.from|wash}" />
            </div>
            <div class="mp-field">
                <label for="mp-log-to">{'To'|i18n( 'design/admin/mailpreferences' )}</label>
                <input type="date" id="mp-log-to" name="to" value="{$filters.to|wash}" />
            </div>
        </div>
        <div class="mp-actions">
            <input class="mp-btn primary" type="submit" value="{'Show'|i18n( 'design/admin/mailpreferences' )}" />
            <a class="mp-btn outline" href={'mailpreferences/admin/consent'|ezurl}>{'Clear'|i18n( 'design/admin/mailpreferences' )}</a>
{if $export_uri}
            <a class="mp-btn outline" href={$export_uri|ezurl} download="download">{'Export as CSV'|i18n( 'design/admin/mailpreferences' )}</a>
{/if}
        </div>
    </form>
</section>

<section class="mp-card" aria-labelledby="mp-log-records-title">
    <h2 id="mp-log-records-title">{'Records'|i18n( 'design/admin/mailpreferences' )} <span class="acc-count">{$total}</span></h2>
{if $rows|count|eq( 0 )}
    <p class="mp-hint">{'No records match.'|i18n( 'design/admin/mailpreferences' )}</p>
{else}
    <ol class="acc-events mp-history">
{foreach $rows as $row}
        {include uri='design:mailpreferences/parts/consent_event.tpl' row=$row log=true()}
{/foreach}
    </ol>
    {include uri='design:mailpreferences/parts/pager.tpl' page_uri=$page_uri total=$total offset=$offset limit=$limit query=$query}
{/if}
</section>

{include uri='design:mailpreferences/parts/page_end.tpl'}
