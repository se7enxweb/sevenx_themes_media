{* Site map: the sections under this node, each with its first pages.
   Replaces the ezwebin table (a bare list on this theme, pinned to the left
   edge) with the site's page header and a responsive grid of sections, and
   says so when there is nothing under the node. *}
{def $page_limit = 12
     $section_limit = 8
     $sections = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                 'limit', $page_limit,
                                                 'offset', $view_parameters.offset,
                                                 'sort_by', $node.sort_array ) )
     $section_total = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id ) )
     $pages = array()
     $page_total = 0}
<style>
{literal}
.site-map{padding:0 1rem 5rem}
.site-map > p.text-center{margin-top:2rem}
.site-map-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(16rem,1fr));gap:1.5rem;margin:3rem 0 0}
.site-map-section{border-top:4px solid #FED82F;padding:1.25rem 0 0}
.site-map-section h2{font-size:1.5rem;font-weight:700;margin:0 0 .75rem}
.site-map-section h2 a{text-decoration:none;color:inherit}
.site-map-section h2 a:hover{text-decoration:underline;text-decoration-color:#FED82F;text-decoration-thickness:3px}
.site-map-section ul{list-style:none;padding:0;margin:0}
.site-map-section li{padding:.3rem 0;border-bottom:1px solid #eee}
.site-map-section li a{text-decoration:none;color:inherit}
.site-map-section li a:hover{text-decoration:underline}
.site-map-more{display:inline-block;margin-top:.6rem;font-weight:600;font-size:.9rem}
.site-map-empty{text-align:center;margin:4rem auto;max-width:34rem}
.site-map-empty .site-error-buttons{display:flex;flex-wrap:wrap;gap:.75rem;justify-content:center;margin-top:2rem}
.site-map-pager{display:flex;justify-content:space-between;margin-top:3rem}
{/literal}
</style>
<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Site map'|i18n( 'design/media/sitemap' )}</h1>
    </div>
</header>
<div class="container site-map">
{if $sections|count}
    <p class="text-center">{'Everything on %name, section by section.'|i18n( 'design/media/sitemap', '', hash( '%name', $node.name|wash ) )}</p>
    <div class="site-map-grid">
    {foreach $sections as $section}
        {set $pages = fetch( 'content', 'list', hash( 'parent_node_id', $section.node_id,
                                                     'limit', $section_limit,
                                                     'sort_by', $section.sort_array ) )
             $page_total = fetch( 'content', 'list_count', hash( 'parent_node_id', $section.node_id ) )}
        <section class="site-map-section">
            <h2><a href={$section.url_alias|ezurl}>{$section.name|wash}</a></h2>
            {if $pages|count}
            <ul>
            {foreach $pages as $page}
                <li><a href={$page.url_alias|ezurl}>{$page.name|wash}</a></li>
            {/foreach}
            </ul>
            {if $page_total|gt( $section_limit )}
            <a class="site-map-more" href={concat( '/content/view/sitemap/', $section.node_id )|ezurl}>{'All %count pages in %name'|i18n( 'design/media/sitemap', '', hash( '%count', $page_total, '%name', $section.name|wash ) )} &rarr;</a>
            {/if}
            {/if}
        </section>
    {/foreach}
    </div>
    {if $section_total|gt( $page_limit )}
    <nav class="site-map-pager" aria-label="{'Site map pages'|i18n( 'design/media/sitemap' )}">
        {if $view_parameters.offset|gt( 0 )}
        <a class="btn btn-secondary" href={concat( '/content/view/sitemap/', $node.node_id, '/(offset)/', max( 0, $view_parameters.offset|sub( $page_limit ) ) )|ezurl}>&larr; {'Previous sections'|i18n( 'design/media/sitemap' )}</a>
        {else}<span></span>{/if}
        {if $view_parameters.offset|sum( $page_limit )|lt( $section_total )}
        <a class="btn btn-secondary" href={concat( '/content/view/sitemap/', $node.node_id, '/(offset)/', $view_parameters.offset|sum( $page_limit ) )|ezurl}>{'More sections'|i18n( 'design/media/sitemap' )} &rarr;</a>
        {/if}
    </nav>
    {/if}
{else}
    <div class="site-map-empty">
        <h2>{'Nothing here yet'|i18n( 'design/media/sitemap' )}</h2>
        <p>{'%name has no pages under it at the moment.'|i18n( 'design/media/sitemap', '', hash( '%name', $node.name|wash ) )}</p>
        <div class="site-error-buttons">
            <a href={'/'|ezurl} class="btn btn-primary">{'Go to the home page'|i18n( 'design/media/error' )}</a>
            {if $node.parent_node_id|gt( 1 )}
            <a href={concat( '/content/view/sitemap/', $node.parent_node_id )|ezurl} class="btn btn-secondary">{'Up one level'|i18n( 'design/media/sitemap' )}</a>
            {/if}
        </div>
    </div>
{/if}
</div>
{undef $page_limit $section_limit $sections $section_total $pages $page_total}
