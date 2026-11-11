{* The line view of any class in the media design: content/views/line/<class>.tpl when the class has
   one, else the generic content/views/line.tpl. No override.ini rule is needed for a new class. *}
{include uri=concat('design:', item_view_template('line', $node.class_identifier))
         node=$node object=$node.object content=$node.object location=$node view_type='line' with_intro=first_set($with_intro, true())}
