<?php
$module = $Params['Module'];

$formContentId = isset( $Params['FormContentId'] ) ? (int)$Params['FormContentId'] : 0;

if ( $formContentId < 1 )
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

if ( !isset( $_SERVER['REQUEST_METHOD'] ) || $_SERVER['REQUEST_METHOD'] !== 'POST' )
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

$object = eZContentObject::fetch( $formContentId );
if ( !$object instanceof eZContentObject )
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

if ( !$object->canRead() )
    return $module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel' );

$prefix = 'information_collection_' . $formContentId;
$rawData = isset( $_POST[$prefix] ) && is_array( $_POST[$prefix] ) ? $_POST[$prefix] : array();

$data = array();
$errors = array();

$requiredFields = array( 'sender_first_name', 'sender_last_name', 'sender_email' );
foreach ( $requiredFields as $field )
{
    $value = isset( $rawData[$field]['value'] ) ? trim( $rawData[$field]['value'] ) : '';
    $data[$field] = $value;
    if ( $value === '' )
    {
        $errors[$field] = 'This field is required.';
    }
}

$optionalFields = array( 'sender_middle_name', 'sender_message', 'referer' );
foreach ( $optionalFields as $field )
{
    $data[$field] = isset( $rawData[$field]['value'] ) ? trim( $rawData[$field]['value'] ) : '';
}

$gdpr = isset( $rawData['gdpr_consent']['value'] ) ? trim( $rawData['gdpr_consent']['value'] ) : '';
if ( $gdpr === '' || $gdpr === '0' )
{
    $errors['gdpr_consent'] = 'GDPR Consent not checked';
}
else
{
    $data['gdpr_consent'] = $gdpr;
}

$data['newsletter_1_consent'] = isset( $rawData['newsletter_1_consent']['value'] ) ? trim( $rawData['newsletter_1_consent']['value'] ) : '';

$email = isset( $data['sender_email'] ) ? $data['sender_email'] : '';
if ( $email !== '' && !filter_var( $email, FILTER_VALIDATE_EMAIL ) )
{
    $errors['sender_email'] = 'Enter a valid E-mail';
}

if ( count( $errors ) > 0 )
{
    $tpl = eZTemplate::factory();
    $tpl->setVariable( 'form_object_id', $formContentId );
    $tpl->setVariable( 'form_class', 'embed-form js-form-embed' );
    $tpl->setVariable( 'form_errors', $errors );
    $GLOBALS['eZDebugEnabled'] = false;
    $Result = array();
    $Result['content'] = $tpl->fetch( 'design:explayouts/block/component/_lead_form.tpl' );
    $Result['pagelayout'] = false;
    $Result['path'] = array();
    return $Result;
}

expLayoutsSiteBundleInfoCollection::submit( $formContentId, $data );

$GLOBALS['eZDebugEnabled'] = false;

$Result = array();
$Result['content'] = '<div class="form-success"><p>Thank you! Your message has been sent.</p></div>';
$Result['pagelayout'] = false;
$Result['path'] = array();

return $Result;
