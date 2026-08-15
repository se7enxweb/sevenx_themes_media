<div class="view-component view-component-ad ad-block ad-block-{$block.view_type}">
    {if and(is_set($cmp.data_map.html_code), $cmp.data_map.html_code.has_content)}
        {$cmp.data_map.html_code.content}
    {else}
        <p class="empty">Ad content missing.</p>
    {/if}
</div>
