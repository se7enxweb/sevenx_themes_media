<?php

class sevenxThemesMediaField implements ArrayAccess
{
    protected $value;
    protected $empty;

    public function __construct( $value, $empty )
    {
        $this->value = $value;
        $this->empty = (bool)$empty;
    }

    public function attribute( $name )
    {
        if ( $name === 'value' )
            return $this->value;
        if ( $name === 'empty' )
            return $this->empty;
        if ( is_array( $this->value ) && array_key_exists( $name, $this->value ) )
            return $this->value[$name];
        return null;
    }

    public function hasAttribute( $name )
    {
        if ( in_array( $name, array( 'value', 'empty' ) ) )
            return true;
        return is_array( $this->value ) && array_key_exists( $name, $this->value );
    }

    public function offsetExists( $offset ): bool
    {
        if ( $offset === 'empty' || $offset === 'value' )
            return true;
        return is_array( $this->value ) && array_key_exists( $offset, $this->value );
    }

    #[\ReturnTypeWillChange]
    public function offsetGet( $offset )
    {
        if ( $offset === 'empty' )
            return $this->empty;
        if ( $offset === 'value' )
            return $this->value;
        return $this->offsetExists( $offset ) ? $this->value[$offset] : null;
    }

    public function offsetSet( $offset, $value ): void
    {
    }

    public function offsetUnset( $offset ): void
    {
    }
}

class sevenxThemesMediaOperators
{
    public $Operators = array( 'absolute_url', 'app', 'asset', 'content_link', 'content_tags', 'controller', 'tpl_block_template', 'layout_title', 'embed_image', 'component_content', 'enhanced_link', 'fieldRelation', 'fieldRelations', 'fieldValue', 'firstNonEmptyField', 'filterChildren', 'filterFieldRelationLocations', 'filterFieldRelations', 'getParameter', 'get_netgen_open_graph', 'hasField', 'hasParameter', 'haveToPaginate', 'ibexa', 'ibexa_path', 'ibexa_url', 'image', 'image_link', 'intro', 'item_content_link', 'item_image_link', 'item_params', 'ng_image_alias', 'ng_query', 'ng_render_field', 'ng_view_content', 'nglayouts_render_result', 'nglayouts_render_zone', 'ngsite', 'ngsite_group_fields', 'ngsite_language_name', 'ngsite_topic_path', 'pagerfanta', 'parameter', 'parent', 'path', 'player', 'player_slide', 'poster', 'poster_slide', 'recipe_schema', 'redirect_to_site_root', 'render', 'render_esi', 'saveXML', 'title', 'trans' );
    public $MaxParam = 10;

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        $def = array_fill( 0, $this->MaxParam, array( "type" => "mixed", "required" => false, "default" => null ) );
        $list = array();
        foreach ( $this->Operators as $op )
        {
            $list[$op] = $def;
        }
        return $list;
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        $arg0 = $operatorValue !== null ? $operatorValue : ( isset( $namedParameters[0] ) ? $namedParameters[0] : null );
        $arg1 = isset( $namedParameters[1] ) ? $namedParameters[1] : null;

