{* Mirrors templates/themes/app/pagelayout/breadcrumbs.html.twig:
   root item with home icon, linked/no-link middle items, current page as
   no-link with aria-current. Hidden until the path is deeper than 2. *}
{if and($show_path, gt($path_array|count,2))}
    <nav class="breadcrumb-wrapper" aria-label="breadcrumbs">
        <ol>
            <li class="breadcrumb-item">
                <a href={$path_array[0].url|ezurl}>
                    <i class="icon-home" aria-hidden="true"></i>
                    <span>{$path_array[0].text|wash}</span>
                </a>
            </li>
            {foreach $path_array as $bc_index => $path_item}
                {if $bc_index|gt(0)}
                    {if not($path_item.url)}
                    <li class="breadcrumb-item breadcrumb-item--no-link"><span{if $bc_index|eq($path_array|count|sub(1))} aria-current="location"{/if}>{$path_item.text|wash}</span></li>
                    {else}
                    <li class="breadcrumb-item breadcrumb-item--link"><a href={$path_item.url|ezurl}{if $bc_index|eq($path_array|count|sub(1))} aria-current="location"{/if}><span>{$path_item.text|wash}</span></a></li>
                    {/if}
                {/if}
            {/foreach}
        </ol>
    </nav>
{/if}
