{* mailpreferences/admin/categories in the media design: the categories of e-mail as the cards of Your devices
   (acc-session), each with its kind as a badge, its description and the facts list (how often, confirmation,
   defined in), and the form to edit one or make a new one in an account card. Replaces the kernel's template, whose
   six-column table squeezed the names and descriptions into a narrow column of the media design.
   Variables: categories (hash( identifier, name, description, essential, frequencies, double_opt_in, source,
   editable, removable )), edit (the category being edited, the same hash, or false), form (the values typed, after an
   error), notice, frequency_names (hash( immediate, daily, weekly => label )). *}
{include uri='design:mailpreferences/parts/page_start.tpl'
         title='E-mail preferences: categories'|i18n( 'design/admin/mailpreferences' )
         intro='Each e-mail the system sends belongs to a category. People turn optional categories on and off on their preference page; essential ones are always sent and are listed there with their description.'|i18n( 'design/admin/mailpreferences' )
         crumb=false() wide=true() admin_tab='categories'}
{def $source_names = hash( 'ini', 'Settings file'|i18n( 'design/admin/mailpreferences' ),
                           'admin', 'Made here'|i18n( 'design/admin/mailpreferences' ),
                           'extension', 'Extension'|i18n( 'design/admin/mailpreferences' ) )}

{include uri='design:mailpreferences/parts/notice.tpl' notice=first_set( $notice, false() )}

<section class="mp-card mp-cats" aria-labelledby="mp-cats-title">
    <h2 id="mp-cats-title">{'Categories'|i18n( 'design/admin/mailpreferences' )} <span class="acc-count">{$categories|count}</span></h2>
    <ul class="acc-session-list">
{foreach $categories as $category}
        <li class="acc-session">
            <h3>{$category.name|wash} <code>{$category.identifier|wash}</code>
                {if $category.essential}<span class="mp-badge">{'Essential, always sent'|i18n( 'design/admin/mailpreferences' )}</span>{else}<span class="mp-badge on">{'Optional, off until turned on'|i18n( 'design/admin/mailpreferences' )}</span>{/if}</h3>
{if $category.description|ne( '' )}
            <p>{$category.description|wash}</p>
{/if}
            <dl class="acc-facts">
                <dt>{'How often'|i18n( 'design/admin/mailpreferences' )}</dt>
                <dd>{if $category.frequencies|count|gt( 0 )}{foreach $category.frequencies as $frequency}{if is_set( $frequency_names[$frequency] )}{$frequency_names[$frequency]}{else}{$frequency|wash}{/if}{delimiter}, {/delimiter}{/foreach}{else}&mdash;{/if}</dd>
                <dt>{'Confirmation'|i18n( 'design/admin/mailpreferences' )}</dt>
                <dd>{if $category.double_opt_in}{'Double opt-in'|i18n( 'design/admin/mailpreferences' )}{else}&mdash;{/if}</dd>
                <dt>{'Defined in'|i18n( 'design/admin/mailpreferences' )}</dt>
                <dd>{if is_set( $source_names[$category.source] )}{$source_names[$category.source]}{else}{$category.source|wash}{/if}</dd>
            </dl>
{if $category.editable}
            <div class="mp-actions">
                <a class="mp-btn small outline" href={concat( 'mailpreferences/admin/categories/', $category.identifier )|ezurl}>{'Edit'|i18n( 'design/admin/mailpreferences' )}<span class="mp-sr"> {$category.name|wash}</span></a>
            </div>
{/if}
        </li>
{/foreach}
    </ul>
</section>

