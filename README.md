# sevenx_themes_media

7x Themes : Media — the `media` site design for Exponential Legacy /
Exponential 6.

Copyright (C) 1998 - 2026 7x. All rights reserved.
Licensed under the GNU General Public License v2.0 (or any later version).

## About

This extension provides the **`media` design**: the Netgen media-site theme,
originally written in Twig, converted to native eZ4 `.tpl` templates and now
**hand-maintained** — every template under `design/media/templates/` is
first-class source code, not build output.

> **Important — the converter is retired.**
> The templates were originally produced by a Twig-to-TPL conversion script
> (`ai/bin/convert_media_site_twig.py` in the project tree). That script is
> **retired and must never be run again**: the templates have since received
> extensive hand fixes, and a re-run would destroy them. Edit the `.tpl`
> files directly.

Alongside the design, the extension ships the `sevenxThemesMediaOperators`
template-operator class (54 operators emulating the Twig functions/filters
the templates were converted from) and a set of siteaccess-scoped settings
that configure the design chain, template overrides, image aliases, theme
assets and content root for the `sevenx_site_user` siteaccess.

## Key classes and parts

| Part | File | Purpose |
|------|------|---------|
| `sevenxThemesMediaOperators` | `autoloads/sevenxthemesmediaoperators.php` | Template operators (`ngsite`, `intro`, `image`, `enhanced_link`, `content_tags`, ... — full list in `doc/USAGE.md`) |
| `sevenxThemesMediaField` | `autoloads/sevenxthemesmediaoperators.php` | Field wrapper value object returned by the `ngsite` globals |
| Operator registration | `autoloads/eztemplateautoload.php` | `$eZTemplateOperatorArray` binding; activated via `[TemplateSettings] ExtensionAutoloadPath[]=sevenx_themes_media` |
| The `media` design | `design/media/` | ~426 hand-maintained templates (`pagelayout`, `content/`, `explayouts/`, `nglayouts/`, `parts/`, ...), stylesheets, javascript, sass sources |
| Siteaccess settings | `settings/siteaccess/sevenx_site_user/` | `site.ini` (design chain, operator autoload path, `[MediaTheme]` asset lists), `override.ini` (~166 template override rules), `image.ini` (alias list incl. `i160`/`i480`), `content.ini` (`RootNode`), `design.ini` |
| Global settings | `settings/` | `design.ini.append.php` (design source registration), `image.ini.append.php` (`i160`/`i480` aliases), `site.ini.append.php` (intentionally contentless — see file comment) |

## What the siteaccess settings provide

Once a siteaccess activates the extension, its
`settings/siteaccess/sevenx_site_user/` files configure:

- `[DesignSettings] SiteDesign=media` with the fallback chain `standard`,
  `simple`, `ezwebin`, `base`.
- `[TemplateSettings] ExtensionAutoloadPath[]=sevenx_themes_media` — registers
  the template operators.
- `[MediaTheme] CSSFiles[]` (`explayouts.css`, `index.css`,
  `index-noncritical.css`) and `JSFiles[]` (`runtime.js`, `index.js`,
  `index-noncritical.js`) — the asset lists the `media` pagelayout loads.
- ~166 `override.ini` rules mapping content classes to the design's
  `full_*` / `embed_*` / `ng_*` view templates.
- The full `image.ini` alias list the templates request (`small`, `medium`,
  `large`, `listitem`, `i160`, `i480`, `logo`, `billboard`, ...).
- `content.ini` `[NodeSettings] RootNode` pointing at the media-site content
  root shipped by `expsite_data_media`.

## Dependencies

- `explayouts` — renders the layout/zone/block structure; the theme provides
  the matching `explayouts/` and `nglayouts/` block templates.
- `expsite_data_media` — the media-site content model and data the theme
  renders.
- `expsite_api` / `expquery` classes — the operators resolve
  `expSiteAPIContent` / `expSiteAPILocation` value objects where present.

## Documentation

- `INSTALL.md` — activation (`ActiveAccessExtensions[]`) and what is
  auto-provided.
- `doc/USAGE.md` — template override structure, the full operator list,
  image aliases, customization from outside the extension.
- `doc/FAQ.md` — common questions (including the extension name and the
  retired converter).
- `doc/TODO.md` — honest, code-observed gaps.
- `doc/SUPPORT.md` — support channels.
