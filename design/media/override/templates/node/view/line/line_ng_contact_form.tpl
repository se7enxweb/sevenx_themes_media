{* The line view of ng_contact_form through node_view_gui: drawn by its item view content/views/line/ng_contact_form.tpl, the one
   the layouts blocks use too, with the variables that view reads. *}
{include uri='design:content/views/line/ng_contact_form.tpl' node=$node object=$node.object content=$node.object location=$node view_type='line' with_intro=first_set($with_intro, true())}
