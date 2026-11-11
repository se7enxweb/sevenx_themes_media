{* The embed view of any class in the media design: content/views/embed/<class>.tpl when the class
   has one, else the generic content/views/embed.tpl. No override.ini rule is needed for a new class.
   Drawn through ng_view_content(), which gives the view the $content and $location it reads. *}
{ng_view_content($node, 'embed', hash('with_intro', first_set($with_intro, true())))}
