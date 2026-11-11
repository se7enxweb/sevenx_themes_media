{* The public page of a newsletter edition in the media design. The cjw_newsletter extension's own
   rule picks node/view/full/cjw_newsletter_edition.tpl; the media design's file wins over the
   extension's admin view because the media design is searched first. The generic full page: the
   edition's fields without its sending settings, and its articles below. *}
{include uri='design:content/views/full.tpl' node=$node object=$node.object content=$node.object location=$node view_type='full'
         view_parameters=first_set($view_parameters, hash())}
