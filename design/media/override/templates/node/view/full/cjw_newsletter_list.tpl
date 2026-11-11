{* The public page of a newsletter list (cjw_newsletter_list) in the media design. The cjw_newsletter
   extension's own rule picks node/view/full/cjw_newsletter_list.tpl; the media design's file wins over the
   extension's admin view because the media design is searched first. The generic full page,
   which leaves out the list's settings, and a link to subscribe. *}
{include uri='design:content/views/full.tpl' node=$node object=$node.object content=$node.object location=$node view_type='full'
         view_parameters=first_set($view_parameters, hash())}
<div class="container container-narrow newsletter-subscribe">
    <a class="btn btn-primary" href={'newsletter/subscribe'|ezurl}>{'Subscribe'|i18n('cjw_newsletter/subscribe')}</a>
</div>
