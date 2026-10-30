<?php /* #?ini charset="utf-8"?

# Add this group to settings/siteaccess/<siteaccess>/site.ini.append.php, a copy of
# settings/siteaccess/site/site.ini.append.php (replace the copy's [DesignSettings]). Nothing has
# to be activated: lib/smarty renders .stpl templates in every siteaccess. See
# doc/eng-us/features/6.0/smarty-templates.md, "Enable the converted media design in a siteaccess".

# The .stpl port first; the media design stays in the chain after it, for its stylesheets,
# javascript, images and fonts, and for any template the port does not have.
[DesignSettings]
SiteDesign=smarty_media
AdditionalSiteDesignList[]
AdditionalSiteDesignList[]=media
AdditionalSiteDesignList[]=ezwebin
AdditionalSiteDesignList[]=standard
AdditionalSiteDesignList[]=base

*/ ?>
