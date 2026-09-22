#?ini charset="utf-8"?

[Packer]
# Put the sources' last modified time in the packed file's name. Static assets
# here are served with "cache-control: public, max-age=31536000", and without
# the time in the name the packed bundle keeps one URL forever -- so an edited
# stylesheet would be rebuilt on disk and never fetched again by anyone who
# already had the old one.
AppendLastModifiedTime=enabled

[ezjscServer]
FunctionList[]=loadMore

[ezjscServer_expajaxloadmore]
Class=expLayoutsAjaxLoadMoreServer
Functions[]=loadMore

[eZJSCore]
# Re-enable the CSS/JS packer for this siteaccess.
#
# sevenx_themes_simple ships settings/siteaccess/site/ezjscore.ini with
# Packer=disabled, and an extension's siteaccess settings outrank both the
# ezjscore default and any extension-level append, so the packer was off here
# while remaining on everywhere else -- including the admin, whose packed
# bundles sit in var/<site>/cache/public/ and show it working.
#
# That, together with the design's head templates emitting raw <link> and
# <script> tags, is why the public site shipped five stylesheets and four
# scripts unpacked: 760 kB gzipped where the packed pair is 213 kB.
#
# 'enabled' rather than a number on purpose: a numeric value forces one pack
# level on every call and overrides what the template asked for. 'enabled'
# just turns packing on and lets each call keep its own level -- 3 for
# stylesheets, 2 for scripts, which is what buildStylesheetTag and
# buildJavascriptTag default to.
Packer=enabled

