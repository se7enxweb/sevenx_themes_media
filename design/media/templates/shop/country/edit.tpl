{* Country selector for the media design.

   Identical to design/standard/templates/shop/country/edit.tpl apart from the
   select carrying a caller-supplied class, so the field matches the rest of
   the form. The standard template hardcodes an unclassed <select>, which left
   the country field unstyled next to every form-control input around it.

   select_class defaults to form-control; pass select_class='' to opt out.

   Country names are also no longer truncated. The standard template shortens
   every name to 20 characters, which was fine for the narrow fixed-width
   select it was written for but cuts real names in a full-width one:
   'Saint Vincent and...', 'Virgin Islands, B...'. Pass max_len to shorten
   them again. *}

{if is_set( $countries ) | not }
    {def $countries = fetch( 'content', 'country_list' )}
{/if}
{default $max_len = 0
    $select_size = 1
    $select_class = 'form-control'}

<select name="{$select_name}" size="{$select_size}"{if $select_class|ne('')} class="{$select_class}"{/if}>
{if and( is_set( $default_val ), is_set( $default_desc ) )}
    <option {if eq( $current_val, false )}selected="selected"{/if} value="{$default_val}">{$default_desc|wash}</option>
{/if}
{foreach $countries as $country}
    <option {if eq( $country['Name'], $current_val )} selected="selected" {/if} value="{if $use_country_code}{$country['Alpha2']}{else}{$country['Name']}{/if}">
    {if gt( $max_len, 0 )}{$country['Name']|shorten($max_len)}{else}{$country['Name']|wash}{/if}
    </option>
{/foreach}
</select>
{/default}
