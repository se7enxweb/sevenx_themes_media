{* Review line view for the media design.

   The 'review' class carries title (ezstring), rating (ezinteger 1-5), author
   (ezstring), body (eztext) and verified_purchase (ezboolean).

   author is free text the reviewer fills in, so it is washed and never trusted
   as markup; the object owner is shown when it was left empty. The stars are
   the same read-only display the product header uses. *}

{def $v_map = $node.object.data_map}

<article class="review-item">
    <header class="review-item-head">
        {if and( is_set( $v_map.rating ), $v_map.rating.has_content )}
        <span class="product-stars" style="--rating: {$v_map.rating.content};" aria-hidden="true"></span>
        <span class="review-item-score">{$v_map.rating.content}/5</span>
        {/if}

        {if and( is_set( $v_map.title ), $v_map.title.has_content )}
        <h3 class="review-item-title">{$v_map.title.content|wash}</h3>
        {/if}

        <p class="review-item-meta">
            <span class="review-item-author">
                {if and( is_set( $v_map.author ), $v_map.author.has_content )}
                    {$v_map.author.content|wash}
                {else}
                    {$node.object.owner.name|wash}
                {/if}
            </span>
            <time datetime="{$node.object.published|datetime( 'custom', '%Y-%m-%d' )}">
                {$node.object.published|l10n( 'shortdate' )}
            </time>
            {if and( is_set( $v_map.verified_purchase ), $v_map.verified_purchase.content )}
            <span class="review-item-verified">{'Verified purchase'|i18n('ngsite')}</span>
            {/if}
        </p>
    </header>

    {if and( is_set( $v_map.body ), $v_map.body.has_content )}
    <div class="review-item-body">{$v_map.body.content|wash|nl2br}</div>
    {/if}
</article>

{undef $v_map}
