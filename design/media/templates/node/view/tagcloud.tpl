{* Tag cloud: the tags used by content under this node, larger for the ones
   used most. This site tags content with eztags; the ezwebin view counted only
   ezkeyword attributes, found none, and rendered an empty page. Keywords are
   still tried when there are no tags, and when there is neither the page says
   so and offers somewhere to go. *}
{set-block variable=$tag_cloud_html}{eztagscloud( hash( 'parent_node_id', $node.node_id, 'sort_by', array( 'keyword', true() ), 'limit', 200 ) )}{/set-block}
{if $tag_cloud_html|trim|eq( '' )}
    {set-block variable=$tag_cloud_html}{eztagcloud( hash( 'parent_node_id', $node.node_id ) )}{/set-block}
{/if}
<style>
{literal}
.site-tag-cloud{padding:0 1rem 5rem}
.site-tag-cloud > p.text-center{margin-top:2rem}
.site-tag-cloud-tags{display:flex;flex-wrap:wrap;gap:.6rem .9rem;justify-content:center;align-items:baseline;margin:3rem auto 0;max-width:60rem;line-height:1.2}
.site-tag-cloud-tags a{display:inline-block;padding:.2rem .7rem;border:2px solid #000;text-decoration:none;color:#000;font-weight:600;transition:background .15s}
.site-tag-cloud-tags a:hover,.site-tag-cloud-tags a:focus{background:#FED82F}
.site-tag-cloud-empty{text-align:center;margin:4rem auto;max-width:34rem}
.site-tag-cloud-empty .site-error-buttons{display:flex;flex-wrap:wrap;gap:.75rem;justify-content:center;margin-top:2rem}
{/literal}
</style>
<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Topics'|i18n( 'design/media/tagcloud' )}</h1>
    </div>
</header>
<div class="container site-tag-cloud">
{if $tag_cloud_html|trim|ne( '' )}
    <p class="text-center">{'The topics people write about on %name. The bigger the word, the more there is to read.'|i18n( 'design/media/tagcloud', '', hash( '%name', $node.name|wash ) )}</p>
    <div class="site-tag-cloud-tags">{$tag_cloud_html}</div>
{else}
    <div class="site-tag-cloud-empty">
        <h2>{'No topics yet'|i18n( 'design/media/tagcloud' )}</h2>
        <p>{'Nothing under %name has been tagged with a topic so far. The site map shows everything that is here.'|i18n( 'design/media/tagcloud', '', hash( '%name', $node.name|wash ) )}</p>
        <div class="site-error-buttons">
            <a href={concat( '/content/view/sitemap/', $node.node_id )|ezurl} class="btn btn-primary">{'Browse the site map'|i18n( 'design/media/error' )}</a>
            <a href={'/'|ezurl} class="btn btn-secondary">{'Go to the home page'|i18n( 'design/media/error' )}</a>
        </div>
    </div>
{/if}
</div>
