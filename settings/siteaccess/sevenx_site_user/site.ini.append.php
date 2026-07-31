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

[MediaTheme]
# index.css / index-noncritical.css are the real Webpack Encore build output from
# the Netgen reference theme -- they are the spec. explayouts.css is the
# alpha-side counterpart of the reference's /bundles/netgenlayouts/css/style.css.
#
# exponential.css is deliberately NOT loaded. It was hand-written to approximate
# the Nexus look while the compiled index.css here was a broken 355KB partial
# build. It carries 25 !important rules which fight the real stylesheet and
# produce off-spec colours. Nexus does not use it. Same applies to main.css and
# nexus_to_alpha.css. See ai/doc/issues/issue-667-*.md
CSSFiles[]=explayouts.css
CSSFiles[]=index.css
CSSFiles[]=index-noncritical.css
JSFiles[]=runtime.js
JSFiles[]=index.js
JSFiles[]=index-noncritical.js

*/ ?>
