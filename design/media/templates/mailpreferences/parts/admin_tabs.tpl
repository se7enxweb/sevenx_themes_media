{* The administrator's pages of the e-mail preferences as the media design's pill tabs (the acc-tabs of Security
   activity, drawn by stylesheets/account.css in light, dark and darker); the current page is a pill without a link.
   Replaces the kernel's parts/admin_tabs.tpl, whose mp-tabs styles the media design does not load.
   Variables: current (status, categories, suppression, consent, user). *}
<nav aria-label="{'E-mail preferences administration'|i18n( 'design/admin/mailpreferences' )}">
<ul class="acc acc-tabs">
    <li>{if $current|eq( 'status' )}<span class="current" aria-current="page">{'Status'|i18n( 'design/admin/mailpreferences' )}</span>{else}<a href={'mailpreferences/admin/status'|ezurl}>{'Status'|i18n( 'design/admin/mailpreferences' )}</a>{/if}</li>
    <li>{if $current|eq( 'categories' )}<span class="current" aria-current="page">{'Categories'|i18n( 'design/admin/mailpreferences' )}</span>{else}<a href={'mailpreferences/admin/categories'|ezurl}>{'Categories'|i18n( 'design/admin/mailpreferences' )}</a>{/if}</li>
    <li>{if $current|eq( 'suppression' )}<span class="current" aria-current="page">{'Suppression list'|i18n( 'design/admin/mailpreferences' )}</span>{else}<a href={'mailpreferences/admin/suppression'|ezurl}>{'Suppression list'|i18n( 'design/admin/mailpreferences' )}</a>{/if}</li>
    <li>{if $current|eq( 'consent' )}<span class="current" aria-current="page">{'Consent log'|i18n( 'design/admin/mailpreferences' )}</span>{else}<a href={'mailpreferences/admin/consent'|ezurl}>{'Consent log'|i18n( 'design/admin/mailpreferences' )}</a>{/if}</li>
    <li>{if $current|eq( 'user' )}<span class="current" aria-current="page">{'A user'|i18n( 'design/admin/mailpreferences' )}</span>{else}<a href={'mailpreferences/admin/user'|ezurl}>{'A user'|i18n( 'design/admin/mailpreferences' )}</a>{/if}</li>
</ul>
</nav>
