{* Previous / next for the administrator's lists in the media design: the count on one side, the design's outlined
   buttons on the other. Replaces the kernel's parts/pager.tpl, whose mp-pager styles the media design does not load.
   Variables: page_uri (the list's address), total, offset, limit, query (the filters as view parameters, or ''). *}
{if $total|gt( $limit )}
{def $query_string = first_set( $query, '' )}
<nav class="mp-pager" aria-label="{'Pages'|i18n( 'design/admin/mailpreferences' )}">
    <p>{'%from to %to of %total'|i18n( 'design/admin/mailpreferences',, hash( '%from', sum( $offset, 1 ), '%to', min( sum( $offset, $limit ), $total ), '%total', $total ) )}</p>
    <div class="mp-actions">
{if $offset|gt( 0 )}
        <a class="mp-btn small outline" href={concat( $page_uri, '/(offset)/', max( 0, sub( $offset, $limit ) ), $query_string )|ezurl}>{'Previous'|i18n( 'design/admin/mailpreferences' )}</a>
{/if}
{if sum( $offset, $limit )|lt( $total )}
        <a class="mp-btn small outline" href={concat( $page_uri, '/(offset)/', sum( $offset, $limit ), $query_string )|ezurl}>{'Next'|i18n( 'design/admin/mailpreferences' )}</a>
{/if}
    </div>
</nav>
{undef $query_string}
{/if}
