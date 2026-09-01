{def $view_type = 'full'}



{* EXTENDS design:$nglayouts.layoutTemplate *}

{explblock name='content'}
    <div class="view-type view-type-{$view_type} ng-htmlbox">
        {$content.fields.html_code.value.text}
    </div>
{/explblock}