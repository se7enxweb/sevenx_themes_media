{* Product full view for the media design.

   The stock 'product' class ships: name, product_number, short_description,
   description, price (ezprice), image (an object relation list of Image
   objects, not an ezimage), caption, additional_options (ezmultioption),
   tags and rating (ezsrrating).

   Layout follows the other full views here - full-page-header, then
   container + full-page-body - with a two column band in the middle pairing
   the gallery with the buy panel.

   Gallery: the same two tier swiper the rest of the site uses for galleries
   (.thumb-swiper > .gallery-top + .gallery-thumbs). index-noncritical.js
   already binds SwiperThumb to that selector on every page and index.css
   already styles it, so clicking a thumbnail swaps the main image with no new
   assets. Slides are rendered through the shared _thumb_slide.tpl partial, at
   i1320 for the main tier and i320 for the thumbs.

   Rating is displayed read-only. ezstarrating's own template asks for its CSS
   and JS with ezcss_require/ezscript_require, and this design's pagelayout has
   no ezcss()/ezscript() hook to emit them, so attribute_view_gui would render
   an unstyled list and a dead rate control. The aggregate is drawn from
   rounded_average instead; see doc for what interactive rating would need.

   The buy panel is the form the shop module expects. content/action reads
   ActionAddToBasket and hands off to shop/basket, which reads ContentObjectID,
   an optional Quantity (defaults to 1) and eZOption[] - so the multioption
   attribute has to render inside this form, and the hidden fields have to keep
   their names.

   i18n: 'Add to basket', 'Add to wish list' and the related products heading
   stay in design/ezwebin/full/product, which already carries their German
   translations. Strings new to this template use ngsite like its siblings. *}

{def $p_map = $node.object.data_map}
{def $p_price = false()}
{if and( is_set( $p_map.price ), $p_map.price.has_content )}
    {set $p_price = $p_map.price.content}
{/if}

{* Gather the product's images once - both gallery tiers iterate the same set.
   The relation list holds object ids; the slide partial wants tree nodes. *}
{def $p_nodes   = array()
     $p_rel_obj = false()}
{if and( is_set( $p_map.image ), $p_map.image.has_content )}
    {foreach $p_map.image.content.relation_list as $p_rel}
        {set $p_rel_obj = fetch( 'content', 'object', hash( 'object_id', $p_rel.contentobject_id ) )}
        {if $p_rel_obj}
            {if and( $p_rel_obj.main_node, is_set( $p_rel_obj.data_map.image ) )}
                {if $p_rel_obj.data_map.image.has_content}
                    {set $p_nodes = $p_nodes|append( $p_rel_obj.main_node )}
                {/if}
            {/if}
        {/if}
    {/foreach}
{/if}
{undef $p_rel_obj}

