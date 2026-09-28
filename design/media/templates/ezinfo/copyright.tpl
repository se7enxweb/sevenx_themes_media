{* The /ezinfo/copyright page in the media design. copyright_notice is the notice set by
   kernel/ezinfo/copyright.php (HTML paragraphs); it is a legal notice and is shown as it is. *}
<style>
{literal}
.ezinfo-page .full-page-title{margin-bottom:0}
.ezinfo-page .ezinfo-notice{max-width:44rem;margin:3rem 0 4rem}
.ezinfo-page .ezinfo-notice p{margin-bottom:1.25rem}
.ezinfo-page .ezinfo-notice a{word-break:break-all;text-decoration:underline}
{/literal}
</style>
<div class="ezinfo-page">
    <header class="full-page-header no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{'Copyright Notice'|i18n( 'design/standard/ezinfo/about' )}</h1>
        </div>
    </header>

    <div class="container container-narrow">
        <div class="full-page-body ezinfo-notice">
            {$copyright_notice}
        </div>
    </div>
</div>
