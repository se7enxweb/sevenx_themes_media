<?php
/**
 * The code of extension/sevenx_themes_media/modules/info-collection/viewmodal.php, moved into a class (#207 stage 1). The file extension/sevenx_themes_media/modules/info-collection/viewmodal.php is one call to it.
 * Guide: doc/bc/6.0/cli_cronjob_view_abstractions.md
 */

namespace Exponential\View\Extension\SevenxThemesMedia\InfoCollection
{

class Viewmodal extends \Exponential\Runnable\ModuleView
{
    public function run( array $scope )
    {
        // the including function's variables ($Params, $Module, $cli, ...)
        foreach ( array_keys( $scope ) as $__name )
            if ( $__name !== 'this' && $__name !== 'scope' )
                ${$__name} = &$scope[$__name];
        unset( $__name );

        $module = $Params['Module'];

        $formContentId = isset( $Params['FormContentId'] ) ? (int)$Params['FormContentId'] : 0;
        $refererLocationId = isset( $Params['RefererLocationId'] ) ? (int)$Params['RefererLocationId'] : 0;

        if ( $formContentId < 1 )
            return $this->viewResult( isset( $Result ) ? $Result : null,  $module->handleError( \eZError::KERNEL_NOT_AVAILABLE, 'kernel' ) );

        $object = \eZContentObject::fetch( $formContentId );
        if ( !$object instanceof \eZContentObject )
            return $this->viewResult( isset( $Result ) ? $Result : null,  $module->handleError( \eZError::KERNEL_NOT_AVAILABLE, 'kernel' ) );

        $node = \eZContentObjectTreeNode::fetch( $object->attribute( 'main_node_id' ) );
        if ( !$node instanceof \eZContentObjectTreeNode )
            return $this->viewResult( isset( $Result ) ? $Result : null,  $module->handleError( \eZError::KERNEL_NOT_AVAILABLE, 'kernel' ) );

        if ( !$object->canRead() )
            return $this->viewResult( isset( $Result ) ? $Result : null,  $module->handleError( \eZError::KERNEL_ACCESS_DENIED, 'kernel' ) );

        $tpl = \eZTemplate::factory();
        $tpl->setVariable( 'content', $object );
        $tpl->setVariable( 'location', $node );
        $tpl->setVariable( 'node', $node );
        $tpl->setVariable( 'object', $object );
        $tpl->setVariable( 'referer', $refererLocationId );
        $tpl->setVariable( 'refererLocationId', $refererLocationId );

        $GLOBALS['eZDebugEnabled'] = false;

        $Result = array();
        $Result['content'] = $tpl->fetch( 'design:content/views/modal/form_common.tpl' );
        $Result['pagelayout'] = false;
        $Result['path'] = array( array( 'url' => false,
                                        'text' => $object->attribute( 'name' ) ) );
        $Result['node_id'] = $node->attribute( 'node_id' );

        return $this->viewResult( isset( $Result ) ? $Result : null,  $Result );

        return $this->viewResult( isset( $Result ) ? $Result : null, null );
    }
}

}
