<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                {def $site_info = $ngsite.siteInfoContent}
                {def $site_name = $ngsite.siteInfoContent.fields.site_name.value.text|trim}
                {include uri='design:content/parts/site_logo.tpl'}
                <a href="#" class="close " data-dismiss="modal" aria-label="Close">
                    <span class="icon-cancel"></span>
                </a>
            </div>
            <div class="modal-body">
            </div>
        </div>
    </div>
</div>