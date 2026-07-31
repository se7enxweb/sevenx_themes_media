


{* IMPORT content/macros/links.tpl AS links *}
{def $actions = or(not($content.fields.link_1['empty']), not($content.fields.link_2['empty']))}

{* BLOCK content *}
    <article class="view-component view-component-features features-style-7">
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
                            {ng_render_field($content.fields.link_1, hash('parameters', hash('css_class', 'btn btn-primary')))}
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
            <div class="list-zigzag">
                {foreach $items as $item}
                    <div class="list-item">
                        {if or(not($item.title['empty']), not($item.description['empty']))}
                            <div class="view-type view-type-zigzag vl9">
                                {if and(is_set($item.image), not($item.image['empty']))}
                                    <figure class="image">
                                        {item_image_link($links, $item.link, $item.image, 'i770')}
                                    </figure>
                                {/if}
                                <div class="article-content">
                                    <header class="article-header">
                                        {if and(is_set($item.highlight_title), not($item.highlight_title['empty']))}
                                            <span class="eyebrow-title">{$item.highlight_title.value.text}</span>
                                        {/if}
                                        {if and(is_set($item.title), not($item.title['empty']))}
                                            <h3 class="title">{item_content_link($links, $item.link, $item.title.value.text)}</h3>
                                        {/if}
                                    </header>
                                    {if and(is_set($item.description), not($item.description['empty']))}
                                        <div class="short">
                                            {ng_render_field($item.description)}
                                        </div>
                                    {/if}
                                    {if and(is_set($item.link), not($item.link['empty']))}
                                        <div class="actions">
                                            {ng_render_field($item.link, hash('parameters', hash('css_class', 'btn btn-link')))}
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        {/if}
                    </div>
                {/foreach}
            </div>
        {/if}
    </article>
{* ENDBLOCK content *}