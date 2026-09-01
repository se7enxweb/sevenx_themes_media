<?php
$module = $Params['Module'];

$formContentId = isset( $Params['FormContentId'] ) ? (int)$Params['FormContentId'] : 0;
$refererLocationId = isset( $Params['RefererLocationId'] ) ? (int)$Params['RefererLocationId'] : 0;

if ( $formContentId < 1 )
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

$object = eZContentObject::fetch( $formContentId );
if ( !$object instanceof eZContentObject )
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

$node = eZContentObjectTreeNode::fetch( $object->attribute( 'main_node_id' ) );
if ( !$node instanceof eZContentObjectTreeNode )
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

if ( !$object->canRead() )
    return $module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel' );

$tpl = eZTemplate::factory();
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

return $Result;
