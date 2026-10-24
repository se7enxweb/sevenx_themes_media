<?php

// A minimal eztags datatype for installations without eZ Tags. Where the eztags extension is
// installed beside this one, the autoload array can still name this file for eZTagsType (the
// generator keeps the first definition it meets): the real datatype is loaded instead, or the
// tags admin failed with "Undefined constant eZTagsType::SUBTREE_LIMIT_FIELD" and tags stayed
// empty in the edit form. The class is declared inside the else branch, so PHP does not bind it
// before the check.
if ( is_file( __DIR__ . '/../../../eztags/datatypes/eztags/eztagstype.php' ) )
{
    require_once __DIR__ . '/../../../eztags/datatypes/eztags/eztagstype.php';
}
else
{

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
}
