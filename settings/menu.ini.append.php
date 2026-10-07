<?php /* #?ini charset="utf-8"?

# Defaults for every media siteaccess; a siteaccess's own menu.ini may override them.
# ezini() with constant arguments is read when a template is compiled, so a setting
# that is missing logs "No such variable" even where the template checks
# ezini_hasvariable() first; giving both a default keeps those reads quiet.
[SiteInfo]
# The cookie policy version (pagelayout/cookie_control.tpl); raise it to ask visitors again.
CookieConsentVersion=1
# The remote id of the folder whose links form the second footer line (pagelayout/footer.tpl).
FooterLinksRemoteID=media-o-footer-links

*/ ?>
