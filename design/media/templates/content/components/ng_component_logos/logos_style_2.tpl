


{* BLOCK content *}
    <article class="view-component view-component-logos logos-style-2">
        <div class="article-wrapper">
            <header class="article-header">
                <div class="text">
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
                    {if not($content.fields.description['empty'])}
                        <div class="short">
                            {ng_render_field($content.fields.description)}
                        </div>
                    {/if}
                </div>
                <div class="actions">
                    {if not($content.fields.link_1['empty'])}
                        {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-primary')))}
                    {/if}
                    {if not($content.fields.link_2['empty'])}
                        {ng_render_field($content.fields.link_2, hash('parameters', hash('css_class', 'btn btn-default')))}
                    {/if}
                </div>
            </header>
            {def $logos = filterFieldRelations($content, 'logos', array('ng_logo'), 6, 1)}

            <div class="logo-grid">
                {foreach $logos as $logo}
                    <div class="logo-grid-item">
                        {if not($logo.fields.logo_svg['empty'])}
                            <img src="{asset($logo.fields.logo_svg.value.id, 'ibexa_file')}" alt="{$logo.name}" />
                        {/if}
                    </div>
                {/foreach}
            </div>
        </div>
    </article>
{* ENDBLOCK content *}