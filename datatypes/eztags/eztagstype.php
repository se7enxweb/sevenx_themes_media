<?php

class eZTagsType extends eZDataType
{
    const DATA_TYPE_STRING = 'eztags';

    public function __construct()
    {
        parent::__construct( self::DATA_TYPE_STRING, ezpI18n::tr( 'kernel/classes/datatypes', 'Tags', 'Datatype name' ),
                             array( 'serialize_supported' => false ) );
    }

    public function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        return eZInputValidator::STATE_ACCEPTED;
    }

    public function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        return true;
    }

    public function objectAttributeContent( $contentObjectAttribute )
    {
        return '';
    }

    public function hasObjectAttributeContent( $contentObjectAttribute )
    {
        return false;
    }

    public function isEmpty( $contentObjectAttribute )
    {
        return true;
    }

    public function title( $contentObjectAttribute, $name = null )
    {
        return '';
    }
}

eZDataType::register( eZTagsType::DATA_TYPE_STRING, new eZTagsType() );
