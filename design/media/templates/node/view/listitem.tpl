{* The listitem view of any class in the media design: content/views/listitem/<class>.tpl when the class has
   one, else the generic content/views/listitem.tpl. No override.ini rule is needed for a new class. *}
{include uri=concat('design:', item_view_template('listitem', $node.class_identifier))
         node=$node object=$node.object content=$node.object location=$node view_type='listitem' with_intro=first_set($with_intro, true())}
