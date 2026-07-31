{def $google_maps_api_key = first_set(parameter($ibexa.configResolver, 'api_keys.google_maps'), '')}

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;key={$google_maps_api_key}"></script>