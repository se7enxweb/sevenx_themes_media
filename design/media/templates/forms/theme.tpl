{* EXTENDS design:bootstrap_5_layout.tpl *}{* BLOCK form_start *}{def $_ = setMethodRendered($form)}
    {def $method = $method|upcase}{if $method|contains(array('GET', 'POST'))}{def $form_method = $method}{else}{def $form_method = 'POST'}{/if}<form{if $name|ne('')} name="{$name}"{/if} method="{$form_method|downcase}"{if $action|ne('')} action="{$action}"{/if}{$twig_block_attributes}{if $multipart} enctype="multipart/form-data"{/if} novalidate>{if $form_method|ne($method)}<input type="hidden" name="_method" value="{$method}" />{/if}{* ENDBLOCK form_start *}{* BLOCK form_row *}{if $compound}{form_widget($form, hash('ngparams', first_set($ngparams, hash())))}{else}
        <div class="form-group {$form.parent.vars.name|ristring('_', '-')}{if $errors|count|gt(0)} error-input{/if}">{if or(('checkbox'|contains($block_prefixes)), ('radio'|contains($block_prefixes)))}{form_widget($form)}{form_label($form)}{form_errors($form)}{else}{form_label($form)}{form_widget($form)}{form_errors($form)}{/if}</div>
    {/if}{* ENDBLOCK form_row *}{* BLOCK form_errors *}{if $errors|count|gt(0)}<ul class="errors">{foreach $errors as $error}<li>{$error.message}</li>{/foreach}</ul>{/if}{* ENDBLOCK form_errors *}{* BLOCK _ibexa_forms_create_user_user_account_row *}{form_errors($form)}{form_widget($form)}{* ENDBLOCK _ibexa_forms_create_user_user_account_row *}{* BLOCK _ibexa_forms_create_user_user_account_widget *}{foreach $form as $identifier => $child}
        {if $identifier|eq('password')}
            {form_row($child.first, hash('attr', $attr))}

            {form_row($child.second, hash('attr', $attr))}
        {else}
            {form_row($child, hash('attr', $attr))}
        {/if}
    {/foreach}{* ENDBLOCK _ibexa_forms_create_user_user_account_widget *}{* BLOCK widget_attributes *}id="{$id}" name="{$full_name}"{if $disabled} disabled="disabled"{/if}{if $required} required="required"{/if}{$twig_block_attributes}{* ENDBLOCK widget_attributes *}{* BLOCK attributes *}{foreach $attr as $attrname => $attrvalue}{$' '}{if $attrname|contains(array('placeholder', 'title'))}{$attrname}="{cond(or(($translation_domain|eq(false)), ($attrvalue|eq(null))), $attrvalue, $attrvalue|trans($attr_translation_parameters, $translation_domain))}"
        {elseif $attrvalue|eq(true)}{$attrname}="{$attrname}"
        {elseif not($attrvalue|eq(false))}{$attrname}="{$attrvalue}"{/if}{/foreach}{* ENDBLOCK attributes *}{* BLOCK textarea_row *}<div class="form-group {$form.parent.vars.name|ristring('_', '-')}{if $errors|count|gt(0)} error-input{/if}">{form_label($form)}{$twig_block_textarea_widget}{form_errors($form)}</div>{* ENDBLOCK textarea_row *}{* BLOCK textarea_widget *}<textarea class="form-control" {$twig_block_widget_attributes}>{$value}</textarea>{* ENDBLOCK textarea_widget *}{* BLOCK email_row *}<div class="form-group {$form.parent.vars.name|ristring('_', '-')}{if $errors|count|gt(0)} error-input{/if}">{form_label($form)}{$twig_block_email_widget}{form_errors($form)}</div>{* ENDBLOCK email_row *}{* BLOCK email_widget *}{def $type = first_set($type, 'email')}{$twig_block_form_widget_simple}{* ENDBLOCK email_widget *}{* BLOCK text_row *}{if and(is_set($hidden), $hidden)}
        {$twig_block_form_widget_simple}{form_errors($form)}{else}
        <div class="form-group {$form.parent.vars.name|ristring('_', '-')}{if $errors|count|gt(0)} error-input{/if}">{form_label($form)}{form_widget($form)}{form_errors($form)}</div>
    {/if}{* ENDBLOCK text_row *}{* BLOCK form_widget_simple *}{if is_set($hidden)}
        {if $hidden}{def $type = 'hidden'}{/if}
    {/if}{def $type = first_set($type, 'text')}{if or(($type|eq('range')), ($type|eq('color')))}{def $required = false}{/if}<input class="form-control" type="{$type}"
        {$twig_block_widget_attributes}
        {if not($value|count()|eq(0))}value="{$value}"{/if}
        {if is_set($ngparams.autocomplete)} autocomplete="{$ngparams.autocomplete}"{/if}
        {if $type|ne('hidden')} aria-invalid="false" aria-errormessage="error-{$form.vars.id}"{/if}
    />
    {if $type|ne('hidden')}
        {def $error_label = first_set($ngparams.label, $form.vars.label)}
        <span id="error-{$form.vars.id}" class="error-message">{$'ngsite.collected_info.form_errors.enter_valid_value'|trans} {$error_label}</span>
    {/if}{* ENDBLOCK form_widget_simple *}{* BLOCK hidden_row *}{$twig_block_hidden_widget}{form_errors($form)}{* ENDBLOCK hidden_row *}{* BLOCK hidden_widget *}{def $type = first_set($type, 'hidden')}{$twig_block_form_widget_simple}{* ENDBLOCK hidden_widget *}{* BLOCK file_row *}
    <div class="form-group file-group {first_set($form.parent.parent.vars, $form.parent.vars).name|ristring('_', '-')}{if $errors|count|gt(0)} error-input{/if}">
        <label class="form-label{if $required} required{/if}" for={$id}>{first_set($ngparams.label, first_set($label|trans($label_translation_parameters, $translation_domain), 'File'))}
            {if $required}
                <span aria-hidden="true">*</span>
                <span class="sr-only">{$'ngsite.collected_info.mandatory_field'|trans}</span>
            {/if}
        </label>{form_widget($form)}{form_errors($form)}</div>

    {if is_set($form.parent.children.remove)}
        {def $_ = setRendered($form.parent.children.remove)}
    {/if}
{* ENDBLOCK file_row *}


