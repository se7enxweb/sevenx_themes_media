{* The validation messages of the edit form (content/edit) in the media design, as the design's notices.
   Strings and variables of design/standard. *}
{if $validation.processed}
    {if or( $validation.attributes, $validation.placement, $validation.custom_rules )}
<div class="acc-notice error" role="alert">
    <div>
    {if or( and( $validation.attributes, $validation.placement ), $validation.custom_rules )}
        <h2>{'Validation failed'|i18n( 'design/standard/content/edit' )}</h2>
    {elseif $validation.attributes}
        <h2>{'Input did not validate'|i18n( 'design/standard/content/edit' )}</h2>
    {else}
        <h2>{'Location did not validate'|i18n( 'design/standard/content/edit' )}</h2>
    {/if}
        <ul>
    {if $validation.placement}{foreach $validation.placement as $item}
            <li>{$item.text}</li>
    {/foreach}{/if}
    {if $validation.attributes}{foreach $validation.attributes as $item}
            <li>{$item.name|wash}: {$item.description}</li>
    {/foreach}{/if}
    {if $validation.custom_rules}{foreach $validation.custom_rules as $item}
            <li>{$item.text}</li>
    {/foreach}{/if}
        </ul>
    </div>
</div>
    {elseif first_set( $validation_log, false() )}
<div class="acc-notice warning" role="status">
    <div>
        <h2>{'Input was partially stored'|i18n( 'design/standard/content/edit' )}</h2>
    {foreach $validation_log as $log}
        <p><b>{$log.name|wash}:</b></p>
        <ul>
        {foreach $log.description as $message}
            <li>{$message}</li>
        {/foreach}
        </ul>
    {/foreach}
    </div>
</div>
    {else}
<div class="acc-notice success" role="status">
    <p><b>{'Input was stored successfully'|i18n( 'design/standard/content/edit' )}</b></p>
</div>
    {/if}
{/if}
