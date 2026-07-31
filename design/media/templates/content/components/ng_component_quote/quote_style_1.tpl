


{* BLOCK content *}
    <article class="view-component view-component-quote quote-style-1">
        {if not($content.fields.title['empty'])}
            <header class="article-header">
                <div class="container">
                    {if not($content.fields.title['empty'])}
                        <h2 class="title">{ng_render_field($content.fields.title)}</h2>
                    {/if}
                </div>
            </header>
        {/if}

        {def $items = ngsite_group_fields($content, 'item')}
        {if $items|count}
            {if $items|count|gt(1)}
                <div class="quote-swiper swiper"
                    data-effect="slide"
                    data-loop="true"
                    data-autoplay="5000"
                >
                    <div class="swiper-wrapper">
            {/if}
            {foreach $items as $item}
                {if or(not($item.title['empty']), not($item.description['empty']))}
                    <div class="swiper-slide">
                        <div class="container container-narrow">
                            {if or(not($item.title['empty']), not($item.description['empty']))}
                                <div class="quote-item">
                                    <img class="quote-icon" src="{asset('/images/quote.svg')}" alt="" />
                                    {if and(is_set($item.title), not($item.title['empty']))}
                                        <h3 class="item-title">{ng_render_field($item.title)}</h3>
                                    {/if}
                                    {if and(is_set($item.description), not($item.description['empty']))}
                                        <div class="item-short">
                                            {ng_render_field($item.description)}
                                        </div>
                                    {/if}

                                    <div class="quote-person">
                                        {if not($item.person_image['empty'])}
                                            <div class="quote-person-image">
                                                {ng_render_field($item.person_image, hash('parameters', hash('alias', 'i160')))}
                                            </div>
                                        {/if}
                                        {if or(not($item.person_name['empty']), not($item.person_description['empty']))}
                                            <div class="quote-person-info">
                                                {if not($item.person_name['empty'])}
                                                    <div class="quote-person-info-name">{$item.person_name.value.text}</div>
                                                {/if}
                                                {if not($item.person_description['empty'])}
                                                    {ng_render_field($item.person_description)}
                                                {/if}
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}
            {/foreach}
            {if $items|count|gt(1)}
                    </div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
            {/if}
        {/if}

    </article>
{* ENDBLOCK content *}