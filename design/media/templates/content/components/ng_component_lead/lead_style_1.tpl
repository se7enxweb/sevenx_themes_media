


{* BLOCK content *}
<article class="view-component view-component-lead lead-style-1">
    <header class="article-header">

        {if not($content.fields.eyebrow_title['empty'])}
            <div class="eyebrow-title">
                {ng_render_field($content.fields.eyebrow_title)}
            </div>
        {/if}

        {if not($content.fields.title['empty'])}
            <h2 class="title">
                {ng_render_field($content.fields.title)}
            </h2>
        {/if}
    </header>

    <div class="article-info">
        {if not($content.fields.description['empty'])}
            <div class="short">
                {ng_render_field($content.fields.description)}
            </div>
        {/if}

        {if not($content.fields.link_1['empty'])}
            {if $content.fields.link_1.value.isTargetEmbed}
                <div class="embedded-form">
            {else}
                <div class="actions">
            {/if}
                {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-primary')))}
            </div>
        {/if}
    </div>
</article>
{* ENDBLOCK content *}