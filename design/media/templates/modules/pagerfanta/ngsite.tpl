

<nav class="page-navigation" role="navigation" aria-label="{$'pagination.title'|trans}">
    <ul>

        
        {if $pages.mobile_first_page}
            <li class="page-item d-block d-sm-none"><a href="{$pages.mobile_first_page}" class="page-link" aria-label="{$'pagination.go_to_first_page'|trans}"><i class="icon-angles-left"></i></a></li>
        {/if}

        
        {if $pages.previous_page}
            <li class="page-item"><a href="{$pages.previous_page}" class="page-link" rel="prev" aria-label="{$'pagination.go_to_previous_page'|trans}">{$'pagination.previous'|trans}</a></li>
        {/if}

        
        {if $pages.first_page}
            <li class="page-item d-none d-sm-block"><a href="{$pages.first_page}" class="page-link" aria-label="{$'pagination.go_to_first_page'|trans}">1</a></li>
        {/if}

        
        {if $pages.second_page}
            <li class="page-item d-none d-sm-block"><a href="{$pages.second_page}" class="page-link" aria-label="{$'pagination.go_to_second_page'|trans}">2</a></li>
        {/if}

        
        {if $pages.separator_before}
            <li class="page-item disabled d-none d-sm-block"><span class="page-link page-link-separate">...</span></li>
        {/if}

        
        {foreach $pages.middle_pages as $page => $page_url}
            {if $page|eq($pager.currentPage)}
                <li class="page-item current"><span class="page-link">{$page}<span class="d-inline d-sm-none"> of {$pager.nbPages}</span></span></li>
            {else}
                <li class="page-item d-none d-sm-block"><a href="{$page_url}" class="page-link" aria-label="{concat('pagination.go_to_page'|trans, ' ', $page)}" aria-current="true">{$page}</a></li>
            {/if}
        {/foreach}

        
        {if $pages.separator_after}
            <li class="page-item disabled d-none d-sm-block"><span class="page-link page-link-separate">...</span></li>
        {/if}

        
        {if $pages.second_to_last_page}
            <li class="page-item d-none d-sm-block"><a href="{$pages.second_to_last_page}" class="page-link" aria-label="{$'pagination.go_to_second_to_last_page'|trans}">{$pager.nbPages|sub(1)}</a></li>
        {/if}

        
        {if $pages.last_page}
            <li class="page-item d-none d-sm-block"><a href="{$pages.last_page}" class="page-link" aria-label="{$'pagination.go_to_last_page'|trans}">{$pager.nbPages}</a></li>
        {/if}

        
        {if $pages.next_page}
            <li class="page-item"><a href="{$pages.next_page}" class="page-link" rel="next" aria-label="{$'pagination.go_to_next_page'|trans}">{$'pagination.next'|trans}</a></li>
        {/if}

        
        {if $pages.mobile_last_page}
            <li class="page-item d-block d-sm-none"><a href="{$pages.mobile_last_page}" class="page-link" aria-label="{$'pagination.go_to_last_page'|trans}"><i class="icon-angles-right"></i></a></li>
        {/if}

    </ul>
</nav>