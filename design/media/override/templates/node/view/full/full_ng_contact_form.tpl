



{* eZ4-native full view for ng_contact_form. *}

{def $show_path = false}

<div class="view-type view-type-{$view_type} ng-contact-form">
    <header class="full-page-header text-center no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{$node.name|wash}</h1>
            {if $node.data_map.full_intro.has_content}
                <div class="full-page-header-text">
                    <div class="row">
                        <div class="container container-narrow">
                            <p>{$node.data_map.full_intro.data_text|strip_tags}</p>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </header>

    <div class="full-form-content">
        <div class="container">
            {if $node.data_map.body.has_content}
                <div class="contact-form-body mb-5">
                    {$node.data_map.body.data_text|strip_tags}
                </div>
            {/if}

            {if and($validation.processed, count($validation.attributes)|gt(0))}
                <div class="message-warning">
                    <h2>{'Missing or invalid input'|i18n('design/standard/node/view')}</h2>
                    <ul>
                        {section name=UnvalidatedAttributes loop=$validation.attributes}
                            <li>{$:item.name|wash}: {$:item.description}</li>
                        {/section}
                    </ul>
                </div>
            {/if}

            {include uri='design:content/views/payload/ng_contact_form.tpl' node=$node referer=$requested_uri_string form_class='embed-form js-form-embed'}
        </div>
    </div>
</div>