{def $values = cond( $edit, $edit, first_set( $form, false() ), first_set( $form, false() ), hash( 'identifier', '', 'name', '', 'description', '', 'essential', false(), 'frequencies', array(), 'double_opt_in', false() ) )}
<section class="mp-card" id="mp-category-form" aria-labelledby="mp-category-form-title">
    <h2 id="mp-category-form-title">{if $edit}{'Edit "%name"'|i18n( 'design/admin/mailpreferences',, hash( '%name', $edit.name ) )|wash}{else}{'New category'|i18n( 'design/admin/mailpreferences' )}{/if}</h2>
{if and( $edit, $edit.source|ne( 'admin' ) )}
    <p class="mp-lead">{'This category is defined in %source. What you change here is stored in the database and shown instead; the identifier and the kind stay as they are defined.'|i18n( 'design/admin/mailpreferences',, hash( '%source', cond( is_set( $source_names[$edit.source] ), $source_names[$edit.source], $edit.source ) ) )|wash}</p>
{elseif $edit|not}
    <p class="mp-lead">{'A new category is optional: nobody receives it until they turn it on. Code sends e-mail in it with eZMail::setCategory( identifier ).'|i18n( 'design/admin/mailpreferences' )}</p>
{/if}
    <form method="post" action={'mailpreferences/admin/categories'|ezurl}>
{if $edit}
        <input type="hidden" name="Identifier" value="{$edit.identifier|wash}" />
        <p class="mp-hint">{'Identifier:'|i18n( 'design/admin/mailpreferences' )} <code>{$edit.identifier|wash}</code></p>
{else}
        <div class="mp-field">
            <label for="mp-cat-identifier">{'Identifier'|i18n( 'design/admin/mailpreferences' )}</label>
            <input type="text" id="mp-cat-identifier" name="Identifier" value="{$values.identifier|wash}" pattern="[a-z][a-z0-9_]*" maxlength="64" required="required" aria-describedby="mp-cat-identifier-hint" />
            <span class="mp-hint" id="mp-cat-identifier-hint">{'Lower case letters, digits and underscores; it cannot be changed later.'|i18n( 'design/admin/mailpreferences' )}</span>
        </div>
{/if}
        <div class="mp-field">
            <label for="mp-cat-name">{'Name'|i18n( 'design/admin/mailpreferences' )}</label>
            <input type="text" id="mp-cat-name" name="Name" value="{$values.name|wash}" maxlength="255" required="required" />
        </div>
        <div class="mp-field">
            <label for="mp-cat-description">{'Description, as people see it on their preference page'|i18n( 'design/admin/mailpreferences' )}</label>
            <textarea id="mp-cat-description" name="Description" rows="3">{$values.description|wash}</textarea>
        </div>
{if or( $edit|not, $edit.source|eq( 'admin' ) )}
        <fieldset class="mp-fieldset">
            <legend>{'How often people may choose to get it'|i18n( 'design/admin/mailpreferences' )}</legend>
{foreach $frequency_names as $frequency => $label}
            <label class="mp-check"><input type="checkbox" name="Frequencies[]" value="{$frequency|wash}"{if $values.frequencies|contains( $frequency )} checked="checked"{/if} /> <span>{$label|wash}</span></label>
{/foreach}
            <span class="mp-hint">{'None ticked: it is sent when it happens, with no choice of frequency.'|i18n( 'design/admin/mailpreferences' )}</span>
        </fieldset>
        <label class="mp-check"><input type="checkbox" name="DoubleOptIn" value="1"{if $values.double_opt_in} checked="checked"{/if} /> <span>{'Ask for a confirmation by e-mail before the first message (double opt-in; use it for newsletters and marketing)'|i18n( 'design/admin/mailpreferences' )}</span></label>
{/if}
        <div class="mp-actions">
            <input class="mp-btn primary" type="submit" name="{if $edit}StoreCategoryButton{else}CreateCategoryButton{/if}" value="{if $edit}{'Save'|i18n( 'design/admin/mailpreferences' )}{else}{'Create category'|i18n( 'design/admin/mailpreferences' )}{/if}" />
{if $edit}
            <a class="mp-btn outline" href={'mailpreferences/admin/categories'|ezurl}>{'Cancel'|i18n( 'design/admin/mailpreferences' )}</a>
{if $edit.source|ne( 'admin' )}
            <input class="mp-btn outline" type="submit" name="ResetCategoryButton" value="{'Use the defined name and description again'|i18n( 'design/admin/mailpreferences' )}" />
{elseif $edit.removable}
            <input class="mp-btn danger" type="submit" name="RemoveCategoryButton" value="{'Remove this category'|i18n( 'design/admin/mailpreferences' )}" />
{/if}
{/if}
        </div>
    </form>
</section>
{undef $values $source_names}

{include uri='design:mailpreferences/parts/page_end.tpl'}
