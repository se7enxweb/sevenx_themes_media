<?php
$Module = array( 'name' => 'info-collection',
                 'variable_params' => true );

$ViewList = array();
$ViewList['view-modal'] = array(
    'script' => 'viewmodal.php',
    'functions' => array( 'read' ),
    'default_navigation_part' => 'ezcontentnavigationpart',
    'params' => array( 'FormContentId', 'RefererLocationId' )
);

$ViewList['submit'] = array(
    'script' => 'submit.php',
    'functions' => array( 'read' ),
    'default_navigation_part' => 'ezcontentnavigationpart',
    'params' => array( 'FormContentId' )
);

$FunctionList = array();
$FunctionList['read'] = array();
