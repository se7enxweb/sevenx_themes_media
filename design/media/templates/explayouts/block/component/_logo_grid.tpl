{* Logo grid from the logos relation list. Param: cmp, logo_limit (0 = all) *}
{def $lg_logos = fieldRelations($cmp, 'logos')}
{def $lg_count = 0}
{def $lg_max = first_set($logo_limit, 0)}
<div class="logo-grid">
    {foreach $lg_logos as $lg_logo}
        {if or($lg_max|eq(0), $lg_count|lt($lg_max))}
        {def $lg_map = $lg_logo.data_map}
        {if and(is_set($lg_map.logo_svg), $lg_map.logo_svg.has_content)}
        <div class="logo-grid-item">
            <img src={concat('/var/site/storage/original/image/', $lg_map.logo_svg.content.filename)|ezroot} alt="{$lg_logo.name|wash}" />
        </div>
        {elseif and(is_set($lg_map.logo), $lg_map.logo.has_content)}
        {def $lg_img = $lg_map.logo.content}
        {if is_set($lg_img['original'])}
        <div class="logo-grid-item">
            <img src={$lg_img['original'].url|ezroot} alt="{$lg_logo.name|wash}" />
        </div>
        {/if}
        {undef $lg_img}
        {/if}
        {set $lg_count = $lg_count|sum(1)}
        {undef $lg_map}
        {/if}
    {/foreach}
</div>
{undef $lg_logos $lg_count $lg_max}
