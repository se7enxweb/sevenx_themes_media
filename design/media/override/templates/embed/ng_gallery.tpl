


<div class="view-type view-type-{$view_type} ng-gallery">
    {render(controller('ngsite.controller.relations.related_multimedia_items', hash('locationId', $content.contentInfo.mainLocationId, 'includeChildren', true, 'contentTypeIdentifiers', array('image', 'ng_video'), 'template', '@ibexadesign/content/parts/related_multimedia.html.twig')))}
</div>