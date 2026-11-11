{* Generic full view of any class in the media design, so a new class shows properly without a
   template of its own: the page header (topic, title, author, date), the first image, the intro
   fields, every other field with content, a form for the information collectors, and the
   children of a container, paged.
   A class gets a look of its own from content/views/full/<class>.tpl (no override.ini rule).
   Fields left out: the title fields (the page title shows them), the image shown on top, user
   accounts, passwords and two-step sign-in, page metadata (the page head shows it), newsletter
   configuration (list, edition and subscription settings), layout
   fields, and empty fields. *}
{def $gf_map = $node.object.data_map
     $gf_skip = array('title', 'name', 'short_title', 'short_name')
     $gf_intro_ids = array('full_intro', 'intro', 'short_description', 'summary', 'lead', 'teaser_intro')
     $gf_hidden_types = array('ezuser', 'ezpassword', 'ezsubtreesubscription', 'sevenxauthentication2fa', 'xrowmetadata', 'ezpage', 'eznewsletter', 'cjwnewsletterlist', 'cjwnewsletterlistvirtual', 'cjwnewsletteredition', 'cjwnewslettersubscription')
     $gf_text_types = array('ezxmltext', 'ezrichtext', 'eztext')
     $gf_image = false()
     $gf_url = ''
     $gf_collectors = array()
     $gf_intros = array()
     $gf_fields = array()}

{* the image on top: "image", else "teaser_image", else the first image field with content *}
{foreach array('image', 'teaser_image') as $gf_id}
    {if and(not($gf_image), is_set($gf_map[$gf_id]), $gf_map[$gf_id].data_type_string|eq('ezimage'), $gf_map[$gf_id].has_content)}
        {set $gf_image = $gf_map[$gf_id]}
    {/if}
{/foreach}
{if not($gf_image)}
    {foreach $gf_map as $gf_attr}
        {if and(not($gf_image), $gf_attr.data_type_string|eq('ezimage'), $gf_attr.has_content)}
            {set $gf_image = $gf_attr}
        {/if}
    {/foreach}
{/if}
{if $gf_image}
    {def $gf_alias = $gf_image.content}
    {if is_set($gf_alias['i1320'])}{set $gf_url = $gf_alias['i1320'].url}
    {elseif is_set($gf_alias['large'])}{set $gf_url = $gf_alias['large'].url}
    {elseif is_set($gf_alias['original'])}{set $gf_url = $gf_alias['original'].url}{/if}
{/if}

{* sort the fields: collectors to the form, intro fields first, the rest in class order *}
{foreach $gf_map as $gf_id => $gf_attr}
    {if $gf_attr.is_information_collector}
        {set $gf_collectors = $gf_collectors|append($gf_attr)}
    {elseif or($gf_skip|contains($gf_id), $gf_hidden_types|contains($gf_attr.data_type_string), not($gf_attr.has_content))}
        {* left out *}
    {elseif and($gf_image, $gf_attr.id|eq($gf_image.id))}
        {* shown on top *}
    {elseif $gf_intro_ids|contains($gf_id)}
        {set $gf_intros = $gf_intros|append($gf_attr)}
    {else}
        {set $gf_fields = $gf_fields|append($gf_attr)}
    {/if}
{/foreach}

{explblock name='content'}
<article class="view-type view-type-full {$node.class_identifier|ristring('_', '-')} generic-full">
    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            {include uri='design:content/parts/main_topic.tpl' content=$content}
            <h1 class="full-page-title"><span class="exp_string-field">{$node.name|wash}</span></h1>
            <div class="full-page-info">
                {include uri='design:content/parts/author.tpl' content=$content node=$node}
                {include uri='design:content/parts/time.tpl' node=$node}
            </div>
        </div>
    </header>
    {/explblock}

    {if $gf_url|ne('')}
    {explblock name='article_media'}
    <div class="full-page-image">
        <div class="container container-wide">
            <figure class="image-wrapper">
                <img src={$gf_url|ezroot} loading="lazy" alt="{first_set($gf_alias.alternative_text, $node.name)|wash}" />
            </figure>
        </div>
    </div>
    {/explblock}
    {/if}

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">
            {if $gf_intros|count}
            <div class="full-page-intro">
                {foreach $gf_intros as $gf_attr}
                <div class="exp_richtext-field attribute-{$gf_attr.contentclass_attribute_identifier|wash}">{attribute_view_gui attribute=$gf_attr}</div>
                {/foreach}
            </div>
            {/if}

            {foreach $gf_fields as $gf_attr}
                {if $gf_text_types|contains($gf_attr.data_type_string)}
                <div class="exp_richtext-field attribute-{$gf_attr.contentclass_attribute_identifier|wash}">{attribute_view_gui attribute=$gf_attr}</div>
                {else}
                <div class="full-page-field attribute-{$gf_attr.contentclass_attribute_identifier|wash}">
                    <h2 class="full-page-field-label">{$gf_attr.contentclass_attribute_name|wash}</h2>
                    <div class="full-page-field-value">{attribute_view_gui attribute=$gf_attr}</div>
                </div>
                {/if}
            {/foreach}

            {if $gf_collectors|count}
            <form class="full-page-form" method="post" action={'content/action'|ezurl}>
                {foreach $gf_collectors as $gf_attr}
                <div class="form-group attribute-{$gf_attr.contentclass_attribute_identifier|wash}">
                    <label>{$gf_attr.contentclass_attribute_name|wash}{if $gf_attr.contentclass_attribute.is_required} *{/if}</label>
                    {attribute_view_gui attribute=$gf_attr}
                </div>
                {/foreach}
                <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                <input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />
                <input type="hidden" name="ViewMode" value="full" />
                <button type="submit" class="btn btn-primary" name="ActionCollectInformation">{'Send'|i18n('design/standard/content/view')}</button>
            </form>
            {/if}

            {include uri='design:content/parts/tags.tpl' content=$content node=$node}
        </div>
        {/explblock}

        {if $node.object.content_class.is_container}
            {def $gf_limit = 12
                 $gf_offset = first_set($view_parameters.offset, 0)
                 $gf_count = fetch('content', 'list_count', hash('parent_node_id', $node.node_id))}
            {if $gf_count|gt(0)}
            <section class="full-page-children">
                {foreach fetch('content', 'list', hash('parent_node_id', $node.node_id,
                                                       'offset', $gf_offset,
                                                       'limit', $gf_limit,
                                                       'sort_by', $node.sort_array)) as $gf_child}
                    {node_view_gui view='line' content_node=$gf_child}
                {/foreach}
                {include name=navigator uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias item_count=$gf_count
                         view_parameters=first_set($view_parameters, hash()) item_limit=$gf_limit}
            </section>
            {/if}
            {undef $gf_limit $gf_offset $gf_count}
        {/if}
    </div>
</article>
{/explblock}
{undef}
