{default page_uri_suffix=false()
         left_max=2
         right_max=2}

{let page_count=int( ceil( div( $item_count, $item_limit ) ) )
      current_page=min( $:page_count, int( ceil( div( first_set( $view_parameters.offset, 0 ), $item_limit ) ) ) )
      item_previous=sub( mul( $:current_page, $item_limit ), $item_limit )
      item_next=sum( mul( $:current_page, $item_limit ), $item_limit )

      left_length=min( $:current_page, $left_max )
      right_length=max( min( sub( $:page_count, $:current_page, 1 ), $right_max ), 0 )
      view_parameter_text=""
      offset_text=eq( ezini( 'ControlSettings', 'AllowUserVariables', 'template.ini' ), 'true' )|choose( '/offset/', '/(offset)/' )}

{* Build view parameter text (excluding offset) *}
{section loop=$view_parameters}
    {section-exclude match=$:key|eq('offset')}
    {section-exclude match=$:item|eq('')}
    {set view_parameter_text=concat( $:view_parameter_text, '/(', $:key, ')/', $:item )}
{/section}

{section show=$:page_count|gt(1)}
<nav class="page-navigation" role="navigation" aria-label="Pagination navigation">
    <ul>

        {* Previous page *}
        {switch match=$:item_previous|lt(0)}
            {case match=0}
                <li class="page-item">
                    <a href={concat( $page_uri, $:item_previous|gt(0)|choose( '', concat( $:offset_text, $:item_previous ) ), $:view_parameter_text, $page_uri_suffix )|ezurl} class="page-link" rel="prev" aria-label="Go to previous page">{"Previous"|i18n("design/standard/navigator")}</a>
                </li>
            {/case}
            {case match=1}
            {/case}
        {/switch}

        {* First page *}
        {if $:current_page|gt($:left_max)}
            <li class="page-item d-none d-sm-block">
                <a href={concat( $page_uri, $:view_parameter_text, $page_uri_suffix )|ezurl} class="page-link" aria-label="Go to page 1">1</a>
            </li>
            {if sub( $:current_page, $:left_length )|gt(1)}
                <li class="page-item disabled d-none d-sm-block"><span class="page-link page-link-separate">...</span></li>
            {/if}
        {/if}

        {* Left pages *}
        {section loop=$:left_length}
            {let page_offset=sum( sub( $:current_page, $:left_length ), $:index )}
                <li class="page-item d-none d-sm-block">
                    <a href={concat( $page_uri, $:page_offset|gt(0)|choose( '', concat( $:offset_text, mul( $:page_offset, $item_limit ) ) ), $:view_parameter_text, $page_uri_suffix )|ezurl} class="page-link" aria-label="Go to page {$:page_offset|inc}">{$:page_offset|inc}</a>
                </li>
            {/let}
        {/section}

        {* Current page *}
        <li class="page-item current">
            <span class="page-link">{$:current_page|inc}<span class="d-inline d-sm-none"> of {$:page_count}</span></span>
        </li>

        {* Right pages *}
        {section loop=$:right_length}
            {let page_offset=sum( $:current_page, 1, $:index )}
                <li class="page-item d-none d-sm-block">
                    <a href={concat( $page_uri, $:offset_text, mul( $:page_offset, $item_limit ), $:view_parameter_text, $page_uri_suffix )|ezurl} class="page-link" aria-label="Go to page {$:page_offset|inc}">{$:page_offset|inc}</a>
                </li>
            {/let}
        {/section}

        {* Last page *}
        {if $:page_count|gt( sum( $:current_page, $:right_max, 1 ) )}
            {if sum( $:current_page, $:right_max, 2 )|lt( $:page_count )}
                <li class="page-item disabled d-none d-sm-block"><span class="page-link page-link-separate">...</span></li>
            {/if}
            <li class="page-item d-none d-sm-block">
                <a href={concat( $page_uri, $:offset_text, mul( $:page_count|dec, $item_limit ), $:view_parameter_text, $page_uri_suffix )|ezurl} class="page-link" aria-label="Go to page {$:page_count}">{$:page_count}</a>
            </li>
        {/if}

        {* Next page *}
        {switch match=$:item_next|lt($item_count)}
            {case match=1}
                <li class="page-item">
                    <a href={concat( $page_uri, $:offset_text, $:item_next, $:view_parameter_text, $page_uri_suffix )|ezurl} class="page-link" rel="next" aria-label="Go to next page">{"Next"|i18n("design/standard/navigator")}</a>
                </li>
            {/case}
            {case}
            {/case}
        {/switch}

    </ul>
</nav>
{/section}

{/let}
{/default}
