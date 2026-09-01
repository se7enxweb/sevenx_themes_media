{def $ls_current_node = false()}

{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {set $ls_current_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
        {/if}
    {/if}
{/if}

{def $ls_translations = array()}
{if and(is_object($ls_current_node), $ls_current_node.url_alias|ne(''))}
    {set $ls_translations = language_switcher($ls_current_node.url_alias)}
{else}
    {set $ls_translations = language_switcher('')}
{/if}

{if $ls_translations|count|gt(1)}
    {def $ls_current_siteaccess = ''}
    {def $ls_current_translation = false()}

    {def $ls_current_locale = ezini('RegionalSettings','Locale')}

    {* Pick the current siteaccess by matching the translation locale to the
       current siteaccess locale. The language switcher URL for the current
       siteaccess is then the one we display as the active language. *}
    {foreach $ls_translations as $ls_siteaccess => $ls_translation}
        {if $ls_translation.locale|eq($ls_current_locale)}
            {set $ls_current_siteaccess = $ls_siteaccess}
            {set $ls_current_translation = $ls_translation}
        {elseif $ls_current_siteaccess|eq('')}
            {* Fallback: use the first entry as the current one if nothing matched. *}
            {set $ls_current_siteaccess = $ls_siteaccess}
            {set $ls_current_translation = $ls_translation}
        {/if}
    {/foreach}

    <div class="language-selector dropdown">
        <button data-bs-toggle="dropdown" class="current-lang" aria-label="Change language" aria-controls="langSelector" aria-expanded="false">
            {$ls_current_translation.text|wash}&nbsp;<i class="icon-angle-down" aria-hidden="true"></i>
        </button>

        <ul class="dropdown-menu" id="langSelector">
        {foreach $ls_translations as $ls_siteaccess => $ls_translation}
            {if $ls_siteaccess|eq($ls_current_siteaccess)}
                <li class="current"><a href="#" data-toggle="dropdown">{$ls_translation.text|wash}</a></li>
            {else}
                <li><a href={$ls_translation.url|ezurl} aria-label="{$ls_translation.text|wash}">{$ls_translation.text|wash}</a></li>
            {/if}
        {/foreach}
        </ul>
    </div>

    {undef $ls_current_siteaccess $ls_current_translation}
{/if}

{undef $ls_current_node $ls_translations}
