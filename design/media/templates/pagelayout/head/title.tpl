{def $site_title = first_set($site_name, '')}
{def $page_title = ''}
{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {def $title_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
            {if $title_node}
                {def $title_meta = metadata($title_node.node_id)}
                {set $page_title = $title_node.name}
                {if $title_meta}
                    {if $title_meta.title|ne('')}
                        {set $page_title = $title_meta.title}
                    {/if}
                {/if}
                {undef $title_meta}
            {/if}
        {/if}
    {/if}
{/if}
{* An error page's path ends in the error's code ("kernel (20)"), which means
   nothing to a visitor. Head it with what its page says instead, in the same
   words as its error/<type>/<number>.tpl. A refused form (kernel 6) already has a
   readable path of its own and keeps it; any error without a page of its own
   here is headed "Error". *}
{if and( $page_title|eq(''), is_set($module_result.errorType) )}
    {def $title_error_key = concat($module_result.errorType, '/', first_set($module_result.errorNumber, ''))}
    {switch match=$title_error_key}
    {case match='kernel/1'}
        {if $current_user.is_logged_in}
            {set $page_title = 'You don\'t have access to this page'|i18n('design/media/error')}
        {else}
            {set $page_title = 'Please sign in to see this page'|i18n('design/media/error')}
        {/if}
    {/case}
    {case in=array('kernel/2', 'kernel/20', 'kernel/21')}{set $page_title = 'We couldn\'t find that page'|i18n('design/media/error')}{/case}
    {case match='kernel/3'}{set $page_title = 'This page isn\'t available'|i18n('design/media/error')}{/case}
    {case match='kernel/4'}{set $page_title = 'This page has moved'|i18n('design/media/error')}{/case}
    {case match='kernel/5'}{set $page_title = 'This page isn\'t available in that language'|i18n('design/media/error')}{/case}
    {case match='kernel/6'}{/case}
    {case match='kernel/22'}{set $page_title = 'This part of the site is switched off'|i18n('design/media/error')}{/case}
    {case match='kernel/50'}{set $page_title = 'We\'ll be right back'|i18n('design/media/error')}{/case}
    {case match='shop/1'}{set $page_title = 'This item can\'t be bought'|i18n('design/media/error')}{/case}
    {case match='shop/2'}{set $page_title = 'This product can\'t be added to your basket'|i18n('design/media/error')}{/case}
    {case match='shop/3'}{set $page_title = 'That currency isn\'t available'|i18n('design/media/error')}{/case}
    {case match='shop/4'}{set $page_title = 'That currency isn\'t available at the moment'|i18n('design/media/error')}{/case}
    {case}{set $page_title = 'Error'|i18n('design/media/error')}{/case}
    {/switch}
    {undef $title_error_key}
{/if}
{* A module view - a tag page, for instance - has no node to take a name
   from, so the title fell back to the site name alone and every one of them
   was headed "Fit & Healthy". What such a page is about is in the module
   result path, and its last element is the page itself. *}
{if $page_title|eq('')}
    {if is_array($module_result.path)}
        {foreach $module_result.path as $title_path_element}
            {if is_set($title_path_element.text)}
                {if $title_path_element.text|ne('')}
                    {set $page_title = $title_path_element.text}
                {/if}
            {/if}
        {/foreach}
    {/if}
{/if}
{if $page_title|ne('')}
    {if $page_title|ne($site_name)}
        {set $site_title = concat($page_title, cond($site_title|count|gt(0), concat(' - ', $site_title), ''))}
    {else}
        {set $site_title = $page_title}
    {/if}
{/if}
<title>{$site_title|wash}</title>
{undef $page_title}
