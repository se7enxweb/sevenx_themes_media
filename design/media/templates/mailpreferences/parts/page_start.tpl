{* The start of every e-mail preference page in the media design: the design's yellow page header with the title
   and the introduction, then the form column (full-form-content). The preference page itself (it has $master) and
   the administrator's lists use the wider column. Closed by parts/page_end.tpl.
   Variables: title, intro (or false), crumb (hash( url, text ) or false), wide, admin_tab (or false).
   The styles are in stylesheets/account.css, packed with the design's others, so parts/style.tpl is empty here. *}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{$title|wash}</h1>
{if first_set( $intro, false() )}
        <p class="full-page-header-text">{$intro|wash}</p>
{/if}
    </div>
</header>

<div class="full-form-content acc-content{if or( first_set( $wide, false() ), is_set( $master ) )} acc-wide{/if}">
    <div class="container">
{if first_set( $crumb, false() )}
        <p class="acc-crumb"><a href={$crumb.url|ezurl}>{$crumb.text|wash}</a></p>
{/if}
{if first_set( $admin_tab, false() )}
        {include uri='design:mailpreferences/parts/admin_tabs.tpl' current=$admin_tab}
{/if}
        <div class="mp mp-public mp-media">
