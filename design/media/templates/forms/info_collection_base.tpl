{* FILTER $None|spaceless *}
    {def $attributes = hash()}

    {if and(hasField($content, 'gtm_event_prefix'), not($content.fields.gtm_event_prefix['empty']))}
        {def $attributes = $attributes|merge(hash('data-gtm-event-prefix', $content.fields.gtm_event_prefix.value.text))}
    {/if}

    {if and(is_set($class), not($class|count()|eq(0)))}
        {def $attributes = $attributes|merge(hash('class', $class))}
    {/if}

    {def $form_parameters = hash('action', first_set($action, ''), 'attr', $attributes)}
{* ENDFILTER *}

{if not($is_collected)}
    {$twig_block_form_body}
{else}
    {* BLOCK form_response *}
        <div class="full-form-response">
            {if not($content.fields.success_text['empty'])}
                {ng_render_field($content.fields.success_text)}
            {else}
                <p>{$'ngsite.collected_info.success_text'|trans}</p>
            {/if}
        </div>
    {* ENDBLOCK form_response *}
{/if}