{* The embed view of any class in the media design: content/views/embed/<class>.tpl when the class has
   one, else the generic content/views/embed.tpl. No override.ini rule is needed for a new class. *}
{include uri=concat('design:', item_view_template('embed', $node.class_identifier))
         node=$node object=$node.object content=$node.object location=$node view_type='embed' with_intro=first_set($with_intro, true())}
