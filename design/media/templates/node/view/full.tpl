{* Full view of any class in the media design. A class gets a look of its own from
   content/views/full/<class>.tpl, found by item_view_template() without an override.ini rule;
   every other class is drawn by content/views/full.tpl. A class with its own override.ini rule
   for node/view/full.tpl never reaches this file. *}
{include uri=concat('design:', item_view_template('full', $node.class_identifier))
         node=$node object=$node.object content=$node.object location=$node view_type='full'
         view_parameters=first_set($view_parameters, hash())}
