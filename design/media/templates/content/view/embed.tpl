{* An object embedded in rich text, in the media design. The editor's embed classes that list the
   object's children (itemized_sub_items, vertically_listed_sub_items, horizontally_listed_sub_items,
   itemized_subtree_items) draw content/view/embed/sub_items.tpl; every other embed draws the
   object's embed view, content/views/embed/<class>.tpl or the generic content/views/embed.tpl, the
   same files node_view_gui view=embed uses. No override.ini rule is needed for any class. *}
{def $ce_node = $object.main_node
     $ce_class = first_set($classification, '')}
{if $ce_node}
    {if array('itemized_sub_items', 'vertically_listed_sub_items', 'horizontally_listed_sub_items', 'itemized_subtree_items')|contains($ce_class)}
        {include uri='design:content/view/embed/sub_items.tpl' node=$ce_node object=$object classification=$ce_class}
    {else}
        <div class="embed{if $ce_class|ne('')} {$ce_class|wash}{/if}">
        {include uri='design:node/view/embed.tpl' node=$ce_node with_intro=true()}
        </div>
    {/if}
{/if}
{undef $ce_node $ce_class}
