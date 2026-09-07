{* Generic card view, the fallback for every class that has no
   content/views/card/<class>.tpl. Mirrors @app/content/views/card.html.twig in
   the Nexus reference, which relies on this same generic template for all
   classes except ng_job_position.

   eZ4 notes: the reference calls content_fields.image(); here the image comes
   from content/parts/item_image.tpl (the idiom used by the hand-maintained
   overlay/listitem views), and the link comes from $node.url_alias rather than
   ibexa_path(). *}

{* IMPORT content/macros/content_fields.tpl AS content_fields *}
{* IMPORT macros.tpl AS toolbar_macros *}

{def $content_fields = array()}
{def $toolbar_macros = array()}

{def $cd_node = false()}
{if is_set($node)}
    {set $cd_node = $node}
{elseif and(is_set($location.node_id), $location.node_id|gt(0))}
    {set $cd_node = fetch('content','node',hash('node_id',$location.node_id))}
{/if}

{if $cd_node}
{def $cd_class = ''}
{if is_set($cd_node.class_identifier)}
    {set $cd_class = $cd_node.class_identifier|explode('_')|implode('-')}
{/if}
<article data-item="true" data-content-id="{$cd_node.contentobject_id}" data-location-id="{$cd_node.node_id}" class="view-type view-type-{first_set($view_type, 'card')|wash} {$cd_class|wash} vl8">
    {include uri='design:content/parts/item_image.tpl' node=$cd_node}

    <div class="article-content">
        <header class="article-header">
            <h2 class="title"><a href={$cd_node.url_alias|ezurl}>{$cd_node.name|wash}</a></h2>
        </header>

        {if first_set($with_intro, false())}
            {intro($content_fields, $cd_node.object)}
        {/if}
    </div>
</article>
{/if}
{undef $cd_node $cd_class $content_fields $toolbar_macros}
