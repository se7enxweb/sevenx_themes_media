<?php /* #?ini charset="utf-8"?

# The user siteaccess serves the Fit & Healthy subtree at the web root, so that
# node has to be stripped from every path.
#
# This lives here rather than in the installer because eZ's own CreateSites step
# rewrites settings/siteaccess/<sa>/site.ini.append.php after the site package's
# installer has finished - anything the installer writes there is overwritten,
# which is why a clean install produced an empty PathPrefix and every page below
# the site root answered 404. Extension settings are not rewritten, and the
# prefix is a fixed property of the shipped content, not of a given database.

[SiteAccessSettings]
PathPrefix=fit-healthy

*/ ?>
