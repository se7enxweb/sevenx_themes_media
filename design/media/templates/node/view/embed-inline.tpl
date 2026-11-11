{* The inline embed of any class in the media design: content/views/embed_inline/<class>.tpl when
   the class has one, else the generic content/views/embed_inline.tpl (a link with the name). *}
{include uri=concat('design:', item_view_template('embed_inline', $node.class_identifier))
         node=$node object=$node.object content=$node.object location=$node view_type='embed_inline'}
