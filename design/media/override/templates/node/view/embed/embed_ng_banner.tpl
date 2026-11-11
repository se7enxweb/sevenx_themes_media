{* The embed view of ng_banner through node_view_gui: drawn by its item view content/views/embed/ng_banner.tpl, the one
   the layouts blocks use too, with the variables that view reads. *}
{include uri='design:content/views/embed/ng_banner.tpl' node=$node object=$node.object content=$node.object location=$node view_type='embed' with_intro=first_set($with_intro, true())}