        switch ( $operatorName )
        {
            case 'ngsite':
                $operatorValue = $this->ngsiteGlobals();
                break;

            case 'app':
                $operatorValue = $this->appGlobals();
                break;

            case 'ibexa':
                $operatorValue = $this->ibexaGlobals();
                break;

            case 'trans':
                $operatorValue = $this->trans( $arg0, $arg1 );
                break;

            case 'path':
            case 'ibexa_path':
            case 'ibexa_url':
            case 'absolute_url':
            case 'content_link':
            case 'item_content_link':
            case 'image_link':
            case 'item_image_link':
                $operatorValue = $this->getUrl( $arg0, in_array( $operatorName, array( 'absolute_url', 'ibexa_url' ) ) );
                break;

            case 'asset':
                $operatorValue = $this->designUrl( $arg0, $arg1 );
                break;

            case 'image':
            case 'ng_image_alias':
            case 'poster':
            case 'item_image_link':
                $operatorValue = $this->getImageUrl( $arg0, $arg1 );
                break;

            case 'title':
            case 'intro':
                $arg2 = isset( $namedParameters[2] ) ? $namedParameters[2] : null;
                $operatorValue = $this->getText( $arg0, $arg1, $operatorName, $arg2 );
                break;

            case 'ng_render_field':
                $operatorValue = $this->renderField( $arg0, $arg1 );
                break;

            case 'ng_view_content':
                $arg2 = isset( $namedParameters[2] ) ? $namedParameters[2] : null;
                $operatorValue = $this->viewContent( $arg0, $arg1, $arg2 );
                break;

            case 'nglayouts_render_result':
            case 'nglayouts_render_zone':
                $operatorValue = $this->renderLayout( $arg0, $namedParameters, $operatorName );
                break;

            case 'parameter':
            case 'getParameter':
                $operatorValue = $this->getParam( $arg0, $arg1 );
                break;

            case 'hasParameter':
                $operatorValue = $this->hasParam( $arg0, $arg1 );
                break;

            case 'firstNonEmptyField':
                $fields = array();
                for ( $i = 1; $i < count( $namedParameters ); $i++ )
                {
                    if ( isset( $namedParameters[$i] ) && $namedParameters[$i] !== null )
                        $fields[] = $namedParameters[$i];
                }
                $operatorValue = $this->firstNonEmptyField( $arg0, $fields );
                break;

            case 'hasField':
                $operatorValue = $this->hasField( $arg0, $arg1 );
                break;

            case 'content_tags':
                $operatorValue = $this->contentTags( $arg0, $arg1 );
                break;

            case 'tpl_block_template':
                $operatorValue = $this->tplBlockTemplate( $arg0 );
                break;

            case 'recipe_schema':
                $operatorValue = $this->recipeSchema( $arg0 );
                break;

            case 'layout_title':
                $operatorValue = $this->layoutTitle( $arg0 );
                break;

            case 'embed_image':
                $operatorValue = $this->embedImage( $arg0, $arg1 );
                break;

            case 'component_content':
                $operatorValue = $this->componentContent( $arg0 );
                break;

            case 'enhanced_link':
                $operatorValue = $this->enhancedLink( $arg0 );
                break;

            case 'fieldValue':
                $operatorValue = $this->getField( $arg0, $arg1 );
                break;

            case 'fieldRelations':
            case 'fieldRelation':
                $operatorValue = $this->getRelations( $arg0, $arg1 );
                break;

            case 'filterChildren':
            case 'filterFieldRelationLocations':
            case 'filterFieldRelations':
                $operatorValue = $this->filterChildren( $arg0,
                                                         $arg1 !== null ? $arg1 : array(),
                                                         isset( $namedParameters[2] ) ? (int)$namedParameters[2] : 100 );
                break;

            case 'parent':
                $operatorValue = $this->getParent( $arg0 );
                break;

            case 'get_netgen_open_graph':
                $operatorValue = $this->openGraph( $arg0 );
                break;

            case 'saveXML':
                $operatorValue = $this->saveXML( $arg0 );
                break;

            case 'ng_query':
                $operatorValue = $this->ngQuery( $arg0, $tpl );
                break;

            case 'pagerfanta':
            case 'haveToPaginate':
            case 'controller':
            case 'render':
            case 'render_esi':
            case 'player':
            case 'player_slide':
            case 'poster_slide':
            case 'ngsite_group_fields':
            case 'ngsite_language_name':
            case 'ngsite_topic_path':
                $operatorValue = '';
                break;

            case 'item_params':
            {
                // Mirrors the reference toolbar macro: data-item + content/location ids.
                $ipNode = $this->toNode( isset( $namedParameters[2] ) ? $namedParameters[2] : $arg1 );
                if ( !$ipNode )
                    $ipNode = $this->toNode( $arg1 );
                if ( $ipNode instanceof eZContentObjectTreeNode )
                {
                    $operatorValue = 'data-item="true" data-content-id="' . (int)$ipNode->attribute( 'contentobject_id' ) . '" data-location-id="' . (int)$ipNode->attribute( 'node_id' ) . '"';
                }
                else
                {
                    $operatorValue = '';
                }
            } break;

            case 'redirect_to_site_root':
            {
                $rootNodeId = (int)eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' );
                $rootNode = eZContentObjectTreeNode::fetch( $rootNodeId );
                $url = $rootNode instanceof eZContentObjectTreeNode ? '/' . $rootNode->attribute( 'url_alias' ) : '/';
                eZHTTPTool::redirect( $url );
                eZExecution::cleanExit();
            } break;

            default:
                $operatorValue = '<!--[sevenxThemesMedia:' . $operatorName . ']-->';
        }
    }

    protected function ngQuery( $queryType, $tpl )
    {
        // Only handle 'subtree' query type; others return empty string
        if ( $queryType !== 'subtree' )
        {
            return '';
        }

        // Resolve current node from template variables
        $node = $tpl->variable( 'node' );
        if ( !($node instanceof eZContentObjectTreeNode) )
        {
            $node = $tpl->variable( 'location' );
        }
        if ( !($node instanceof eZContentObjectTreeNode) )
        {
            return '';
        }

        // Read control fields from the category's data map
        $dataMap = $node->dataMap();

        // children_class_filter_include: text field, split on whitespace/commas
        $childrenClassFilter = array();
        if ( isset( $dataMap['children_class_filter_include'] ) )
        {
            $attr = $dataMap['children_class_filter_include'];
            if ( $attr instanceof eZContentObjectAttribute && $attr->hasContent() )
            {
                $text = trim( (string)$attr->content() );
                if ( $text )
                {
                    // Split on whitespace and/or commas
                    $classes = preg_split( '/[\s,]+/', $text, -1, PREG_SPLIT_NO_EMPTY );
                    if ( is_array( $classes ) && count( $classes ) > 0 )
                    {
                        $childrenClassFilter = $classes;
                    }
                }
            }
        }

        // page_limit: int > 0, default 12
        $pageLimit = 12;
        if ( isset( $dataMap['page_limit'] ) )
        {
            $attr = $dataMap['page_limit'];
            if ( $attr instanceof eZContentObjectAttribute && $attr->hasContent() )
            {
                $val = (int)$attr->content();
                if ( $val > 0 )
                {
                    $pageLimit = $val;
                }
            }
        }

        // fetch_subtree: bool, depth 1 if false, unlimited (null) if true
        $depth = 1;
        if ( isset( $dataMap['fetch_subtree'] ) )
        {
            $attr = $dataMap['fetch_subtree'];
            if ( $attr instanceof eZContentObjectAttribute && $attr->hasContent() )
            {
                $content = $attr->content();
                if ( $content )
                {
                    $depth = false; // false means unlimited depth in subTreeByNodeID
                }
            }
        }

        // Fetch children using the same API as filterChildren()
        $params = array(
            'ClassFilterType' => count( $childrenClassFilter ) > 0 ? 'include' : 'exclude',
            'ClassFilterArray' => $childrenClassFilter,
            'Limit' => $pageLimit,
            'SortBy' => $node->attribute( 'sort_array' ),
            'Depth' => $depth,
        );

        $children = eZContentObjectTreeNode::subTreeByNodeID( $params, $node->attribute( 'node_id' ) );
        return is_array( $children ) ? $children : array();
    }

    protected function ngsiteGlobals()
    {
        $siteObject = null;
        $remoteID = eZINI::instance( 'menu.ini' )->variable( 'SiteInfo', 'RemoteID' );
        if ( $remoteID )
        {
            $siteObject = eZContentObject::fetchByRemoteID( $remoteID );
        }

        if ( !$siteObject )
        {
            $classID = eZContentClass::classIDByIdentifier( 'ng_site_info' );
            if ( $classID )
            {
                $objects = eZContentObject::fetchSameClassList( $classID, true );
                if ( is_array( $objects ) && count( $objects ) > 0 )
                {
                    $siteObject = reset( $objects );
                }
            }
        }

        $fields = array();
        if ( $siteObject instanceof eZContentObject )
        {
            $dataMap = $siteObject->dataMap();
            foreach ( $dataMap as $identifier => $attr )
            {
                $fields[$identifier] = $this->wrapAttribute( $attr );
            }
        }

        return array(
            'siteInfoContent' => array(
                'fields' => $fields,
                'name' => $siteObject ? $siteObject->attribute( 'name' ) : '',
            ),
        );
    }

    protected function appGlobals()
    {
        $locale = eZINI::instance()->variable( 'RegionalSettings', 'Locale' );
        $sys = eZSys::instance();
        $host = eZINI::instance()->variable( 'SiteSettings', 'SiteURL' );
        $scheme = eZSys::isSSLNow() ? 'https' : 'http';
        $port = eZSys::serverPort();
        $httpHost = $host . ( $port ? ':' . $port : '' );

        return array(
            'request' => array(
                'locale' => $locale,
                'schemeAndHttpHost' => $scheme . '://' . $httpHost,
            ),
        );
    }

    protected function ibexaGlobals()
    {
        $rootNodeId = (int)eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' );
        if ( $rootNodeId < 1 )
            $rootNodeId = 1;

        $rootNode = eZContentObjectTreeNode::fetch( $rootNodeId );
        $rootName = $rootNode ? $rootNode->attribute( 'name' ) : '';
        $rootUrl = $rootNode ? (string)$rootNode->attribute( 'url_alias' ) : '';

        $languages = eZINI::instance()->variable( 'RegionalSettings', 'SiteLanguageList' );
        if ( !is_array( $languages ) )
            $languages = array( $languages );

        return array(
            'rootLocation' => array(
                'url_alias' => $rootUrl,
                'path' => $rootUrl,
                'content' => array(
                    'name' => $rootName,
                ),
            ),
            'configResolver' => array(
                'parameters' => array(
                    'languages' => $languages,
                ),
            ),
            'availableLanguages' => $languages,
        );
    }

    protected function wrapAttribute( $attr )
    {
        if ( !$attr instanceof eZContentObjectAttribute )
        {
            return new sevenxThemesMediaField( array(), true );
        }

        $empty = !$attr->hasContent();
        $dataType = $attr->attribute( 'data_type_string' );
        $value = array();

        switch ( $dataType )
        {
            case 'ezstring':
            case 'eztext':
            case 'ezemail':
                $value = array( 'text' => $attr->toString() );
                break;

            case 'ezxmltext':
                $text = $this->renderAttribute( $attr, array() );
                $xml = '';
                $xmlObj = $attr->content();
                if ( $xmlObj instanceof eZXMLText )
                    $xml = (string)$xmlObj->attribute( 'xml_data' );
                $value = array( 'text' => $text, 'xml' => $xml );
                break;

            case 'ezurl':
                $url = (string)$attr->content();
                $value = array( 'link' => $url, 'text' => $url );
                break;

            case 'ezimage':
                $url = '';
                $width = 0;
                $height = 0;
                $alt = '';
                $handler = $attr->content();
                if ( $handler instanceof eZImageAliasHandler )
                {
                    $original = $handler->imageAlias( 'original' );
                    if ( $original )
                    {
                        $url = isset( $original['url'] ) ? $original['url'] : '';
                        $width = isset( $original['width'] ) ? (int)$original['width'] : 0;
                        $height = isset( $original['height'] ) ? (int)$original['height'] : 0;
                        $alt = isset( $original['alternative_text'] ) ? (string)$original['alternative_text'] : '';
                    }
                }
                $value = array(
                    'uri' => $url,
                    'id' => (int)$attr->attribute( 'id' ),
                    'alternativeText' => $alt,
                    'width' => $width,
                    'height' => $height,
                );
                break;

            case 'ezbinaryfile':
                $url = $this->binaryFileUrl( $attr );
                $mime = '';
                $file = $attr->content();
                if ( $file instanceof eZBinaryFile )
                    $mime = (string)$file->attribute( 'mime_type' );
                $value = array(
                    'id' => (int)$attr->attribute( 'id' ),
                    'uri' => $url,
                    'mimeType' => $mime,
                );
                break;

            case 'ezkeyword':
                $keywords = $attr->content();
                $tags = array();
                if ( is_array( $keywords ) )
                {
                    foreach ( $keywords as $keyword )
                    {
                        $tags[] = array( 'keyword' => (string)$keyword );
                    }
                }
                $value = array( 'tags' => $tags, 'identifiers' => array_map( 'strval', $keywords ) );
                break;

            case 'ezselection':
                $selected = $attr->content();
                if ( !is_array( $selected ) )
                    $selected = array();
                $classAttr = $attr->attribute( 'contentclass_attribute' );
                $options = array();
                if ( $classAttr )
                {
                    $classContent = eZSelectionType::classAttributeContent( $classAttr );
                    if ( isset( $classContent['options'] ) && is_array( $classContent['options'] ) )
                    {
                        foreach ( $classContent['options'] as $option )
                        {
                            $options[(string)$option['id']] = (string)$option['name'];
                        }
                    }
                }
                $names = array();
                foreach ( $selected as $sel )
                {
                    $selId = (string)$sel;
                    $name = isset( $options[$selId] ) ? $options[$selId] : $selId;
                    $names[] = $name;
                }
                $value = array(
                    'identifiers' => array_map( 'strtolower', $names ),
                    'names' => $names,
                );
                break;

            case 'ezboolean':
                $value = array( 'bool' => (bool)$attr->content() );
                break;

            case 'xrowmetadata':
                $value = array(
                    'metas' => array(
                        'keywords' => array( 'content' => '' ),
                        'description' => array( 'content' => '' ),
                    ),
                );
                break;

            case 'ezobjectrelation':
                $id = (int)$attr->content();
                $rel = $id ? eZContentObject::fetch( $id ) : null;
                $value = array( 'content' => $rel ? $rel : null );
                break;

            case 'ezobjectrelationlist':
                $list = $attr->content();
                $items = array();
                if ( is_array( $list ) )
                {
                    foreach ( $list as $item )
                    {
                        $id = isset( $item['contentobject_id'] ) ? (int)$item['contentobject_id'] : 0;
                        if ( $id )
                        {
                            $obj = eZContentObject::fetch( $id );
                            if ( $obj )
                                $items[] = $obj;
                        }
                    }
                }
                $value = array( 'contents' => $items );
                break;

            default:
                $value = array( 'text' => $attr->toString() );
        }

        $value['attribute'] = $attr;
        return new sevenxThemesMediaField( $value, $empty );
    }

    public function wrapField( $attr )
    {
        return $this->wrapAttribute( $attr );
    }

    protected function binaryFileUrl( $attr )
    {
        $content = $attr->content();
        if ( $content instanceof eZBinaryFile )
        {
            return '/content/download/' . (int)$attr->attribute( 'contentobject_id' ) . '/' . (int)$attr->attribute( 'id' ) . '/' . (int)$attr->attribute( 'version' ) . '/' . rawurlencode( $content->attribute( 'original_filename' ) );
        }
        return '';
    }

    protected function trans( $key, $domain )
    {
        if ( is_object( $key ) )
            return '';
        $key = (string)$key;
        $domain = is_string( $domain ) ? $domain . ':' : '';
        return ucwords( str_replace( array( '.', '_' ), ' ', $key ) );
    }

    protected function resolveValue( $value )
    {
        if ( $value instanceof expSiteAPILocation )
        {
            return $value->getNode();
        }
        if ( $value instanceof expSiteAPIContent )
        {
            return $value->getObject();
        }
        if ( $value instanceof sevenxThemesMediaField )
        {
            $v = $value->attribute( 'value' );
            if ( is_array( $v ) && isset( $v['attribute'] ) )
            {
                return $v['attribute'];
            }
            return null;
        }
        return $value;
    }

    protected function getUrl( $value, $absolute = false )
    {
        $value = $this->resolveValue( $value );

        $url = '';
        if ( $value instanceof eZContentObjectTreeNode )
        {
            $url = $value->attribute( 'url_alias' );
        }
        elseif ( $value instanceof eZContentObject )
        {
            $mainNode = eZContentObjectTreeNode::fetch( $value->attribute( 'main_node_id' ) );
            if ( $mainNode )
            {
                $url = $mainNode->attribute( 'url_alias' );
            }
        }
        elseif ( is_string( $value ) )
        {
            $url = $value;
        }
        elseif ( is_array( $value ) && isset( $value['url_alias'] ) )
        {
            $url = $value['url_alias'];
        }

        if ( $url === '' )
        {
            return '/';
        }

        $uri = new eZURI( $url );
        $out = '/' . $uri->elements( true );
        if ( $absolute )
        {
            $host = eZINI::instance()->variable( 'SiteSettings', 'SiteURL' );
            $scheme = eZSys::isSSLNow() ? 'https' : 'http';
            $out = $scheme . '://' . $host . $out;
        }
        return $out;
    }

    protected function designUrl( $value, $type = null )
    {
        if ( is_numeric( $value ) && ( $type === 'ibexa_file' || $type === null ) )
        {
            $attr = $this->attributeByID( (int)$value );
            if ( $attr )
            {
                return $this->binaryFileUrl( $attr );
            }
            return '';
        }

        if ( !is_string( $value ) )
            return '';

        $bases = eZTemplateDesignResource::allDesignBases();
        $base = is_array( $bases ) && !empty( $bases ) ? $bases[0] : '';
        return rtrim( $base, '/' ) . '/' . ltrim( $value, '/' );
    }

    protected function attributeByID( $id )
    {
        $db = eZDB::instance();
        $row = $db->arrayQuery( "SELECT * FROM ezcontentobject_attribute WHERE id = " . (int)$id . " ORDER BY version DESC LIMIT 1" );
        if ( !is_array( $row ) || !isset( $row[0] ) )
            return null;
        return new eZContentObjectAttribute( $row[0] );
    }

    protected function getImageUrl( $value, $aliasName = null )
    {
        $value = $this->resolveValue( $value );
        $aliasName = $aliasName ?: 'original';

        $attr = null;
        if ( $value instanceof eZContentObjectAttribute && $value->attribute( 'data_type_string' ) == 'ezimage' )
        {
            $attr = $value;
        }
        elseif ( $value instanceof eZImageAlias )
        {
            return $value->urlFull();
        }
        elseif ( $value instanceof eZImageAliasHandler )
        {
            return $this->imageAliasUrl( $value, $aliasName );
        }

        if ( is_string( $value ) )
        {
            return $this->designUrl( $value );
        }

        if ( !$attr )
        {
            return '';
        }

        $handler = $attr->content();
        if ( $handler instanceof eZImageAliasHandler )
        {
            return $this->imageAliasUrl( $handler, $aliasName );
        }

        return '';
    }

    protected function imageAliasUrl( $handler, $aliasName )
    {
        $aliasList = $handler->aliasList();
        $clusterFileHandler = eZClusterFileHandler::instance();

        $url = '';
        if ( isset( $aliasList[$aliasName] ) && $clusterFileHandler->fileExists( $aliasList[$aliasName]['url'] ) )
            $url = $aliasList[$aliasName]['url'];

        if ( $url === '' )
        {
            if ( !isset( $aliasList['original'] ) )
                return '';

            $original = $aliasList['original'];
            if ( !$clusterFileHandler->fileExists( $original['url'] ) )
                return '';

            if ( $aliasName === 'original' )
                $url = $original['url'];
        }

        if ( $url === '' )
        {
            $alias = $handler->imageAlias( $aliasName );
            if ( $alias && $clusterFileHandler->fileExists( $alias['url'] ) )
                $url = $alias['url'];
        }

        if ( $url === '' && isset( $aliasList['original'] ) )
            $url = $aliasList['original']['url'];

        if ( $url !== '' && strpos( $url, '/' ) !== 0 && strpos( $url, 'http' ) !== 0 )
            $url = '/' . $url;

        return $url;
    }

    protected function getText( $value, $content, $type, $fields = null )
    {
        if ( $content instanceof expSiteAPIContent )
        {
            $content = $content->getObject();
        }
        if ( $content instanceof eZContentObject )
        {
            if ( $type === 'title' )
            {
                return (string)$content->attribute( 'name' );
            }
            // The reference intro macro reads ONLY teaser_intro/full_intro; it
            // never falls back to description (a video with an empty teaser
            // renders no short even though its description has paragraphs).
            // Templates that intro from another field (banner uses
            // description) pass an explicit candidate list as 3rd argument.
            $candidates = array( 'teaser_intro', 'full_intro' );
            if ( is_string( $fields ) && $fields !== '' )
            {
                $candidates = array( $fields );
            }
            elseif ( is_array( $fields ) && count( $fields ) )
            {
                $candidates = $fields;
            }
            $dataMap = $content->dataMap();
            foreach ( $candidates as $candidate )
            {
                if ( isset( $dataMap[$candidate] ) && $dataMap[$candidate]->hasContent() )
                {
                    // Render through the datatype handler (docbook -> HTML for
                    // ezxmltext); raw toString() would leak the stored XML.
                    $html = trim( $this->renderAttribute( $dataMap[$candidate], array() ) );
                    // empty docbook sections render only debug comments -
                    // strip them before judging emptiness
                    $plain = trim( preg_replace( '/<!--.*?-->/s', '', $html ) );
                    if ( $plain !== '' )
                        return '<div class="short"><div class="ibexa_richtext-field">' . $html . '</div></div>';
                }
            }
        }
        return '';
    }

    protected function renderField( $value, $params )
    {
        $value = $this->resolveValue( $value );

        if ( is_array( $params ) && isset( $params['parameters'] ) )
        {
            $params = $params['parameters'];
        }
        if ( !is_array( $params ) )
        {
            $params = array();
        }

        if ( $value instanceof sevenxThemesMediaField )
        {
            if ( $value->attribute( 'empty' ) )
                return '';
            $fieldValue = $value->attribute( 'value' );
            if ( is_array( $fieldValue ) && isset( $fieldValue['attribute'] ) && $fieldValue['attribute'] instanceof eZContentObjectAttribute )
                return $this->renderAttribute( $fieldValue['attribute'], $params );
            return is_array( $fieldValue ) && isset( $fieldValue['text'] ) ? (string)$fieldValue['text'] : '';
        }
        if ( $value instanceof eZContentObjectAttribute )
        {
            return $this->renderAttribute( $value, $params );
        }
        if ( $value instanceof expSiteAPIContent )
        {
            return (string)$value->name();
        }
        if ( $value instanceof eZContentObjectTreeNode || $value instanceof eZContentObject )
        {
            return $this->getUrl( $value );
        }
        if ( is_string( $value ) || is_numeric( $value ) )
        {
            return (string)$value;
        }
        return '';
    }

    protected function prepareEzXmlData( $xml )
    {
        if ( !is_string( $xml ) || trim( $xml ) === '' )
            return $xml;

        // Imported Ibexa/nexus rich text uses href="ezurl://<id>", href="eznode://<id>"
        // and href="ezobject://<id>" references, plus xlink:show for link targets.
        // eZ's output handler needs url_id/node_id/object_id and a target attribute.
        $xml = preg_replace( '/\s+xlink:show="none"/', '', $xml );
        $xml = preg_replace( '/\s+xlink:show="new"/', ' target="_blank"', $xml );
        $xml = preg_replace( '/\s+xlink:show="[^"]*"/', '', $xml );
        $xml = preg_replace( '/\s+xlink:show=\'[^\']*\'/', '', $xml );

        $xml = preg_replace( '/href="ezurl:\/\/(\d+)"/', 'url_id="$1"', $xml );
        $xml = preg_replace( '/href="eznode:\/\/(\d+)"/', 'node_id="$1"', $xml );
        $xml = preg_replace( '/href="ezobject:\/\/(\d+)"/', 'object_id="$1"', $xml );

        return $xml;
    }

    protected function convertDocBookToEzXml( $xml )
    {
        if ( !is_string( $xml ) || trim( $xml ) === '' )
            return '';

        // Strip the imported docbook "default" namespace prefix so the output
        // handler recognises tags such as <para>, <section>, <link> etc.
        $xml = preg_replace( '/\s+xmlns:default="[^"]*"/', '', $xml );
        $xml = preg_replace( '/<(\/?)default:([\w-]+)/', '<$1$2', $xml );

        // Strip the default namespace declaration and any other docbook
        // namespace attributes the imported XML may carry.
        $xml = preg_replace( '/\s+xmlns="http:\/\/docbook\.org\/ns\/docbook"/', '', $xml );
        $xml = preg_replace( '/\s+xmlns:xlink="[^"]*"/', '', $xml );
        $xml = preg_replace( '/\s+xmlns:ezxhtml="[^"]*"/', '', $xml );
        $xml = preg_replace( '/\s+xmlns:ezcustom="[^"]*"/', '', $xml );
        $xml = preg_replace( '/\s+version="[^"]*"/', '', $xml );

        // Map imported docbook tag names to the eZ XML ones the output
        // handler understands.
        $tagMap = array(
            'para' => 'paragraph',
            'emphasis' => 'emphasize',
            'orderedlist' => 'ol',
            'itemizedlist' => 'ul',
            'listitem' => 'li',
            'subscript' => 'sub',
            'superscript' => 'sup',
            'literallayout' => 'literal',
        );
        foreach ( $tagMap as $from => $to )
        {
            $xml = preg_replace( '/<(\/?)' . $from . '(?![\w-])/i', '<$1' . $to, $xml );
        }

        // DocBook external links use xlink:href; the eZ output handler uses href.
        $xml = str_replace( 'xlink:href=', 'href=', $xml );

        // Ensure the root <section> carries the canonical eZ XML namespaces.
        $ezNs = ' xmlns:image="http://ez.no/namespaces/ezpublish3/image/"' .
                ' xmlns:xhtml="http://ez.no/namespaces/ezpublish3/xhtml/"' .
                ' xmlns:custom="http://ez.no/namespaces/ezpublish3/custom/"';
        $xml = preg_replace_callback(
            '/<section(\s[^>]*)?(\/?)>/',
            function( $m ) use ( $ezNs )
            {
                $attrs = isset( $m[1] ) ? $m[1] : '';
                $self = isset( $m[2] ) ? $m[2] : '';
                if ( strpos( $attrs, 'xmlns:image=' ) !== false )
                    return $m[0];
                return '<section' . $attrs . $ezNs . $self . '>';
            },
            $xml,
            1
        );

        return $this->prepareEzXmlData( $xml );
    }

    protected function renderAttribute( $attribute, $params )
    {
        $dataType = $attribute->attribute( 'data_type_string' );
        $alias = isset( $params['alias'] ) ? $params['alias'] : null;

        switch ( $dataType )
        {
            case 'ezimage':
                $url = $this->getImageUrl( $attribute, $alias );
                $alt = isset( $params['alt_text'] ) ? $params['alt_text'] : '';
                $link = isset( $params['link_href'] ) ? $params['link_href'] : null;
                $img = '<img src="' . $url . '" loading="lazy" alt="' . htmlspecialchars( $alt ) . '" class="ibexa_image-field" />';
                if ( $link )
                    return '<a href="' . $link . '">' . $img . '</a>';
                return $img;

            case 'ezxmltext':
                $xml = $attribute->content();
                if ( $xml instanceof eZXMLText )
                {
                    $xmlData = $xml->attribute( 'xml_data' );
                    $prepared = $this->prepareEzXmlData( $xmlData );
                    $preparedXml = new eZXMLText( $prepared, null );
                    $html = $preparedXml->attribute( 'output' )->outputText();
                    if ( $html === '' )
                    {
                        if ( strpos( $prepared, 'default:' ) !== false || strpos( $prepared, 'xmlns:default' ) !== false )
                        {
                            $converted = $this->convertDocBookToEzXml( $prepared );
                            if ( $converted !== '' )
                            {
                                $convertedXml = new eZXMLText( $converted, null );
                                $html = $convertedXml->attribute( 'output' )->outputText();
                            }
                        }
                    }
                    return $html;
                }
                return $attribute->toString();

            case 'ezurl':
                return $attribute->content();

            case 'ezkeyword':
                $keywords = $attribute->content();
                if ( is_array( $keywords ) )
                    return implode( ', ', $keywords );
                return (string)$keywords;

            case 'ezselection':
            case 'ezstring':
            case 'eztext':
            case 'ezemail':
            default:
                $content = $attribute->hasContent() ? $attribute->toString() : '';
                return $content;
        }
    }

    protected function viewContent( $value, $viewType, $params = null )
    {
        $node = $this->toNode( $value );
        if ( !$node )
            return '';

        $object = $node->attribute( 'object' );
        if ( !$object )
            return '';

        $content = new expSiteApiContent( $object );
        $location = new expSiteApiLocation( $node );

        $tpl = eZTemplate::factory();
        $tpl->setVariable( 'content', $content );
        $tpl->setVariable( 'location', $location );
        $tpl->setVariable( 'node', $node );
        $tpl->setVariable( 'object', $object );
        $tpl->setVariable( 'view_type', $viewType );

        if ( is_array( $params ) )
        {
            foreach ( $params as $key => $val )
            {
                $tpl->setVariable( $key, $val );
            }
            if ( isset( $params['params'] ) && is_array( $params['params'] ) )
            {
                foreach ( $params['params'] as $key => $val )
                {
                    $tpl->setVariable( $key, $val );
                }
            }
        }

        $classIdentifier = (string)$object->attribute( 'class_identifier' );
        $baseTemplate = 'design:content/views/' . $viewType . '.tpl';
        $classTemplateUri = 'design:content/views/' . $viewType . '/' . $classIdentifier . '.tpl';

        foreach ( eZTemplateDesignResource::allDesignBases() as $base )
        {
            if ( file_exists( $base . '/templates/content/views/' . $viewType . '/' . $classIdentifier . '.tpl' ) )
            {
                return $tpl->fetch( $classTemplateUri );
            }
        }

        return $tpl->fetch( $baseTemplate );
    }

    protected function toNode( $value )
    {
        $value = $this->resolveValue( $value );
        if ( $value instanceof eZContentObjectTreeNode )
            return $value;
        if ( $value instanceof eZContentObject )
            return eZContentObjectTreeNode::fetch( $value->attribute( 'main_node_id' ) );
        if ( is_array( $value ) && isset( $value['main_node_id'] ) )
            return eZContentObjectTreeNode::fetch( $value['main_node_id'] );
        if ( is_numeric( $value ) )
            return eZContentObjectTreeNode::fetch( (int)$value );
        return null;
    }

    protected function toObject( $value )
    {
        $value = $this->resolveValue( $value );
        if ( $value instanceof eZContentObject )
            return $value;
        if ( $value instanceof eZContentObjectTreeNode )
            return $value->attribute( 'object' );
        if ( is_numeric( $value ) )
            return eZContentObject::fetch( (int)$value );
        return null;
    }

    protected function getParam( $value, $key )
    {
        if ( is_array( $value ) )
            return isset( $value[$key] ) ? $value[$key] : null;
        if ( is_object( $value ) && method_exists( $value, 'attribute' ) )
            return $value->attribute( $key );
        return null;
    }

    protected function hasParam( $value, $key )
    {
        return is_array( $value ) ? isset( $value[$key] ) : ( is_object( $value ) && method_exists( $value, 'hasAttribute' ) ? $value->hasAttribute( $key ) : false );
    }

    protected function hasField( $value, $field )
    {
        $object = $this->toObject( $value );
        if ( !$object )
            return false;
        $dataMap = $object->dataMap();
        return isset( $dataMap[$field] ) && $dataMap[$field]->hasContent();
    }

    protected function firstNonEmptyField( $value, $fields )
    {
        $object = $this->toObject( $value );
        if ( !$object )
            return new sevenxThemesMediaField( array(), true );

        $dataMap = $object->dataMap();
        foreach ( $fields as $field )
        {
            if ( $field === 'name' )
                continue;
            if ( isset( $dataMap[$field] ) && $dataMap[$field]->hasContent() )
            {
                return $this->wrapAttribute( $dataMap[$field] );
            }
        }

        if ( in_array( 'name', $fields ) )
        {
            return new sevenxThemesMediaField( array( 'text' => $object->attribute( 'name' ) ), false );
        }

        return new sevenxThemesMediaField( array(), true );
    }

    /**
     * The imported nglayouts tpl_block blocks lost their template parameter;
     * this is the block-id -> design template mapping (verified against the
     * reference rendering). Unmapped tpl blocks render nothing at all, like
     * the reference does for its context-empty tpl blocks.
     */
    /**
     * Resolves the {{ topic_tag }} placeholder in imported layout titles
     * with the current page's content name (like the reference twig does).
     */
    protected function layoutTitle( $title )
    {
        $title = (string)$title;
        if ( strpos( $title, 'topic_tag' ) === false )
            return $title;
        $name = '';
        if ( class_exists( 'expLayoutsResolver' ) )
        {
            $node = expLayoutsResolver::nodeFromPath( eZSys::requestURI() );
            if ( $node )
                $name = $node->attribute( 'name' );
        }
        return preg_replace( '/\{\{\s*topic_tag\s*\}\}/', $name, $title );
    }

    /**
     * Resolves an ibexa_component block's 'content' parameter (a NEXUS
     * content id, +776 offset) to the component's content object.
     */
    protected function componentContent( $value )
    {
        $id = (int)$value;
        if ( $id <= 0 )
            return false;

        // The 'content' parameter is a Nexus content id.  The demo package
        // stores imported objects with remote_id 'media-o-<nexus_id+776>',
        // so try that first, then a direct 'media-o-<nexus_id>' mapping,
        // and finally the legacy numeric +776 / raw eZ object id fallbacks
        // for older layouts that may already store an eZ id.
        $object = eZContentObject::fetchByRemoteID( 'media-o-' . ( $id + 776 ) );
        if ( !$object )
            $object = eZContentObject::fetchByRemoteID( 'media-o-' . $id );
        if ( !$object )
            $object = eZContentObject::fetch( $id + 776 );
        if ( !$object )
            $object = eZContentObject::fetch( $id );
        return $object ? $object : false;
    }

    /**
     * Resolves an ngenhancedlink attribute (JSON in data_text with nexus ids)
     * to hash('href','text','target'). Returns false when empty.
     */
    protected function enhancedLink( $value )
    {
        $json = '';
        if ( $value instanceof eZContentObjectAttribute )
            $json = (string)$value->attribute( 'data_text' );
        elseif ( is_string( $value ) )
            $json = $value;
        $json = str_replace( array( '\\n', "\n" ), '', $json );
        $data = json_decode( $json, true );
        if ( !is_array( $data ) || !isset( $data['type'] ) )
            return false;

        $href = '';
        $text = isset( $data['label'] ) && $data['label'] !== null && $data['label'] !== '' ? $data['label'] : '';
        if ( $data['type'] === 'external' )
        {
            $urlId = isset( $data['id'] ) ? (int)$data['id'] : 0;
            if ( $urlId > 0 )
            {
                $url = eZURL::fetch( $urlId );
                if ( $url )
                    $href = $url->attribute( 'url' );
            }
            if ( $href === '' && isset( $data['url'] ) )
                $href = (string)$data['url'];
            if ( !isset( $data['target'] ) || !in_array( $data['target'], array( 'modal', 'embed' ) ) )
                $text = $href;
            elseif ( $text === '' )
                $text = $href;
        }
        else
        {
            // internal enhancedlink ids are nexus CONTENT ids; resolve them
            // using the same media-o-<nexus_id+776> / media-o-<nexus_id> / +776
            // / raw fallbacks that componentContent() uses.
            $refId = isset( $data['id'] ) ? (int)$data['id'] : 0;
            $object = false;
            if ( $refId > 0 )
            {
                $object = eZContentObject::fetchByRemoteID( 'media-o-' . ( $refId + 776 ) );
                if ( !$object )
                    $object = eZContentObject::fetchByRemoteID( 'media-o-' . $refId );
                if ( !$object )
                    $object = eZContentObject::fetch( $refId + 776 );
                if ( !$object )
                    $object = eZContentObject::fetch( $refId );
            }
            $node = false;
            if ( $object )
                $node = eZContentObjectTreeNode::fetch( (int)$object->attribute( 'main_node_id' ) );

            // form targets: embedded information-collection form or modal trigger
            if ( isset( $data['target'] ) && in_array( $data['target'], array( 'embed', 'modal' ) )
                 && $node && $node->attribute( 'class_identifier' ) !== 'ng_video' )
            {
                return array(
                    'href' => '#',
                    'text' => $node->attribute( 'name' ),
                    'target' => '',
                    'video' => false,
                    'video_title' => '',
                    'video_options' => '',
                    'form_embed' => $data['target'] === 'embed',
                    'form_modal' => $data['target'] === 'modal',
                    'form_object_id' => (int)$node->attribute( 'contentobject_id' ),
                    'form_node_id' => (int)$node->attribute( 'node_id' ),
                );
            }

            $isModal = isset( $data['target'] ) && $data['target'] === 'modal';
            if ( $isModal || ( $node && $node->attribute( 'class_identifier' ) === 'ng_video' ) )
            {
                // reference renders video links as modal triggers
                $title = $node ? $node->attribute( 'name' ) : $text;
                $videoOptions = $this->videoOptions( $object, $title );
                return array(
                    'href' => '#',
                    'text' => $text !== '' ? $text : $title,
                    'target' => '',
                    'video' => true,
                    'video_title' => $title,
                    'video_options' => $videoOptions,
                    'form_embed' => false,
                    'form_modal' => false,
                    'form_object_id' => 0,
                    'form_node_id' => 0,
                );
            }
            if ( $node )
            {
                $href = '/' . $node->attribute( 'url_alias' );
                $text = $node->attribute( 'name' );
            }
            else
            {
                // unresolvable internal target: reference renders href="#"
                $href = '#';
                if ( $text === '' )
                    $text = '#';
            }
        }
        if ( $href === '' )
            return false;
        if ( isset( $data['suffix'] ) && $data['suffix'] !== null && $data['suffix'] !== '' )
            $href .= $data['suffix'];

        $target = '';
        if ( isset( $data['target'] ) && ( $data['target'] === 'link_new_tab' || $data['target'] === '_blank' ) )
            $target = '_blank';

        return array(
            'href' => $href,
            'text' => $text,
            'target' => $target,
            'rel_attribute' => isset( $data['rel_attribute'] ) ? (string) $data['rel_attribute'] : '',
            'video' => false,
            'video_title' => '',
            'video_options' => '',
            'form_embed' => false,
            'form_modal' => false,
            'form_object_id' => 0,
            'form_node_id' => 0,
        );
    }

    /**
     * Builds the data-video-options JSON string for an ng_video content object.
     * Matches the JSON shape used by Nexus modal video triggers.
     */
    protected function videoOptions( $object, $videoTitle )
    {
        $options = array(
            'videoTitle' => $videoTitle,
            'type'       => '',
            'fileLink'   => null,
            'mimeType'   => null,
            'identifier' => '',
            'poster'     => null,
            'autoplay'   => false,
        );

        if ( !$object )
            return json_encode( $options );

        $dataMap = $object->attribute( 'data_map' );

        $typeAttr = isset( $dataMap['video_type'] ) ? $dataMap['video_type'] : false;
        if ( $typeAttr )
        {
            $typeString = (string)$typeAttr->toString();
            if ( $typeString !== '' && $typeString !== 'a:0:{}' )
                $options['type'] = $typeString;
            else
            {
                // sckenhancedselection currently has empty options in the demo
                // package, so map the stored data_int index to the video type.
                $typeIndex = (int)$typeAttr->attribute( 'data_int' );
                $typeMap = array( 0 => 'upload', 1 => 'youtube', 2 => 'vimeo', 3 => 'dailymotion' );
                if ( isset( $typeMap[$typeIndex] ) )
                    $options['type'] = $typeMap[$typeIndex];
            }
        }

        if ( in_array( $options['type'], array( 'upload' ) ) )
        {
            $fileAttr = isset( $dataMap['video_file'] ) ? $dataMap['video_file'] : false;
            if ( $fileAttr && $fileAttr->attribute( 'has_content' ) )
            {
                $file = $fileAttr->content();
                if ( is_object( $file ) && $file instanceof eZBinaryFile )
                {
                    $options['fileLink'] = '/content/download/' . (int)$fileAttr->attribute( 'contentobject_id' ) . '/' . (int)$file->attribute( 'contentobject_attribute_id' );
                    $options['mimeType'] = (string)$file->attribute( 'mime_type' );
                }
                elseif ( is_array( $file ) )
                {
                    $options['fileLink'] = isset( $file['fileurl'] ) ? (string)$file['fileurl'] : ( isset( $file['url'] ) ? (string)$file['url'] : null );
                    $options['mimeType'] = isset( $file['mime_type'] ) ? (string)$file['mime_type'] : ( isset( $file['mimeType'] ) ? (string)$file['mimeType'] : null );
                }
            }
        }
        elseif ( in_array( $options['type'], array( 'youtube', 'vimeo', 'dailymotion' ) ) )
        {
            $idAttr = isset( $dataMap['video_identifier'] ) ? $dataMap['video_identifier'] : false;
            if ( $idAttr )
                $options['identifier'] = (string)$idAttr->toString();
        }

        $posterAttr = isset( $dataMap['poster'] ) ? $dataMap['poster'] : false;
        if ( $posterAttr && $posterAttr->attribute( 'has_content' ) )
        {
            $poster = $posterAttr->content();
            if ( is_array( $poster ) && isset( $poster['original'] ) && is_array( $poster['original'] ) && isset( $poster['original']['url'] ) )
                $options['poster'] = (string)$poster['original']['url'];
        }

        $autoplayAttr = isset( $dataMap['autoplay'] ) ? $dataMap['autoplay'] : false;
        if ( $autoplayAttr )
            $options['autoplay'] = (bool)$autoplayAttr->content();

        return json_encode( $options );
    }

    /**
     * Resolves a docbook embed href (ezcontent://N / ezlocation://N with
     * NEXUS ids, +776/+554 offsets) to the embedded image.
     * Returns hash('url','alt') or false.
     */
    protected function embedImage( $href, $alias = 'i1320' )
    {
        if ( !preg_match( '#^ez(content|location)://(\d+)$#', (string)$href, $m ) )
            return false;
        $id = (int)$m[2];
        $object = false;
        if ( $m[1] === 'content' )
        {
            $object = eZContentObject::fetch( $id + 776 );
            if ( !$object )
                $object = eZContentObject::fetch( $id );
        }
        else
        {
            $node = eZContentObjectTreeNode::fetch( $id + 554 );
            if ( !$node )
                $node = eZContentObjectTreeNode::fetch( $id );
            if ( $node )
                $object = $node->attribute( 'object' );
        }
        if ( !$object )
            return false;
        $dataMap = $object->dataMap();
        if ( !isset( $dataMap['image'] ) || !$dataMap['image']->hasContent() )
            return false;
        $handler = $dataMap['image']->content();
        if ( !$handler )
            return false;
        $url = $this->imageAliasUrl( $handler, $alias ? $alias : 'i1320' );
        if ( $url === '' )
            return false;
        $altAlias = $handler->imageAlias( 'original' );
        $alt = is_array( $altAlias ) && isset( $altAlias['alternative_text'] ) ? $altAlias['alternative_text'] : '';
        return array( 'url' => $url, 'alt' => $alt );
    }

    protected function tplBlockTemplate( $blockId )
    {
        $map = array(
            13  => 'pagelayout/header.tpl',
            477 => 'pagelayout/breadcrumbs.tpl',
            14  => 'pagelayout/footer.tpl',
            318 => 'content/parts/full_header.tpl',
            316 => 'content/parts/full_image.tpl',
            317 => 'content/parts/full_body.tpl',
            321 => 'content/parts/full_recipe_info.tpl',
            327 => 'content/parts/topic_header.tpl',
            348 => 'content/parts/topic_header.tpl',
        );
        $blockId = (int)$blockId;
        if ( isset( $map[$blockId] ) )
            return $map[$blockId];

        // Imported layout blocks may get new IDs while sitting in the same
        // header/footer zones; resolve the template by zone/placeholder so
        // site header/footer still render even when block IDs are remapped.
        $db = eZDB::instance();
        $sql = 'SELECT b.placeholder, b.parent_id, z.identifier AS zone ' .
               'FROM explayouts_block b ' .
               'JOIN explayouts_zone z ON z.id = b.zone_id ' .
               'WHERE b.id = ' . $blockId;
        $rows = $db->arrayQuery( $sql );
        if ( !empty( $rows ) )
        {
            $row = $rows[0];
            if ( $row['zone'] === 'header' )
            {
                if ( $row['placeholder'] === 'root' )
                    return 'pagelayout/header.tpl';
                if ( $row['placeholder'] === 'main' && (int)$row['parent_id'] !== 0 )
                    return 'pagelayout/breadcrumbs.tpl';
            }
            elseif ( $row['zone'] === 'footer' && $row['placeholder'] === 'root' )
            {
                return 'pagelayout/footer.tpl';
            }
        }
        return '';
    }

    /**
     * Recipe JSON-LD schema for ng_recipe full views.
     */
    protected function recipeSchema( $node )
    {
        if ( !$node instanceof eZContentObjectTreeNode )
        {
            $object = $this->toObject( $node );
            if ( $object instanceof eZContentObject )
                $node = $object->attribute( 'main_node' );
        }
        if ( !$node instanceof eZContentObjectTreeNode )
            return '';

        $object = $node->attribute( 'object' );
        if ( !$object || $object->attribute( 'class_identifier' ) !== 'ng_recipe' )
            return '';

        $dataMap = $node->dataMap();
        $siteUrl = 'https://' . eZINI::instance( 'site.ini' )->variable( 'SiteSettings', 'SiteURL' );

        $recipe = array(
            '@context' => 'http://schema.org',
            '@type' => 'Recipe',
            'name' => $object->attribute( 'name' ),
        );

        $published = $object->attribute( 'published' );
        if ( $published )
            $recipe['datePublished'] = date( 'Y-m-d', (int)$published );

        if ( isset( $dataMap['preparation_time'] ) && $dataMap['preparation_time']->hasContent() )
        {
            $minutes = (int)$dataMap['preparation_time']->content();
            if ( $minutes > 0 )
                $recipe['totalTime'] = 'PT' . $minutes . 'M';
        }

        $nutrition = array( '@type' => 'NutritionInformation' );
        if ( isset( $dataMap['serving_calories'] ) && $dataMap['serving_calories']->hasContent() )
            $nutrition['calories'] = (string)(int)$dataMap['serving_calories']->content();
        if ( isset( $dataMap['serving_fat'] ) && $dataMap['serving_fat']->hasContent() )
            $nutrition['fatContent'] = (string)(int)$dataMap['serving_fat']->content();
        if ( isset( $dataMap['serving_carbohydrates'] ) && $dataMap['serving_carbohydrates']->hasContent() )
            $nutrition['carbohydrateContent'] = (string)(int)$dataMap['serving_carbohydrates']->content();
        if ( isset( $dataMap['serving_protein'] ) && $dataMap['serving_protein']->hasContent() )
            $nutrition['proteinContent'] = (string)(int)$dataMap['serving_protein']->content();

        if ( count( $nutrition ) > 1 )
            $recipe['nutrition'] = $nutrition;

        if ( isset( $dataMap['full_intro'] ) && $dataMap['full_intro']->hasContent() )
        {
            $output = $dataMap['full_intro']->content()->attribute( 'output' )->attribute( 'output_text' );
            $description = html_entity_decode( strip_tags( $output ), ENT_QUOTES, 'UTF-8' );
            $description = trim( $description );
            if ( $description !== '' )
                $recipe['description'] = $description;
        }

        if ( isset( $dataMap['authors'] ) && $dataMap['authors']->hasContent() )
        {
            $authorsData = $dataMap['authors']->content();
            if ( isset( $authorsData['relation_list'] ) && is_array( $authorsData['relation_list'] ) )
            {
                $authorIds = array();
                foreach ( $authorsData['relation_list'] as $rel )
                {
                    $authorId = isset( $rel['contentobject_id'] ) ? (int)$rel['contentobject_id'] : 0;
                    if ( $authorId > 0 && !in_array( $authorId, $authorIds ) )
                        $authorIds[] = $authorId;
                }

                if ( !empty( $authorIds ) )
                {
                    $recipe['author'] = array();
                    foreach ( $authorIds as $authorId )
                    {
                        $author = eZContentObject::fetch( $authorId );
                        if ( $author )
                        {
                            $recipe['author'][] = array(
                                '@type' => 'Person',
                                'name' => $author->attribute( 'name' ),
                            );
                        }
                    }
                    if ( count( $recipe['author'] ) === 1 )
                        $recipe['author'] = $recipe['author'][0];
                }
            }
        }

        if ( isset( $dataMap['image'] ) && $dataMap['image']->hasContent() )
        {
            $imageUrl = $this->getImageUrl( $dataMap['image'], 'i1320' );
            if ( $imageUrl !== '' )
            {
                if ( strpos( $imageUrl, 'http' ) !== 0 )
                    $imageUrl = $siteUrl . '/' . ltrim( $imageUrl, '/' );
                $recipe['image'] = $imageUrl;
            }
        }

        $recipe['publisher'] = array(
            '@type' => 'Organization',
            'name' => eZINI::instance( 'site.ini' )->variable( 'SiteSettings', 'SiteName' ),
        );

        return '<script type="application/ld+json">' . json_encode( $recipe, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT ) . '</script>';
    }

    /**
     * Tags linked to a content object via the imported eztags link table
     * (the eztags extension itself is not installed on this install).
     * Returns array of hash('id', 'keyword').
     */
    protected function contentTags( $value, $field = null )
    {
        $object = $this->toObject( $value );
        if ( !$object )
            return array();

        $objectId = (int)$object->attribute( 'id' );
        $db = eZDB::instance();

        $fieldFilter = '';
        if ( $field !== null && $field !== '' )
        {
            $exclude = strpos( $field, '-' ) === 0;
            $identifier = $exclude ? substr( $field, 1 ) : $field;
            $attrIds = array();
            $dataMap = $object->dataMap();
            foreach ( $dataMap as $key => $attr )
            {
                if ( $key === $identifier && $attr instanceof eZContentObjectAttribute )
                    $attrIds[] = (int)$attr->attribute( 'id' );
            }
            if ( !empty( $attrIds ) )
            {
                $inList = implode( ',', $attrIds );
                if ( $exclude )
                    $fieldFilter = " AND l.objectattribute_id NOT IN ($inList)";
                else
                    $fieldFilter = " AND l.objectattribute_id IN ($inList)";
            }
        }

        try
        {
            $rows = $db->arrayQuery(
                'SELECT DISTINCT t.id, t.keyword FROM eztags t JOIN eztags_attribute_link l ON l.keyword_id = t.id WHERE l.object_id = ' . $objectId . $fieldFilter . ' ORDER BY t.keyword'
            );
        }
        catch ( Exception $e )
        {
            error_log( 'content_tags query failed (object ' . $objectId . '): ' . $e->getMessage() );
            $rows = array();
        }

        $out = array();
        foreach ( $rows as $row )
        {
            $out[] = array( 'id' => (int)$row['id'], 'keyword' => $row['keyword'] );
        }
        return $out;
    }

    protected function getField( $value, $field )
    {
        $object = $this->toObject( $value );
        if ( !$object )
            return null;
        $dataMap = $object->dataMap();
        return isset( $dataMap[$field] ) ? $dataMap[$field] : null;
    }

    protected function getRelations( $value, $field )
    {
        $object = $this->toObject( $value );
        if ( !$object )
            return array();
        $dataMap = $object->dataMap();
        if ( !isset( $dataMap[$field] ) )
            return array();

        $attr = $dataMap[$field];
        if ( !$attr->hasContent() )
            return array();

        $out = array();
        if ( $attr->attribute( 'data_type_string' ) == 'ezobjectrelation' )
        {
            $id = (int)$attr->content();
            $rel = eZContentObject::fetch( $id );
            if ( $rel )
                $out[] = $rel;
        }
        elseif ( $attr->attribute( 'data_type_string' ) == 'ezobjectrelationlist' )
        {
            $list = $attr->content();
            if ( is_array( $list ) && isset( $list['relation_list'] ) )
                $list = $list['relation_list'];
            if ( is_array( $list ) )
            {
                foreach ( $list as $item )
                {
                    $id = isset( $item['contentobject_id'] ) ? (int)$item['contentobject_id'] : 0;
                    $rel = false;
                    if ( $id )
                    {
                        $rel = eZContentObject::fetch( $id );
                    }
                    elseif ( isset( $item['contentobject_remote_id'] ) && $item['contentobject_remote_id'] !== '' )
                    {
                        $rel = eZContentObject::fetchByRemoteID( $item['contentobject_remote_id'] );
                    }
                    if ( $rel )
                        $out[] = $rel;
                }
            }
        }
        return $out;
    }

    protected function filterChildren( $value, $classes, $limit )
    {
        $node = $this->toNode( $value );
        if ( !$node )
            return array();

        $params = array(
            'ClassFilterType' => 'include',
            'ClassFilterArray' => is_array( $classes ) ? $classes : array( $classes ),
            'Limit' => (int)$limit,
            'SortBy' => array( 'published', false )
        );
        $children = eZContentObjectTreeNode::subTreeByNodeID( $params, $node->attribute( 'node_id' ) );
        if ( !is_array( $children ) )
            return array();

        $out = array();
        foreach ( $children as $child )
        {
            $out[] = $child;
        }
        return $out;
    }

    protected function getParent( $value )
    {
        $node = $this->toNode( $value );
        if ( !$node )
            return null;
        $parent = $node->attribute( 'parent' );
        if ( $parent instanceof eZContentObjectTreeNode )
            return $parent;
        return null;
    }

    protected function openGraph( $value )
    {
        $object = $this->toObject( $value );
        if ( !$object )
            $object = $this->currentPageObject();
        if ( !$object )
            return array();

        $siteUrl = eZINI::instance( 'site.ini' )->variable( 'SiteSettings', 'SiteURL' );
        $mainNode = eZContentObjectTreeNode::fetch( $object->attribute( 'main_node_id' ) );
        $url = $mainNode ? 'https://' . $siteUrl . '/' . $mainNode->attribute( 'url_alias' ) : '';

        $type = 'website';
        $classIdentifier = $object->attribute( 'class_identifier' );
        if ( in_array( $classIdentifier, array( 'ng_article', 'ng_blog_post', 'ng_recipe', 'ng_news' ) ) )
            $type = 'article';

        $tags = array();
        $tags[] = array( 'tagName' => 'og:title', 'tagValue' => (string)$object->attribute( 'name' ) );
        $tags[] = array( 'tagName' => 'og:description', 'tagValue' => $this->openGraphDescription( $object ) );
        $tags[] = array( 'tagName' => 'og:image', 'tagValue' => $this->openGraphImage( $object ) );
        $tags[] = array( 'tagName' => 'og:type', 'tagValue' => $type );
        if ( $url !== '' )
            $tags[] = array( 'tagName' => 'og:url', 'tagValue' => $url );

        return $tags;
    }

    protected function openGraphDescription( $object )
    {
        $dataMap = $object->dataMap();

        if ( isset( $dataMap['metadata'] ) && $dataMap['metadata']->hasContent() )
        {
            $metadata = $dataMap['metadata']->content();
            if ( is_object( $metadata ) && isset( $metadata->description ) && trim( $metadata->description ) !== '' )
                return $this->plainText( $metadata->description, 160 );
        }

        $field = $this->firstNonEmptyField( $object, array( 'full_intro', 'teaser_intro', 'description', 'body' ) );
        if ( !$field->attribute( 'empty' ) )
        {
            $value = $field->attribute( 'value' );
            if ( isset( $value['text'] ) )
                return $this->plainText( $value['text'], 160 );
        }

        return (string)$object->attribute( 'name' );
    }

    protected function openGraphImage( $object )
    {
        $siteUrl = eZINI::instance( 'site.ini' )->variable( 'SiteSettings', 'SiteURL' );
        $dataMap = $object->dataMap();

        // xrowmetadata og_image
        if ( isset( $dataMap['metadata'] ) && $dataMap['metadata']->hasContent() )
        {
            $metadata = $dataMap['metadata']->content();
            if ( is_object( $metadata ) && isset( $metadata->og_image ) && (int)$metadata->og_image > 0 )
            {
                $imageUrl = $this->imageObjectUrl( (int)$metadata->og_image );
                if ( $imageUrl !== '' )
                    return 'https://' . $siteUrl . $imageUrl;
            }
        }

        // object image / teaser_image
        foreach ( array( 'image', 'teaser_image' ) as $attrName )
        {
            if ( isset( $dataMap[$attrName] ) && $dataMap[$attrName]->hasContent() )
            {
                $imageUrl = $this->imageAttributeUrl( $dataMap[$attrName] );
                if ( $imageUrl !== '' )
                    return 'https://' . $siteUrl . $imageUrl;
            }
        }

        // site default open graph image
        $remoteID = eZINI::instance( 'menu.ini' )->variable( 'SiteInfo', 'RemoteID' );
        if ( $remoteID )
        {
            $siteInfo = eZContentObject::fetchByRemoteID( $remoteID );
            if ( $siteInfo instanceof eZContentObject )
            {
                $siteDataMap = $siteInfo->dataMap();
                if ( isset( $siteDataMap['site_opengraph_image'] ) && $siteDataMap['site_opengraph_image']->hasContent() )
                {
                    $imageUrl = $this->imageAttributeUrl( $siteDataMap['site_opengraph_image'] );
                    if ( $imageUrl !== '' )
                        return 'https://' . $siteUrl . $imageUrl;
                }
            }
        }

        return 'https://' . $siteUrl . '/var/site/storage/images/6/8/5/4/4586-38-eng-GB/5d2e35487ff9-fh_opengraph.jpg';
    }

    protected function imageAttributeUrl( $attr )
    {
        if ( !$attr instanceof eZContentObjectAttribute )
            return '';
        $handler = $attr->content();
        if ( !$handler instanceof eZImageAliasHandler )
            return '';
        foreach ( array( 'i1320', 'large', 'original' ) as $alias )
        {
            $aliasData = $handler->imageAlias( $alias );
            if ( $aliasData && isset( $aliasData['url'] ) && $aliasData['url'] !== '' )
            {
                $url = (string)$aliasData['url'];
                if ( $url[0] !== '/' )
                    $url = '/' . $url;
                return $url;
            }
        }
        return '';
    }

    protected function imageObjectUrl( $objectId )
    {
        $object = eZContentObject::fetch( $objectId );
        if ( !$object )
            return '';
        $dataMap = $object->dataMap();
        foreach ( array( 'image', 'teaser_image', 'site_opengraph_image', 'site_logo', 'file' ) as $attrName )
        {
            if ( isset( $dataMap[$attrName] ) && $dataMap[$attrName]->hasContent() )
            {
                $dataType = $dataMap[$attrName]->attribute( 'data_type_string' );
                if ( $dataType == 'ezimage' )
                {
                    $url = $this->imageAttributeUrl( $dataMap[$attrName] );
                    if ( $url !== '' )
                        return $url;
                }
                elseif ( $dataType == 'ezbinaryfile' )
                {
                    $url = $this->binaryFileUrl( $dataMap[$attrName] );
                    if ( $url !== '' )
                        return $url;
                }
                elseif ( $dataType == 'ezstring' )
                {
                    $url = trim( $dataMap[$attrName]->toString() );
                    if ( $url !== '' )
                        return $url;
                }
            }
        }
        return '';
    }

    protected function plainText( $text, $length )
    {
        $text = html_entity_decode( (string)$text, ENT_QUOTES | ENT_HTML401, 'UTF-8' );
        $text = strip_tags( $text );
        $text = preg_replace( '/\s+/', ' ', $text );
        $text = trim( $text );
        if ( function_exists( 'mb_strlen' ) && function_exists( 'mb_substr' ) )
        {
            if ( mb_strlen( $text, 'utf-8' ) > $length )
                $text = mb_substr( $text, 0, $length, 'utf-8' ) . '...';
        }
        elseif ( strlen( $text ) > $length )
        {
            $text = substr( $text, 0, $length ) . '...';
        }
        return $text;
    }

    protected function currentPageObject()
    {
        $uri = eZURI::instance();
        $elements = $uri->elements( false );
        if ( is_array( $elements ) && count( $elements ) > 0 && $elements[0] === 'index.php' )
            array_shift( $elements );
        $pathString = is_array( $elements ) ? implode( '/', $elements ) : $uri->elements( true );
        $nodeID = eZURLAliasML::fetchNodeIDByPath( $pathString );
        if ( $nodeID )
        {
            $node = eZContentObjectTreeNode::fetch( $nodeID );
            if ( $node )
                return $node->attribute( 'object' );
        }
        $rootNodeID = (int)eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' );
        $rootNode = eZContentObjectTreeNode::fetch( $rootNodeID );
        if ( $rootNode )
            return $rootNode->attribute( 'object' );
        return null;
    }

    protected function saveXML( $value )
    {
        if ( $value instanceof eZContentObjectAttribute && $value->attribute( 'data_type_string' ) == 'ezxmltext' )
        {
            $xml = $value->content();
            if ( $xml instanceof eZXMLText )
                return (string)$xml->attribute( 'xml_string' );
        }
        return (string)$value;
    }

    protected function renderLayout( $value, $params, $operatorName )
    {
        return '';
    }
}

?>