{* The search page: the site's filtered search (content/front_search_page.tpl in the kernel's design/standard), the
   same as the administration's: the search as view parameters, the header form and this page's form posted and
   answered with a 303, a filter bar (content type, sort order), the active filters as chips, "Did you mean" and the
   pages. Each result is the media design's search view (content/search_result_item.tpl). The look follows the
   design's tokens through stylesheets/exp-site-search.css, in light, dark and darker. *}
<div class="full-search-results exp-site-search">
    <div class="container">
        {include uri='design:content/front_search_page.tpl' result_template='design:content/search_result_item.tpl'}
    </div>
</div>
