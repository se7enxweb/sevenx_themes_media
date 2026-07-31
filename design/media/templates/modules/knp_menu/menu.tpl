{* EXTENDS design:@KnpMenu/menu.tpl *}



{* BLOCK item *}
    {if $item.displayed}
        {def $classes = cond(not(attribute($item, 'class')|count()|eq(0)), array(attribute($item, 'class')), array())}

        
        
            
        
        {if isAncestor($matcher, $item, $options.matchingDepth)}{def $classes = $classes|merge(array($options.ancestorClass))}{/if}{if $item.actsLikeFirst}{def $classes = $classes|merge(array($options.firstClass))}{/if}{if $item.actsLikeLast}{def $classes = $classes|merge(array($options.lastClass))}{/if}

        {if and($item.hasChildren, not($options.depth|eq(0)))}{if and(not($options.branch_class|count()|eq(0)), $item.displayChildren)}{def $classes = $classes|merge(array($options.branch_class))}{/if}
        {elseif not($options.leaf_class|count()|eq(0))}{def $classes = $classes|merge(array($options.leaf_class))}{/if}{def $attributes = $item.attributes}{if not($classes|count()|eq(0))}{def $attributes = $attributes|merge(hash('class', $classes|implode(' ')))}{/if}

        {if and(is_set($item.extras.ibexa_location), not($item.extras.ibexa_location|count()|eq(0)))}{def $attributes = $attributes|merge(hash('data-location-id', $item.extras.ibexa_location.id))}{/if}
        

        
        {* IMPORT $_self AS knp_menu *}
        <li{attributes($knp_menu, $attributes)}>{if and(not($item.uri|count()|eq(0)), or(not(isCurrent($matcher, $item)), $options.currentAsLink))}
                {$twig_block_linkElement}{else}
                {$twig_block_spanElement}{/if}

            {def $childrenClasses = cond(not(childrenAttribute($item, 'class')|count()|eq(0)), array(childrenAttribute($item, 'class')), array())}{def $childrenClasses = $childrenClasses|merge(array(concat('menu_level_', $item.level)))}{def $listAttributes = $item.childrenAttributes|merge(hash('class', $childrenClasses|implode(' ')))}

            {$twig_block_list}
        </li>
    {/if}
{* ENDBLOCK item *}