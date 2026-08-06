<?php

class sevenxThemesMediaField
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
        return null;
    }

    public function hasAttribute( $name )
    {
        return in_array( $name, array( 'value', 'empty' ) );
    }
}

class sevenxThemesMediaOperators
{
    public $Operators = array( 'absolute_url', 'app', 'asset', 'content_link', 'content_tags', 'controller', 'twig_block_template', 'layout_title', 'embed_image', 'component_content', 'enhanced_link', 'fieldRelation', 'fieldRelations', 'fieldValue', 'firstNonEmptyField', 'filterChildren', 'filterFieldRelationLocations', 'filterFieldRelations', 'getParameter', 'get_netgen_open_graph', 'hasField', 'hasParameter', 'haveToPaginate', 'ibexa', 'ibexa_path', 'ibexa_url', 'image', 'image_link', 'intro', 'item_content_link', 'item_image_link', 'item_params', 'ng_image_alias', 'ng_query', 'ng_render_field', 'ng_view_content', 'nglayouts_render_result', 'nglayouts_render_zone', 'ngsite', 'ngsite_group_fields', 'ngsite_language_name', 'ngsite_topic_path', 'pagerfanta', 'parameter', 'parent', 'path', 'player', 'player_slide', 'poster', 'poster_slide', 'redirect_to_site_root', 'render', 'render_esi', 'saveXML', 'title', 'trans' );
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
                $operatorValue = $this->viewContent( $arg0, $arg1 );
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