{explblock name='content'}
<article class="view-type view-type-full product vf1">

    {explblock name='article_header'}
    <header class="full-page-header">
        <div class="container">
            <h1 class="full-page-title"><span class="ibexa_string-field">{$node.name|wash}</span></h1>

            <div class="full-page-info">
                {if and( is_set( $p_map.product_number ), $p_map.product_number.has_content )}
                    <span>{'Item'|i18n('ngsite')} {$p_map.product_number.content|wash}</span>
                {/if}
                {if and( is_set( $p_map.tags ), $p_map.tags.has_content )}
                    <span>{$p_map.tags.content.keyword_string|wash}</span>
                {/if}
            </div>

            {if is_set( $p_map.rating )}
            {def $p_rating = $p_map.rating.content}
            {if $p_rating.rating_count|gt(0)}
            <div class="product-rating">
                <span class="product-stars" style="--rating: {$p_rating.rounded_average};" aria-hidden="true"></span>
                <span class="product-rating-text">{'%average out of 5, %count ratings'|i18n( 'ngsite',,
                      hash( '%average', $p_rating.rating|wash, '%count', $p_rating.rating_count|wash ) )}</span>
            </div>
            {/if}
            {undef $p_rating}
            {/if}
        </div>
    </header>
    {/explblock}

    <div class="container container-wide">
        <div class="product-main">

            {explblock name='article_media'}
            <div class="product-media">
                {if $p_nodes|count()|gt(0)}
                <div class="product-gallery thumb-swiper">
                    <div class="gallery-top swiper" data-effect="slide" data-length="{$p_nodes|count()}">
                        <div class="swiper-wrapper">
                            {foreach $p_nodes as $p_slide_node}
                            <div class="swiper-slide">
                                {include uri='design:explayouts/block/gallery/_thumb_slide.tpl'
                                         node=$p_slide_node alias='i1320' show_info=0}
                            </div>
                            {/foreach}
                        </div>
                        {if $p_nodes|count()|gt(1)}
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                        {/if}
                    </div>

                    {* One image needs no thumbnail strip to choose between. *}
                    {if $p_nodes|count()|gt(1)}
                    <div class="swiper gallery-thumbs">
                        <div class="swiper-wrapper">
                            {foreach $p_nodes as $p_thumb_node}
                            <div class="swiper-slide">
                                {include uri='design:explayouts/block/gallery/_thumb_slide.tpl'
                                         node=$p_thumb_node alias='i320' show_info=0}
                            </div>
                            {/foreach}
                        </div>
                    </div>
                    {/if}
                </div>
                {else}
                <div class="product-gallery product-gallery-empty">
                    <div class="image-wrapper"></div>
                </div>
                {/if}

                {if and( is_set( $p_map.caption ), $p_map.caption.has_content )}
                <div class="product-caption ibexa_richtext-field">{attribute_view_gui attribute=$p_map.caption}</div>
                {/if}
            </div>
            {/explblock}

            <div class="product-buy">
                <form method="post" action={'content/action'|ezurl} class="product-buy-form">

                    {if $p_price}
                    <div class="product-price">
                        {if $p_price.has_discount}
                            <p class="product-price-was"><s>{$p_price.inc_vat_price|l10n('currency')}</s></p>
                            <p class="product-price-now">{$p_price.discount_price_inc_vat|l10n('currency')}</p>
                            <p class="product-price-save">{'Save'|i18n('ngsite')} {$p_price.discount_percent}%</p>
                        {else}
                            <p class="product-price-now">{$p_price.inc_vat_price|l10n('currency')}</p>
                        {/if}
                        {* The headline figure is always inc_vat_price, whichever way the
                           price is stored, so the note is only about whether VAT applies
                           at all. With no VAT type set vat_percent is 0 and inc == ex,
                           and a note either way would be noise. *}
                        {if $p_price.vat_percent|gt(0)}
                        <p class="product-price-vat">
                            {'Includes %percent% VAT'|i18n( 'ngsite',, hash( '%percent', $p_price.vat_percent ) )}
                        </p>
                        {/if}
                    </div>
                    {/if}

                    {if and( is_set( $p_map.additional_options ), $p_map.additional_options.has_content )}
                    <div class="product-options">
                        {attribute_view_gui attribute=$p_map.additional_options}
                    </div>
                    {/if}

                    <div class="product-qty">
                        <label for="Quantity">{'Quantity'|i18n('ngsite')}</label>
                        <input id="Quantity" class="form-control" type="number" name="Quantity"
                               value="1" min="1" step="1" inputmode="numeric" />
                    </div>

                    <div class="product-actions">
                        <input type="submit" class="btn btn-primary" name="ActionAddToBasket"
                               value="{'Add to basket'|i18n('design/ezwebin/full/product')}" />
                        {if fetch( 'user', 'current_user' ).is_logged_in}
                        <input type="submit" class="btn btn-secondary" name="ActionAddToWishList"
                               value="{'Add to wish list'|i18n('design/ezwebin/full/product')}" />
                        {/if}
                    </div>

                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="ViewMode" value="full" />
                </form>
            </div>

        </div>
    </div>

    <div class="container container-narrow">
        {explblock name='article_body'}
        <div class="full-page-body">

            {if and( is_set( $p_map.short_description ), $p_map.short_description.has_content )}
            <div class="full-page-intro">
                <div class="ibexa_richtext-field">{attribute_view_gui attribute=$p_map.short_description}</div>
            </div>
            {/if}

            {if and( is_set( $p_map.description ), $p_map.description.has_content )}
            <div class="ibexa_richtext-field">{attribute_view_gui attribute=$p_map.description}</div>
            {/if}

            {* Specifications: an ezmatrix of Specification / Value rows. The first
               cell of each row is rendered as the row header, the rest as values,
               so a matrix with extra value columns still renders correctly.
               eZMatrix exposes its rows as .rows.sequential, each with .columns. *}
            {if and( is_set( $p_map.specifications ), $p_map.specifications.has_content )}
            {def $p_spec_rows = $p_map.specifications.content.rows.sequential}
            {if $p_spec_rows|count()|gt(0)}
            <section class="product-specs">
                <h2 class="form-section-title">{'Specifications'|i18n('ngsite')}</h2>
                <div class="shop-table-wrap">
                    <table class="shop-table product-spec-table">
                        {foreach $p_spec_rows as $p_spec_row}
                        <tr>
                            {foreach $p_spec_row.columns as $p_spec_i => $p_spec_cell}
                            {if $p_spec_i|eq(0)}
                            <th scope="row">{$p_spec_cell|wash}</th>
                            {else}
                            <td>{$p_spec_cell|wash}</td>
                            {/if}
                            {/foreach}
                        </tr>
                        {/foreach}
                    </table>
                </div>
            </section>
            {/if}
            {undef $p_spec_rows}
            {/if}

            {* Category, when shop.ini names an attribute to read it from. *}
            {def $p_category = ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
            {if and( $p_category, is_set( $p_map.$p_category ) )}
            <p class="product-category">
                {'Category'|i18n('ngsite')}: {attribute_view_gui attribute=$p_map.$p_category}
            </p>
            {/if}
            {undef $p_category}

        </div>
        {/explblock}

        {def $p_related = fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 8 ) )}
        {if $p_related}
        <section class="product-related">
            <h2>{'People who bought this also bought'|i18n('design/ezwebin/full/product')}</h2>
            <ul class="product-related-list">
                {foreach $p_related as $p_other}
                <li>
                    <a href={$p_other.main_node.url_alias|ezurl}>{$p_other.name|wash}</a>
                </li>
                {/foreach}
            </ul>
        </section>
        {/if}
        {undef $p_related}

        {* Reviews are 'review' objects published under this node, the same
           pattern comments use. The headline average is computed from the
           reviews themselves rather than the ezsrrating attribute: that one is
           an anonymous vote tally, this is the mean of what reviewers actually
           scored, and the two are not interchangeable. *}
        {def $p_reviews = fetch( 'content', 'list', hash(
                 'parent_node_id', $node.node_id,
                 'class_filter_type', 'include',
                 'class_filter_array', array( 'review' ),
                 'sort_by', array( array( 'published', false() ) ) ) )
             $p_may_review = fetch( 'content', 'access', hash(
                 'access', 'create', 'contentobject', $node, 'contentclass_id', 'review' ) )
             $p_review_total = 0
             $p_review_scored = 0}

        {foreach $p_reviews as $p_review}
            {if and( is_set( $p_review.data_map.rating ), $p_review.data_map.rating.has_content )}
                {set $p_review_total  = sum( $p_review_total, $p_review.data_map.rating.content )}
                {set $p_review_scored = sum( $p_review_scored, 1 )}
            {/if}
        {/foreach}

        {if or( $p_reviews|count()|gt(0), $p_may_review )}
        <section class="product-reviews">
            <h2>{'Customer reviews'|i18n('ngsite')}</h2>

            {if $p_review_scored|gt(0)}
            {* One decimal place: the round operator takes no precision argument,
               so scale, round, scale back. *}
            {def $p_review_avg = div( $p_review_total, $p_review_scored )}
            {def $p_review_shown = div( mul( $p_review_avg, 10 )|round, 10 )}
            <div class="product-reviews-summary">
                <span class="product-stars" style="--rating: {$p_review_avg};" aria-hidden="true"></span>
                <span class="product-rating-text">
                    {if $p_reviews|count()|eq(1)}
                        {'%average out of 5, from 1 review'|i18n( 'ngsite',,
                          hash( '%average', $p_review_shown ) )}
                    {else}
                        {'%average out of 5, from %count reviews'|i18n( 'ngsite',,
                          hash( '%average', $p_review_shown, '%count', $p_reviews|count() ) )}
                    {/if}
                </span>
            </div>
            {undef $p_review_avg $p_review_shown}
            {/if}

            {if $p_reviews|count()|gt(0)}
            <ol class="product-review-list">
                {foreach $p_reviews as $p_review_item}
                <li>{node_view_gui view='line' content_node=$p_review_item}</li>
                {/foreach}
            </ol>
            {else}
            <p class="product-reviews-empty">{'No reviews yet. Be the first.'|i18n('ngsite')}</p>
            {/if}

            {if $p_may_review}
            <form method="post" action={'content/action'|ezurl} class="product-review-form">
                <input type="hidden" name="ClassIdentifier" value="review" />
                <input type="hidden" name="NodeID" value="{$node.object.main_node.node_id}" />
                <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}" />
                <input class="btn btn-primary" type="submit" name="NewButton"
                       value="{'Write a review'|i18n('ngsite')}" />
            </form>
            {/if}
        </section>
        {/if}
        {undef $p_reviews $p_may_review $p_review_total $p_review_scored}

        {* Comments are stock eZ content: 'comment' objects published under this
           node. The product class has no enable_comments flag, so the section
           shows whenever the tree holds comments or the user may create one. *}
        {def $p_comments = fetch( 'content', 'list', hash(
                 'parent_node_id', $node.node_id,
                 'class_filter_type', 'include',
                 'class_filter_array', array( 'comment' ),
                 'sort_by', array( array( 'published', true() ) ) ) )
             $p_may_comment = fetch( 'content', 'access', hash(
                 'access', 'create', 'contentobject', $node, 'contentclass_id', 'comment' ) )}

        {if or( $p_comments|count()|gt(0), $p_may_comment )}
        <section class="product-comments">
            <h2>{'Customer comments'|i18n('ngsite')}</h2>

            {if $p_comments|count()|gt(0)}
            <ol class="product-comment-list">
                {foreach $p_comments as $p_comment}
                <li>{node_view_gui view='line' content_node=$p_comment}</li>
                {/foreach}
            </ol>
            {else}
            <p class="product-comments-empty">{'No comments yet.'|i18n('ngsite')}</p>
            {/if}

            {if $p_may_comment}
            <form method="post" action={'content/action'|ezurl} class="product-comment-form">
                <input type="hidden" name="ClassIdentifier" value="comment" />
                <input type="hidden" name="NodeID" value="{$node.object.main_node.node_id}" />
                <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}" />
                <input class="btn btn-secondary" type="submit" name="NewButton"
                       value="{'Write a comment'|i18n('ngsite')}" />
            </form>
            {else}
            <p class="product-comments-login">
                {'%login_link_startLog in%login_link_end or %create_link_startcreate an account%create_link_end to comment.'|i18n( 'ngsite',,
                   hash( '%login_link_start',  concat( '<a href="', '/user/login'|ezurl('no'), '">' ),
                         '%login_link_end',    '</a>',
                         '%create_link_start', concat( '<a href="', '/user/register'|ezurl('no'), '">' ),
                         '%create_link_end',   '</a>' ) )}
            </p>
            {/if}
        </section>
        {/if}
        {undef $p_comments $p_may_comment}
    </div>

</article>
{/explblock}

{undef $p_map $p_price $p_nodes}
