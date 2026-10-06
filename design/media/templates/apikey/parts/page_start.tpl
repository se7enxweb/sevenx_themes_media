{* The start of the API access page (apikey/list) in the media design: the design's page header with the title and
   the introduction, then the account column (full-form-content), as the e-mail preference pages have. The page's
   own styles come from the kernel's apikey/parts/style.tpl. Closed by parts/page_end.tpl.
   Variables: title, intro (or false). *}
{include uri='design:apikey/parts/style.tpl'}
<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{$title|wash}</h1>
{if first_set( $intro, false() )}
        <p class="full-page-header-text">{$intro|wash}</p>
{/if}
    </div>
</header>

<div class="full-form-content acc-content acc-wide">
    <div class="container">
        <p class="acc-crumb"><a href={'user/edit'|ezurl}>{'My account'|i18n( 'design/standard/apikey' )}</a></p>
        <div class="ak ak-media">
