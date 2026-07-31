{def $site_info = $ngsite.siteInfoContent}
{def $site_name = $ngsite.siteInfoContent.fields.site_name.value.text|trim}

<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                {include uri='design:content/parts/site_logo.tpl'}
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                {ng_view_content($content, 'payload', hash('params', hash('action', path('ngsite_info_collection_ajax_submit', hash('formContentId', $content.id)), 'referer', first_set($referer, null), 'class', 'embed-form')))}
            </div>
        </div>
    </div>
</div>