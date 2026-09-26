<?php /* #?ini charset="utf-8"?

# Status codes for the site's error pages (see design/media/templates/error/).
#
# The stock settings sent 401 for "access denied", which asks the browser for
# HTTP credentials the site never uses, and nothing at all for a lost database
# connection or a missing language, so those went out as 200 -- an empty page
# that says it succeeded, and that caches and search engines keep as such.

[ErrorSettings]
# The page for failures outside the template engine -- a fatal error, an
# uncaught exception, a failed database transaction, no database -- sent by
# eZExecution::renderErrorPage(). A static file, since at that point neither
# the database nor the templates can be relied on.
StaticErrorPage[500]=extension/sevenx_themes_media/errors/server-error.html
StaticErrorPage[503]=extension/sevenx_themes_media/errors/server-error.html

[ErrorSettings-kernel]
# Access denied: forbidden, not "authenticate with HTTP". The sign-in form is
# still embedded in the page for a visitor who is signed out.
HTTPError[1]=403
# The requested language is not available for this content.
HTTPError[5]=404
# No database connection: temporary, and says so.
HTTPError[50]=503

[ErrorSettings-shop]
HTTPError[1]=404
# The product cannot go in the basket with what is already there.
HTTPError[2]=409
# The currency does not exist, or is switched off.
HTTPError[3]=404
HTTPError[4]=404

[HTTPError-403]
HTTPName=Forbidden

[HTTPError-409]
HTTPName=Conflict

[HTTPError-503]
HTTPName=Service Unavailable
*/ ?>
