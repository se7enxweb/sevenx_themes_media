<?php

$eZTemplateOperatorArray = array(
    array(
        "script" => "extension/sevenx_themes_media/autoloads/sevenxthemesmediaoperators.php",
        "class" => "sevenxThemesMediaOperators",
        // Must list every operator in sevenxThemesMediaOperators::$Operators.
        // Registration is lazy: a name missing here resolves only if some other
        // operator from this class already loaded the file, so it works on some
        // pages and reports "Operator '<name>' is not registered" on others.
        "operator_names" => array( 'absolute_url', 'app', 'asset', 'content_link', 'content_tags', 'controller', 'tpl_block_template', 'item_view_template', 'tag_url', 'layout_title', 'embed_image', 'component_content', 'enhanced_link', 'fieldRelation', 'fieldRelations', 'fieldValue', 'firstNonEmptyField', 'filterChildren', 'filterFieldRelationLocations', 'filterFieldRelations', 'getParameter', 'get_netgen_open_graph', 'hasField', 'hasParameter', 'haveToPaginate', 'ibexa', 'ibexa_path', 'ibexa_url', 'image', 'image_link', 'intro', 'item_content_link', 'item_image_link', 'item_params', 'ng_image_alias', 'ng_query', 'ng_render_field', 'ng_view_content', 'nglayouts_render_result', 'nglayouts_render_zone', 'ngsite', 'ngsite_group_fields', 'ngsite_language_name', 'ngsite_topic_path', 'pagerfanta', 'parameter', 'parent', 'path', 'player', 'player_slide', 'poster', 'poster_slide', 'recipe_schema', 'redirect_to_site_root', 'render', 'render_esi', 'saveXML', 'title', 'trans' )
    )
);

?>