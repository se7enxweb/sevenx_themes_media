{* Media-design layout renderer mirroring the reference page structure:
   <div class="zone-layout-layoutN"> > header zone section(s) >
   <main class="main-content-block"> with the content zones > footer zone
   section(s). Zone identifiers 'header'/'footer' sit outside <main>. *}
{def $lay_pre = array()}
{def $lay_mid = array()}
{def $lay_post = array()}
{foreach $layout.zones as $lay_zone}
    {if $lay_zone.identifier|eq('header')}
        {set $lay_pre = $lay_pre|append($lay_zone)}
    {elseif $lay_zone.identifier|eq('footer')}
        {set $lay_post = $lay_post|append($lay_zone)}
    {else}
        {set $lay_mid = $lay_mid|append($lay_zone)}
    {/if}
{/foreach}
<div class="zone-layout-{$layout.layout_type|ristring('_','')|wash}">
{foreach $lay_pre as $lay_zone}
    {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
{/foreach}
<main class="main-content-block" itemscope itemtype="http://schema.org/WebPage">
{if is_object($node)}
    <header class="visually-hidden">
        <h1 itemprop="name">{$node.name|wash}</h1>
        {def $lp_intro = firstNonEmptyField($node.object, 'description', 'teaser_intro', 'intro')}
        {if not($lp_intro.empty)}
            <p itemprop="description">{$lp_intro.value.text}</p>
        {else}
            {def $lp_meta = fetch('content','object',hash('object_id',false(),'remote_id', ezini('SiteInfo','RemoteID','menu.ini')))}
            {if and(is_object($lp_meta), is_set($lp_meta.data_map.metadata), $lp_meta.data_map.metadata.has_content)}
                {def $lp_metas = $lp_meta.data_map.metadata.content}
                {if and(is_set($lp_metas.metas), is_set($lp_metas.metas.description), $lp_metas.metas.description.content|ne(''))}
                    <p itemprop="description">{$lp_metas.metas.description.content|wash}</p>
                {/if}
                {undef $lp_metas}
            {/if}
            {undef $lp_meta}
        {/if}
        {undef $lp_intro}
    </header>
{/if}
{if $layout.layout_type|eq('layout_4')}
{* full-view layout: left/right zones sit in a bootstrap row, post_header and
   pre_footer outside it, mirroring the reference layout_4 markup *}
{foreach $lay_mid as $lay_zone}
    {if $lay_zone.identifier|eq('post_header')}
        {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
    {/if}
{/foreach}
<div class="container">
    <div class="row">
        <div class="col-lg-8">
        {foreach $lay_mid as $lay_zone}
            {if $lay_zone.identifier|eq('left')}
                {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
            {/if}
        {/foreach}
        </div>
        <div class="col-lg-4">
        {foreach $lay_mid as $lay_zone}
            {if $lay_zone.identifier|eq('right')}
                {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
            {/if}
        {/foreach}
        </div>
    </div>
</div>
{foreach $lay_mid as $lay_zone}
    {if and( $lay_zone.identifier|ne('post_header'), $lay_zone.identifier|ne('left'), $lay_zone.identifier|ne('right') )}
        {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
    {/if}
{/foreach}
{else}
{foreach $lay_mid as $lay_zone}
    {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
{/foreach}
{/if}
</main>
{foreach $lay_post as $lay_zone}
    {include uri='design:explayouts/zone.tpl' zone=$lay_zone module_result=$module_result}
{/foreach}
</div>
{undef $lay_pre $lay_mid $lay_post}
