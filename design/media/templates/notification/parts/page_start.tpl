{* The start of the notification pages in the media design: the design's yellow page header, then the column.
   Variables: title, intro (or false), wide (true for the settings page). Closed by parts/page_end.tpl.
   Drawn by stylesheets/account.css. *}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{$title|wash}</h1>
{if first_set( $intro, false() )}
        <p class="full-page-header-text">{$intro|wash}</p>
{/if}
    </div>
</header>

<div class="full-form-content acc-content{if first_set( $wide, false() )} acc-wide{/if}">
    <div class="container">
        <div class="nf">
