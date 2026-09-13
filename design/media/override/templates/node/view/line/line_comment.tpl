{* Comment line view for the media design.

   The stock 'comment' class carries subject (ezstring), author (ezstring) and
   message (eztext). Author is a free text field the commenter fills in, so it
   is washed and never trusted as markup; the object owner is shown instead
   when the field was left empty. *}

{def $c_map = $node.object.data_map}

<article class="comment-item">
    <header class="comment-item-head">
        {if and( is_set( $c_map.subject ), $c_map.subject.has_content )}
        <h3 class="comment-item-subject">{$c_map.subject.content|wash}</h3>
        {/if}
        <p class="comment-item-meta">
            <span class="comment-item-author">
                {if and( is_set( $c_map.author ), $c_map.author.has_content )}
                    {$c_map.author.content|wash}
                {else}
                    {$node.object.owner.name|wash}
                {/if}
            </span>
            <time datetime="{$node.object.published|datetime( 'custom', '%Y-%m-%d' )}">
                {$node.object.published|l10n( 'shortdate' )}
            </time>
        </p>
    </header>

    {if and( is_set( $c_map.message ), $c_map.message.has_content )}
    <div class="comment-item-body">{$c_map.message.content|wash|nl2br}</div>
    {/if}
</article>

{undef $c_map}
