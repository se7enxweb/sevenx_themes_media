<?php /* #?ini charset="utf-8"?

[TemplateSettings]
ExtensionAutoloadPath[]=sevenx_themes_media

[DesignSettings]
SiteDesign=media
AdditionalSiteDesignList[]
AdditionalSiteDesignList[]=standard
AdditionalSiteDesignList[]=simple
AdditionalSiteDesignList[]=ezwebin
AdditionalSiteDesignList[]=base

[ContentSettings]
RootNode=75
TranslationList=eng-GB

[SiteSettings]
SiteName=Bold Agency
DefaultPage=/content/view/full/75

[RegionalSettings]
Locale=eng-US
ContentObjectLocale=eng-US
ShowUntranslatedObjects=disabled
SiteLanguageList[]
SiteLanguageList[]=eng-US
SiteLanguageList[]=eng-GB
TextTranslation=enabled
TranslationSA[]
TranslationSA[bold]=English
TranslationSA[bold_ger]=Deutsch

[FileSettings]
VarDir=var/site


# Bold Agency is served under its own subtree, so that node is stripped from
# every path. Set here rather than in the installer: eZ's CreateSites step
# rewrites the project's siteaccess settings after the site package installer
# runs, so anything written there is overwritten. The prefix is a fixed
# property of the shipped content, not of a given database.
[SiteAccessSettings]
PathPrefix=bold-agency

*/ ?>
