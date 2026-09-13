{* Review edit form for the media design.

   Selected by the [content/edit#review] rule the override.ini generator emits
   for every template under override/templates/edit/.

   Field names are the ones content/edit reads:

     ContentObjectAttribute_id[]                        which attributes to store
     ContentObjectAttribute_ezstring_data_text_<id>     title, author (ezstring)
     ContentObjectAttribute_data_text_<id>              body (eztext)
     ContentObjectAttribute_data_int_<id>               rating (ezinteger)
     PublishButton  DiscardButton  MainNodeID  DiscardConfirm

   verified_purchase is deliberately not on this form: it is an editor's
   assertion, not something a reviewer gets to claim about themselves. *}

{def $r_title  = $object.data_map.title
     $r_rating = $object.data_map.rating
     $r_author = $object.data_map.author
     $r_body   = $object.data_map.body
     $r_user   = fetch( 'user', 'current_user' )
     $r_parent = false()}

{if $main_node_id}
    {set $r_parent = fetch( 'content', 'node', hash( 'node_id', $main_node_id ) )}
{/if}

<header class="full-page-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title">{'Write a review'|i18n('ngsite')}</h1>
        {if $r_parent}
        <p class="form-page-subject">
            {'on %title'|i18n( 'ngsite',, hash( '%title', $r_parent.name|wash ) )}
        </p>
        {/if}
    </div>
</header>

<div class="full-form-content">
    <div class="container">

        {include uri='design:content/edit_validation.tpl'}

        <form enctype="multipart/form-data" method="post" name="ReviewEdit" class="embed-form"
              action={concat( '/content/edit/', $object.id, '/', $edit_version,
                              '/', cond( $edit_language, concat( $edit_language, '/' ), '' ) )|ezurl}>
            <div class="form-wrapper">

                <div class="form-group">
                    <label for="ReviewRating" class="form-label">{'Your rating'|i18n('ngsite')}</label>
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$r_rating.id}" />
                    <select class="form-control" id="ReviewRating"
                            name="ContentObjectAttribute_data_int_{$r_rating.id}">
                        {for 1 to 5 as $r_star}
                        <option value="{$r_star}"{if $r_rating.content|eq($r_star)} selected="selected"{/if}>
                            {$r_star} / 5
                        </option>
                        {/for}
                    </select>
                </div>

                <div class="form-group">
                    <label for="ReviewTitle" class="form-label">{'Headline'|i18n('ngsite')}</label>
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$r_title.id}" />
                    <input class="form-control" type="text" id="ReviewTitle"
                           name="ContentObjectAttribute_ezstring_data_text_{$r_title.id}"
                           value="{$r_title.content|wash}" />
                </div>

                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$r_author.id}" />
                {if $r_user.is_logged_in}
                    <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$r_author.id}"
                           value="{$r_user.contentobject.name|wash}" />
                {else}
                <div class="form-group">
                    <label for="ReviewAuthor" class="form-label">{'Your name'|i18n('ngsite')}</label>
                    <input class="form-control" type="text" id="ReviewAuthor"
                           name="ContentObjectAttribute_ezstring_data_text_{$r_author.id}"
                           value="{$r_author.content|wash}" />
                </div>
                {/if}

                <div class="form-group">
                    <label for="ReviewBody" class="form-label">{'Your review'|i18n('ngsite')}</label>
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$r_body.id}" />
                    <textarea class="form-control" id="ReviewBody" rows="8"
                              name="ContentObjectAttribute_data_text_{$r_body.id}">{$r_body.content|wash}</textarea>
                </div>

                <div class="buttonblock clearfix">
                    <input class="btn btn-primary" type="submit" name="PublishButton"
                           value="{'Post review'|i18n('ngsite')}" />
                    <input class="btn btn-secondary" type="submit" name="DiscardButton"
                           value="{'Cancel'|i18n('ngsite')}" />
                    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
                    <input type="hidden" name="DiscardConfirm" value="0" />
                </div>

            </div>
        </form>
    </div>
</div>

{undef $r_title $r_rating $r_author $r_body $r_user $r_parent}
