


{def $image = fieldValue($content, 'image')}
{def $image_mobile = fieldValue($content, 'image_mobile')}
{def $actions = or(not($content.fields.link_1['empty']), not($content.fields.link_2['empty']))}

{* BLOCK content *}
<article class="view-component view-component-about about-style-4">
    <header class="article-header">
        {if not($content.fields.title['empty'])}
            <h2 class="title">
                {ng_render_field($content.fields.title)}
            </h2>
        {/if}
        {if or(not($content.fields.description['empty']), not($content.fields.description_2['empty']))}
            <div class="text">
                {if not($content.fields.description['empty'])}
                    <div class="short">
                        {ng_render_field($content.fields.description)}
                    </div>
                {/if}
                {if not($content.fields.description_2['empty'])}
                    <div class="short">
                        {ng_render_field($content.fields.description_2)}
                    </div>
                {/if}
            </div>
        {/if}
        {if $actions}
            <div class="actions">
                {if not($content.fields.link_1['empty'])}
                    {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-primary')))}
                {/if}
                {if not($content.fields.link_2['empty'])}
                    {ng_render_field($content.fields.link_2, hash('parameters', hash('css_class', 'btn btn-default')))}
                {/if}
            </div>
        {/if}
    </header>
</article>
{* ENDBLOCK content *}