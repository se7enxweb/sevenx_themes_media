{* Comment edit form for the media design.

   Selected by the [edit_comment] rule already present in
   settings/siteaccess/site/override.ini.append.php (Source=content/edit.tpl,
   Match[class_identifier]=comment). Without a copy in this design the rule
   resolved to design/base's version, which renders raw unstyled inputs flush
   to the viewport edge, with labels that come out empty because
   contentclass_attribute.name does not resolve in this context.

   Styled like the other forms in this design: full-page-header +
   full-form-content + form-group/form-control/btn.

   Every field name the content/edit module reads is preserved:

     ContentObjectAttribute_id[]                        which attributes to store
     ContentObjectAttribute_ezstring_data_text_<id>     subject, author (ezstring)
     ContentObjectAttribute_data_text_<id>              message (eztext)
     PublishButton  DiscardButton  MainNodeID  DiscardConfirm

   Unlike design/base, the author attribute id is posted in the logged-in
   branch too. Base emits the hidden value without listing the id, so the
   module never stores it and a logged-in commenter ends up with no name. *}

{def $c_subject = $object.data_map.subject
     $c_author  = $object.data_map.author
     $c_message = $object.data_map.message
     $c_user    = fetch( 'user', 'current_user' )
     $c_parent  = false()}

{if $main_node_id}
    {set $c_parent = fetch( 'content', 'node', hash( 'node_id', $main_node_id ) )}
{/if}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Write a comment'|i18n('ngsite')}</h1>
        {if $c_parent}
        <p class="form-page-subject">
            {'on %title'|i18n( 'ngsite',, hash( '%title', $c_parent.name|wash ) )}
        </p>
        {/if}
    </div>
</header>

<div class="full-form-content">
    <div class="container">

        {include uri='design:content/edit_validation.tpl'}

        <form enctype="multipart/form-data" method="post" name="CommentEdit" class="embed-form"
              action={concat( '/content/edit/', $object.id, '/', $edit_version,
                              '/', cond( $edit_language, concat( $edit_language, '/' ), '' ) )|ezurl}>
            <div class="form-wrapper">

                <div class="form-group">
                    <label for="CommentSubject" class="form-label">{'Subject'|i18n('ngsite')}</label>
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$c_subject.id}" />
                    <input class="form-control" type="text" id="CommentSubject"
                           name="ContentObjectAttribute_ezstring_data_text_{$c_subject.id}"
                           value="{$c_subject.content|wash}" />
                </div>

                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$c_author.id}" />
                {if $c_user.is_logged_in}
                    <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$c_author.id}"
                           value="{$c_user.contentobject.name|wash}" />
                {else}
                <div class="form-group">
                    <label for="CommentAuthor" class="form-label">{'Your name'|i18n('ngsite')}</label>
                    <input class="form-control" type="text" id="CommentAuthor"
                           name="ContentObjectAttribute_ezstring_data_text_{$c_author.id}"
                           value="{$c_author.content|wash}" />
                </div>
                {/if}

                <div class="form-group">
                    <label for="CommentMessage" class="form-label">{'Comment'|i18n('ngsite')}</label>
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$c_message.id}" />
                    <textarea class="form-control" id="CommentMessage" rows="8"
                              name="ContentObjectAttribute_data_text_{$c_message.id}">{$c_message.content|wash}</textarea>
                </div>

                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" name="PublishButton"
                           value="{'Post comment'|i18n('ngsite')}" />
                    <input class="btn btn-secondary" type="submit" name="DiscardButton"
                           value="{'Cancel'|i18n('ngsite')}" />
                    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
                    <input type="hidden" name="DiscardConfirm" value="0" />
                </div>

            </div>
        </form>
    </div>
</div>

{undef $c_subject $c_author $c_message $c_user $c_parent}
