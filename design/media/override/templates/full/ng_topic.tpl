{if not(is_set($content))}{def $content = $node.object}{/if}

{if is_set($node.object.data_map['full_intro'])}
    {if $node.object.data_map['full_intro'].has_content}
        {def $meta_data = hash('description', $node.object.data_map['full_intro'].data_text|strip_tags|shorten(152))}
    {/if}
{/if}

{def $topic_tag = $node.name|trim}

{* BLOCK content *}
    <div class="view-type view-type-{$view_type} ng-topic">
        {* BLOCK page_header *}
            <header class="full-page-header text-center{if not($show_path)} no-breadcrumbs{/if}">
                <div class="container">
                    <h1 class="full-page-title">{$node.name|wash}</h1>
                    {if is_set($node.object.data_map['full_intro'])}
                        {if $node.object.data_map['full_intro'].has_content}
                            <div class="full-page-header-text">
                                <div class="row">
                                    <div class="container container-narrow">
                                        {attribute_view_gui attribute=$node.object.data_map['full_intro']}
                                    </div>
                                </div>
                            </div>
                        {/if}
                    {/if}
                </div>
            </header>
        {* ENDBLOCK page_header *}

        <div class="container">
            {* BLOCK body *}
                {if is_set($node.object.data_map['body'])}
                    {if $node.object.data_map['body'].has_content}
                        {attribute_view_gui attribute=$node.object.data_map['body']}
                    {/if}
                {/if}
            {* ENDBLOCK body *}
        </div>
    </div>
{* ENDBLOCK content *}
