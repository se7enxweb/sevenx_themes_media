{* eZ4 native lead form payload for embedded and modal use. *}

{def $lead_form_class = first_set($class, 'embed-form js-form-embed')}
<div class="view-type view-type-payload ng-lead-form">
    {include uri='design:explayouts/block/component/_lead_form.tpl' form_object_id=$content.id form_class=$lead_form_class}
</div>
{undef $lead_form_class}
