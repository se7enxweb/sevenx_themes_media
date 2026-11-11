{* The embed view of ng_audio through node_view_gui: drawn by its item view content/views/embed/ng_audio.tpl, the one
   the layouts blocks use too, through ng_view_content(), which gives it the $content and $location it reads. *}
{ng_view_content($node, 'embed', hash('with_intro', first_set($with_intro, true())))}
