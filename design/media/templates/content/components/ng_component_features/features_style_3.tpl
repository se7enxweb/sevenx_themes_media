


{* IMPORT content/macros/links.tpl AS links *}

{def $grid_class = concat('features-grid-col-', first_set(parameter(block, 'number_of_columns'), 3))}
{def $actions = or(not($content.fields.link_1['empty']), not($content.fields.link_2['empty']))}

{* BLOCK content *}
    <article class="view-component view-component-features features-style-3">

        {if or(or(not($content.fields.title['empty']), not($content.fields.description['empty'])), $actions)}
            <header class="article-header">
                <div class="text">
                    <h2 class="title">{ng_render_field($content.fields.title)}</h2>
                    {if not($content.fields.description['empty'])}
                        <div class="short">
                            {ng_render_field($content.fields.description)}
                        </div>
                    {/if}
                </div>
                {if $actions}
                    <div class="actions">
                        {if not($content.fields.link_1['empty'])}
                            {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-default')))}
                        {/if}
                        {if not($content.fields.link_2['empty'])}
                            {ng_render_field($content.fields.link_2, hash('parameters', hash('css_class', 'btn btn-default')))}
                        {/if}
                    </div>
                {/if}
            </header>
        {/if}

        {def $items = ngsite_group_fields($content, 'item')}
        {if $items|count}
            <div class="features-grid {$grid_class}">
                {foreach $items as $item}
                    {if or(not($item.title['empty']), not($item.description['empty']))}
                        <div class="features-grid-item">
                            {if and(is_set($item.image), not($item.image['empty']))}
                                <div class="item-image">
                                    {item_image_link($links, $item.link, $item.image, 'i480')}
                                </div>
                            {/if}
                            <div class="item-content">
                                {if and(is_set($item.title), not($item.title['empty']))}
                                    <h3 class="item-title">{item_content_link($links, $item.link, $item.title.value.text)}</h3>
                                {/if}
                                {if and(is_set($item.description), not($item.description['empty']))}
                                    <div class="item-short">
                                        {ng_render_field($item.description)}
                                    </div>
                                {/if}
                                {if and(is_set($item.link), not($item.link['empty']))}
                                    <div class="item-actions">
                                        {ng_render_field($item.link, hash('parameters', hash('css_class', 'btn btn-link')))}
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        {/if}
    </article>
{* ENDBLOCK content *}