            case 'twig_block_template':
                $operatorValue = $this->twigBlockTemplate( $arg0 );
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
        $classID = eZContentClass::classIDByIdentifier( 'ng_site_info' );
        $siteObject = null;
        if ( $classID )
        {
            $objects = eZContentObject::fetchSameClassList( $classID, true );
            if ( is_array( $objects ) )
            {
                foreach ( $objects as $object )
                {
                    if ( stripos( $object->attribute( 'name' ), 'Bold Agency' ) === false )
                    {
                        $siteObject = $object;
                        break;
                    }
                }
                if ( !$siteObject )
                    $siteObject = reset( $objects );
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
        $rootNodeId = (int)eZINI::instance()->variable( 'ContentSettings', 'RootNode' );
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
                $xml = $attr->content();
                $text = $xml instanceof eZXMLText ? (string)$xml->attribute( 'output' )->outputText() : $attr->toString();
                $value = array( 'text' => $text );
                break;

            case 'ezurl':
                $url = (string)$attr->content();
                $value = array( 'link' => $url, 'text' => $url );
                break;

            case 'ezimage':
                $url = '';
                $handler = $attr->content();
                if ( $handler instanceof eZImageAliasHandler )
                {
                    $original = $handler->imageAlias( 'original' );
                    if ( $original )
                        $url = $original['url'];
                }
                $value = array(
                    'uri' => $url,
                    'id' => (int)$attr->attribute( 'id' ),
                    'alternativeText' => '',
                    'width' => 0,
                    'height' => 0,
                );
                break;

            case 'ezbinaryfile':
                $url = $this->binaryFileUrl( $attr );
                $value = array(
                    'id' => (int)$attr->attribute( 'id' ),
                    'uri' => $url,
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
                $value = array( 'tags' => $tags );
                break;

            case 'novaseometas':
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

        if ( isset( $aliasList[$aliasName] ) && $clusterFileHandler->fileExists( $aliasList[$aliasName]['url'] ) )
            return $aliasList[$aliasName]['url'];

        if ( !isset( $aliasList['original'] ) )
            return '';

        $original = $aliasList['original'];
        if ( !$clusterFileHandler->fileExists( $original['url'] ) )
            return '';

        if ( $aliasName === 'original' )
            return $original['url'];

        $alias = $handler->imageAlias( $aliasName );
        if ( $alias && $clusterFileHandler->fileExists( $alias['url'] ) )
            return $alias['url'];

        return $original['url'];
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
                    return $xml->attribute( 'output' )->outputText();
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

    protected function viewContent( $value, $viewType )
    {
        $node = $this->toNode( $value );
        if ( !$node )
            return '';

        $tpl = eZTemplate::instance();
        $res = $tpl->fetch( 'design:content/view.tpl' );
        return $res;
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
     * The imported nglayouts twig_block blocks lost their template parameter;
     * this is the block-id -> design template mapping (verified against the
     * reference rendering). Unmapped twig blocks render nothing at all, like
     * the reference does for its context-empty twig blocks.
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
            if ( $text === '' )
                $text = $href;
        }
        else
        {
            // internal enhancedlink ids are nexus CONTENT ids (+776 offset)
            $refId = isset( $data['id'] ) ? (int)$data['id'] : 0;
            $object = false;
            if ( $refId > 0 )
            {
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
                    'text' => $text !== '' ? $text : $node->attribute( 'name' ),
                    'target' => '',
                    'video' => false,
                    'video_title' => '',
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
                return array(
                    'href' => '#',
                    'text' => $text !== '' ? $text : $title,
                    'target' => '',
                    'video' => true,
                    'video_title' => $title,
                    'form_embed' => false,
                    'form_modal' => false,
                    'form_object_id' => 0,
                    'form_node_id' => 0,
                );
            }
            if ( $node )
            {
                $href = '/' . $node->attribute( 'url_alias' );
                if ( $text === '' )
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

        return array(
            'href' => $href,
            'text' => $text,
            'target' => ( isset( $data['target'] ) && $data['target'] === 'link_new_tab' ) ? '_blank' : '',
            'video' => false,
            'video_title' => '',
            'form_embed' => false,
            'form_modal' => false,
            'form_object_id' => 0,
            'form_node_id' => 0,
        );
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

    protected function twigBlockTemplate( $blockId )
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
        return isset( $map[$blockId] ) ? $map[$blockId] : '';
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
        $db = eZDB::instance();
        $fieldFilter = '';
        if ( $field !== null && $field !== '' )
        {
            if ( strpos( $field, '-' ) === 0 )
                $fieldFilter = " AND l.field_identifier != '" . $db->escapeString( substr( $field, 1 ) ) . "'";
            else
                $fieldFilter = " AND l.field_identifier = '" . $db->escapeString( $field ) . "'";
        }
        try
        {
            $rows = $db->arrayQuery(
                'SELECT t.id, t.keyword FROM eztags t JOIN eztags_attribute_link l ON l.keyword_id = t.id WHERE l.object_id = ' . (int)$object->attribute( 'id' ) . $fieldFilter . ' ORDER BY t.keyword'
            );
        }
        catch ( Exception $e )
        {
            error_log( 'content_tags pooled query failed (cwd=' . getcwd() . '): ' . $e->getMessage() );
            $rows = array();
        }
        if ( !is_array( $rows ) || count( $rows ) === 0 )
        {
            error_log( 'content_tags pooled query empty for object ' . (int)$object->attribute( 'id' )
                . ' cwd=' . getcwd()
                . ' relative-db-exists=' . ( file_exists( 'var/storage/sqlite3/sqlite.db' ) ? 'yes' : 'no' ) );
            // The pooled eZDB connection can predate the imported eztags
            // tables; fall back to a fresh direct connection.
            $rows = array();
            try
            {
                $direct = new SQLite3( 'var/storage/sqlite3/sqlite.db', SQLITE3_OPEN_READONLY );
                $res = $direct->query(
                    'SELECT t.id, t.keyword FROM eztags t JOIN eztags_attribute_link l ON l.keyword_id = t.id WHERE l.object_id = ' . (int)$object->attribute( 'id' ) . $fieldFilter . ' ORDER BY t.keyword'
                );
                while ( $res && ( $row = $res->fetchArray( SQLITE3_ASSOC ) ) )
                    $rows[] = $row;
                $direct->close();
            }
            catch ( Exception $e )
            {
                error_log( 'content_tags direct query failed: ' . $e->getMessage() );
            }
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
                    if ( $id )
                    {
                        $rel = eZContentObject::fetch( $id );
                        if ( $rel )
                            $out[] = $rel;
                    }
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
            return array();
        return array(
            'title' => (string)$object->attribute( 'name' ),
            'description' => '',
            'image' => '',
        );
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