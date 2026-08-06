<?php
/**
 * File containing the sevenxThemesMediaXHTMLXMLOutput class.
 *
 * Extends eZXHTMLXMLOutput to register the legacy XML tag names that the
 * imported content uses (title, itemizedlist, listitem, orderedlist,
 * literallayout, emphasis, ezvalue, ezconfig) so they do not trigger
 * 'Undefined array key' warnings in eZXMLOutputHandler.
 */

class sevenxThemesMediaXHTMLXMLOutput extends eZXHTMLXMLOutput
{
    function __construct( $xmlData, $isAttribute = false, $contentObjectAttribute = null )
    {
        parent::__construct( $xmlData, $isAttribute, $contentObjectAttribute );

        $extraTags = array(
            'title' => array(
                'renderHandler' => 'renderAll',
                'attrNamesTemplate' => array( 'class' => 'classification' ),
                'attrDesignKeys' => array( 'class' => 'classification' ),
            ),
            'itemizedlist' => array(
                'renderHandler' => 'renderAll',
                'attrNamesTemplate' => array( 'class' => 'classification' ),
                'attrDesignKeys' => array( 'class' => 'classification' ),
            ),
            'listitem' => array(
                'renderHandler' => 'renderAll',
                'attrNamesTemplate' => array( 'class' => 'classification' ),
                'attrDesignKeys' => array( 'class' => 'classification' ),
            ),
            'orderedlist' => array(
                'renderHandler' => 'renderAll',
                'attrNamesTemplate' => array( 'class' => 'classification' ),
                'attrDesignKeys' => array( 'class' => 'classification' ),
            ),
            'literallayout' => array(
                'renderHandler' => 'renderAll',
                'attrNamesTemplate' => array( 'class' => 'classification' ),
                'attrDesignKeys' => array( 'class' => 'classification' ),
            ),
            'emphasis' => array(
                'renderHandler' => 'renderAll',
                'attrNamesTemplate' => array( 'class' => 'classification' ),
                'attrDesignKeys' => array( 'class' => 'classification' ),
            ),
            'ezvalue' => array(
                'quickRender' => true,
            ),
            'ezconfig' => array(
                'quickRender' => true,
            ),
        );

        foreach ( $extraTags as $name => $def )
        {
            if ( !isset( $this->OutputTags[$name] ) )
            {
                $this->OutputTags[$name] = $def;
            }
        }
    }
}
