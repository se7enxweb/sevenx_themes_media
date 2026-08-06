{def $ls_language_codes = array()}

{if is_array($module_result.content_info)}
    {if is_set($module_result.content_info.node_id)}
        {if $module_result.content_info.node_id|gt(0)}
            {def $ls_node = fetch('content','node',hash('node_id',$module_result.content_info.node_id))}
            {if $ls_node}
                {set $ls_language_codes = $ls_node.object.language_codes}
            {/if}
        {/if}
    {/if}
{/if}

{if $ls_language_codes|count|gt(1)}
    <div class="language-selector dropdown">
        <button data-bs-toggle="dropdown" class="current-lang" aria-label="{'Change language'|i18n('design/media/pagelayout')}" aria-controls="langSelector" aria-expanded="false">
            {$ls_language_codes[0]}&nbsp;<i class="icon-angle-down"></i>
        </button>

        <ul class="dropdown-menu" id="langSelector">
        {foreach $ls_language_codes as $ls_index => $ls_language_code}
            {if $ls_index|eq(0)}
                <li class="current"><a href="#" data-toggle="dropdown">{$ls_language_code}</a></li>
            {else}
                <li><a href={concat('/switchlanguage/to/',$ls_language_code)|ezurl} aria-label="{$ls_language_code}">{$ls_language_code}</a></li>
            {/if}
        {/foreach}
        </ul>
    </div>
{/if}

{undef $ls_language_codes}
