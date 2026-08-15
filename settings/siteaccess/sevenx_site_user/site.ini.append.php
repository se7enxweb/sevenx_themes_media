<?php /* #?ini charset="utf-8"?

[TemplateSettings]
ExtensionAutoloadPath[]
ExtensionAutoloadPath[]=sevenx_themes_media

[DesignSettings]
SiteDesign=media
AdditionalSiteDesignList[]
AdditionalSiteDesignList[]=standard
AdditionalSiteDesignList[]=simple
AdditionalSiteDesignList[]=ezwebin
AdditionalSiteDesignList[]=base

[MediaTheme]
# index.css / index-noncritical.css are the real Webpack Encore build output from
# the Netgen reference theme -- they are the spec. explayouts.css is the alpha-side
# counterpart of the reference's /bundles/netgenlayouts/css/style.css.
#
# exponential.css is deliberately NOT loaded. It was hand-written to approximate the
# Nexus look while the compiled index.css here was a broken 355KB partial build. It
# carries 25 !important rules which fight the real stylesheet and produce off-spec
# colours. Nexus does not use it. Same applies to main.css and nexus_to_alpha.css.
# See ai/doc/issues/issue-667-*.md
CSSFiles[]
CSSFiles[]=explayouts.css
CSSFiles[]=index.css
CSSFiles[]=index-noncritical.css
JSFiles[]
JSFiles[]=runtime.js
JSFiles[]=index.js
JSFiles[]=index-noncritical.js

[ContentSettings]
RootNode=76
TranslationList=eng-GB

[SiteSettings]
SiteName=Fit & Healthy
SiteDescription=An Exponential multisite installation
IndexPage=/content/view/full/76
DefaultPage=/content/view/full/76
RootNodeDepth=2
MetaDataArray[]
MetaDataArray[author]=7x
MetaDataArray[copyright]=7x
MetaDataArray[description]=An Exponential multisite installation
MetaDataArray[keywords]=exponential, multisite, siteaccess

[RegionalSettings]
Locale=eng-US
ContentObjectLocale=eng-US
ShowUntranslatedObjects=disabled
SiteLanguageList[]
SiteLanguageList[]=eng-US
SiteLanguageList[]=eng-GB
TextTranslation=enabled

[FileSettings]
VarDir=var/site

[MailSettings]
AdminEmail=info@se7enx.com
EmailSender=

*/ ?>