{* BLOCK form_widget_compound *}{if $form|rootform()}{form_errors($form)}{/if}{$twig_block_form_rows}{form_rest($form)}{* ENDBLOCK form_widget_compound *}{* BLOCK checkbox_widget *}{def $label_checkbox = first_set($label, '')}<input type="checkbox" class="form-check-input" {$twig_block_widget_attributes}{if is_set($value)} value="{$value}"{/if}{if $checked} checked="checked"{/if} />
    <label class="form-label" for={$id} aria-invalid="false"
        aria-errormessage="error-{$form.vars.id}" />
        {first_set($ngparams.label, $label_checkbox)}
    </label>
    <span id="error-{$form.vars.id}" class="error-message">{$form.vars.label} {$'ngsite.collected_info.form_errors.not_checked'|trans}</span>{* ENDBLOCK checkbox_widget *}{* BLOCK checkbox_row *}<div class="form-group form-check {$form.parent.vars.name|ristring('_', '-')}{if $errors|count|gt(0)} error-input{/if}">{form_widget($form)}{form_label($form)}{form_errors($form)}</div>{* ENDBLOCK checkbox_row *}{* BLOCK honeypot_row *}
    {form_row($form.value, hash('required', false, 'attr', hash('tabindex', (-1))))}
{* ENDBLOCK honeypot_row *}{* BLOCK form_rows *}{def $__fe_source_1 = $form|rejectattr('rendered')}{foreach $__fe_source_1 as $child}{form_row($child, hash('ngparams', $ngparams))}{/foreach}{* ENDBLOCK form_rows *}{* BLOCK form_label *}{if not($label|eq(false))}{def $parent_label_class = first_set($parent_label_class, first_set($label_attr.class, ''))}{if and(is_set($compound), $compound)}{def $element = 'legend'}{if 'col-form-label'|eq($parent_label_class)}{def $label_attr = $label_attr|merge(hash('class', concat(first_set($label_attr.class, ''), ' col-form-label')|trim))}{/if}{else}{def $row_class = first_set($row_class, first_set($row_attr.class, ''))}{def $label_attr = $label_attr|merge(hash('for', $id))}{if 'col-form-label'|eq($parent_label_class)}{def $label_attr = $label_attr|merge(hash('class', concat(first_set($label_attr.class, ''), cond(('input-group'|contains($row_class)), ' input-group-text', ' form-label'))|trim))}{/if}{/if}{if not($compound)}{def $label_attr = $label_attr|merge(hash('for', $id))}{/if}{if $required}{def $label_attr = $label_attr|merge(hash('class', concat(first_set($label_attr.class, ''), ' required')|trim))}{/if}{if $label|count()|eq(0)}{if not($label_format|count()|eq(0))}{def $label = $label_format|ristring(array('%name%', '%id%'), array($name, $id))}{else}{def $label = $name|humanize}{/if}{/if}<{first_set($element, 'label')}{if $label_attr}{$twig_block_attributes}{/if}>{if $translation_domain|eq(false)}{if $label_html|eq(false)}{$label}{else}{$label}{/if}{else}{if $label_html|eq(false)}{$label|trans($label_translation_parameters, $translation_domain)}{else}{$label|trans($label_translation_parameters, $translation_domain)}{/if}{/if}{if $required}
                <span aria-hidden="true">*</span>
                <span class="sr-only">{$'ngsite.collected_info.mandatory_field'|trans}</span>
            {/if}
        </{first_set($element, 'label')}>{/if}{* ENDBLOCK form_label *}{* BLOCK checkbox_radio_label *}{if is_set($widget)}{def $label_attr = $label_attr|merge(hash('class', concat(first_set($label_attr.class, ''), ' form-check-label')|trim))}{if not($compound)}{def $label_attr = $label_attr|merge(hash('for', $id))}{/if}{if $required}{def $label_attr = $label_attr|merge(hash('class', concat(first_set($label_attr.class, ''), ' required')|trim))}{/if}{if is_set($parent_label_class)}{def $label_attr = $label_attr|merge(hash('class', concat(first_set($label_attr.class, ''), ' ', $parent_label_class)|ristring(array('checkbox-inline', 'radio-inline'), array('', ''))|trim))}{/if}{if and(not($label|eq(false)), ($label|count()|eq(0)))}{if not($label_format|count()|eq(0))}{def $label = $label_format|ristring(array('%name%', '%id%'), array($name, $id))}{else}{def $label = $name|humanize}{/if}{/if}{$widget}
        <label{$twig_block_attributes}>{if not($label|eq(false))}{if $translation_domain|eq(false)}{if $label_html|eq(false)}{$label}{else}{$label}{/if}{else}{if $label_html|eq(false)}{$label|trans($label_translation_parameters, $translation_domain)}{else}{$label|trans($label_translation_parameters, $translation_domain)}{/if}{/if}{if $required}
                    <span aria-hidden="true">*</span>
                    <span class="sr-only">{$'ngsite.collected_info.mandatory_field'|trans}</span>
                {/if}{/if}</label>{/if}{* ENDBLOCK checkbox_radio_label *}