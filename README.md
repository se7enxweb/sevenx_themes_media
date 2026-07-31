7x Themes: Media
================

General description
-------------------

7x Themes: Media (extension directory: `sevenx_themes_media`) provides the
`media` site design for Exponential 6 / eZ Publish Legacy: the Netgen
media-site theme, originally written in Twig, converted to native eZ4
`.tpl` templates and now hand-maintained — every template under
`design/media/templates/` is first-class source code, not build output.

> **Important — the converter is retired.**
> The templates were originally produced by a Twig-to-TPL conversion script
> (`ai/bin/convert_media_site_twig.py` in the project tree). That script is
> **retired and must never be run again**: the templates have since
> received extensive hand fixes, and a re-run would destroy them. Edit the
> `.tpl` files directly.

> **Note on the name.** Owner decision: while sibling extensions were
> renamed to the `exp*` prefix, this extension deliberately keeps the
> `sevenx_themes_media` name. Do not rename it; the `se7enxweb/` composer
> vendor namespace is likewise correct and stays.

This extension implements a complete front-end theme and provides the
following capabilities:

- The `media` design — ~426 hand-maintained templates (pagelayout,
  content views, layout/zone/block templates, parts, forms, modules,
  emails), stylesheets, javascript and SASS sources.
- The `sevenxThemesMediaOperators` template-operator class — 54 operators
  emulating the Twig functions/filters the templates were converted from.
- The `sevenxThemesMediaField` field wrapper value object returned by the
  `ngsite` globals.
- Siteaccess-scoped settings that configure the design chain, ~166
  template override rules, image aliases, theme asset lists and the
  content root for the `sevenx_site_user` siteaccess.

Features
--------

7x Themes: Media provides the following features:

### The `media` design (`design/media/`)

- `templates/pagelayout.tpl` + `pagelayout/` — page shell, header, footer,
  breadcrumbs, head links/meta/title.
- `templates/content/` — node/view templates selected through the shipped
  `override.ini` rules (`full_*`, `embed_*`, line/listitem/card view
  types) plus `content/parts/` fragments (full_header, full_image,
  full_body, ...).
- `templates/explayouts/` — `layout.tpl`, `zone.tpl` and `block/`
  templates rendered by the `explayouts` engine. These block templates are
  hand-authored and are what actually renders page content.
- `templates/nglayouts/`, `parts/`, `pages/`, `forms/`, `modules/`,
  `emails/`, `error(s)/`, `user/`, `themes/` — supporting views.
- `stylesheets/` + `javascript/` — the compiled theme assets loaded via
  `[MediaTheme]`; `sass/nexus/` holds the SCSS sources they were built
  from.
- Files ending in `.tpl.offer` are staged variants not yet adopted; the
  active file is the one without the suffix.

### Template operators

54 operators registered via `autoloads/eztemplateautoload.php` and
activated by `[TemplateSettings]
ExtensionAutoloadPath[]=sevenx_themes_media`, including `ngsite`, `app`,
`ibexa`, `path`, `content_link`, `image`, `ng_image_alias`, `intro`,
`title`, `enhanced_link`, `embed_image`, `component_content`,
`content_tags`, `ng_query`, `ng_render_field` and `ng_view_content` — the
full annotated list is in [doc/USAGE.md](doc/USAGE.md).

### Siteaccess configuration (auto-provided on activation)

- `[DesignSettings] SiteDesign=media` with the fallback chain `standard`,
  `simple`, `ezwebin`, `base`.
- `[TemplateSettings] ExtensionAutoloadPath[]=sevenx_themes_media` —
  registers the template operators.
- `[MediaTheme] CSSFiles[]` (`explayouts.css`, `index.css`,
  `index-noncritical.css`) and `JSFiles[]` (`runtime.js`, `index.js`,
  `index-noncritical.js`) — the asset lists the `media` pagelayout loads.
- ~166 `override.ini` rules mapping content classes to the design's
  `full_*` / `embed_*` / `ng_*` view templates.
- The full `image.ini` alias list the templates request (`small`,
  `medium`, `large`, `listitem`, `i160`, `i480`, `logo`, `billboard`,
  ...).
- `content.ini` `[NodeSettings] RootNode` pointing at the media-site
  content root shipped by `expsite_data_media`.

### Key classes and parts

| Part | File | Purpose |
|------|------|---------|
| `sevenxThemesMediaOperators` | `autoloads/sevenxthemesmediaoperators.php` | Template operators (`ngsite`, `intro`, `image`, `enhanced_link`, `content_tags`, ... — full list in [doc/USAGE.md](doc/USAGE.md)) |
| `sevenxThemesMediaField` | `autoloads/sevenxthemesmediaoperators.php` | Field wrapper value object returned by the `ngsite` globals |
| Operator registration | `autoloads/eztemplateautoload.php` | `$eZTemplateOperatorArray` binding; activated via `[TemplateSettings] ExtensionAutoloadPath[]=sevenx_themes_media` |
| The `media` design | `design/media/` | ~426 hand-maintained templates (`pagelayout`, `content/`, `explayouts/`, `nglayouts/`, `parts/`, ...), stylesheets, javascript, sass sources |
| Siteaccess settings | `settings/siteaccess/sevenx_site_user/` | `site.ini` (design chain, operator autoload path, `[MediaTheme]` asset lists), `override.ini` (~166 template override rules), `image.ini` (alias list incl. `i160`/`i480`), `content.ini` (`RootNode`), `design.ini` |
| Global settings | `settings/` | `design.ini.append.php` (design source registration), `image.ini.append.php` (`i160`/`i480` aliases), `site.ini.append.php` (intentionally contentless — see file comment) |

Version
-------

- The current version of 7x Themes: Media is 1.0.0
- Last Major update: July 30, 2026

Copyright
---------

- 7x Themes: Media is copyright 1998 - 2026 7x
- See: LICENSE.md for more information on the terms of the copyright and
  license

License
-------

7x Themes: Media is licensed under the GNU General Public License.

The complete license agreement is included in the LICENSE.md file.

7x Themes: Media is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License or at your
option a later version.

7x Themes: Media is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

The GNU GPL gives you the right to use, modify and redistribute
7x Themes: Media under certain conditions. The GNU GPL license
is distributed with the software, see the file LICENSE.md.

It is also available at https://www.gnu.org/licenses/gpl.txt

You should have received a copy of the GNU General Public License
along with 7x Themes: Media in LICENSE.md. If not, see
https://www.gnu.org/licenses/.

Using 7x Themes: Media under the terms of the GNU GPL is free (as in
freedom).

For more information or questions please contact info@se7enx.com

Requirements
------------

The following requirements exist for using the 7x Themes: Media extension:

Exponential / eZ Publish version
- Make sure you use Exponential 6 (eZ Publish Legacy) or higher.

PHP version
- Make sure you have PHP 8.1 or higher.

Sibling extensions
- `explayouts` — active; it renders the layout/zone/block structure, while
  this theme provides the matching `explayouts/` and `nglayouts/` block
  templates.
- `expsite_data_media` — installed; it provides the media-site content
  model and data the theme renders (the shipped `content.ini` `RootNode`
  points at its data).
- `expsite_api` / `expquery` classes — where present, the operators
  resolve `expSiteAPIContent` / `expSiteAPILocation` value objects
  transparently.

Image handling
- ImageMagick enabled in `image.ini` so the theme's image aliases can be
  generated.

Installation
------------

In short: copy or check out the extension into
`extension/sevenx_themes_media` and add the single bootstrap line to your
siteaccess settings —
`[ExtensionSettings] ActiveAccessExtensions[]=sevenx_themes_media` — listed
before more generic theme extensions. Everything else (design chain,
override rules, image aliases, `[MediaTheme]` asset lists, content root) is
auto-provided by the extension's own
`settings/siteaccess/sevenx_site_user/` files. Then regenerate autoloads
and clear caches.

Note that the scoped settings only merge for a siteaccess literally named
`sevenx_site_user`; for another name, copy the scoped settings directory as
described in the install guide.

See [INSTALL.md](INSTALL.md) for the complete step-by-step activation,
what is auto-provided, the different-siteaccess-name procedure and
verification steps.

Usage
-----

### How a page renders

1. The siteaccess design chain is `media` → `standard` → `simple` →
   `ezwebin` → `base` (shipped `site.ini.append.php`).
2. `override.ini` (~166 rules) picks the `full_*`/`embed_*` template for
   the content class being viewed.
3. Layout pages are resolved by `explayouts`; its zones/blocks render
   through `templates/explayouts/` and the hand-authored block templates.
4. The pagelayout loads the `[MediaTheme]` asset lists:
   CSS `explayouts.css`, `index.css`, `index-noncritical.css`;
   JS `runtime.js`, `index.js`, `index-noncritical.js`.

### Template operators

`sevenxThemesMediaOperators` emulates the Twig functions/filters the
templates were converted from. Complete `$Operators` list:

`absolute_url`, `app`, `asset`, `content_link`, `content_tags`,
`controller`, `twig_block_template`, `layout_title`, `embed_image`,
`component_content`, `enhanced_link`, `fieldRelation`, `fieldRelations`,
`fieldValue`, `filterChildren`, `filterFieldRelationLocations`,
`filterFieldRelations`, `getParameter`, `get_netgen_open_graph`,
`hasField`, `hasParameter`, `haveToPaginate`, `ibexa`, `ibexa_path`,
`ibexa_url`, `image`, `image_link`, `intro`, `item_content_link`,
`item_image_link`, `item_params`, `ng_image_alias`, `ng_query`,
`ng_render_field`, `ng_view_content`, `nglayouts_render_result`,
`nglayouts_render_zone`, `ngsite`, `ngsite_group_fields`,
`ngsite_language_name`, `ngsite_topic_path`, `pagerfanta`, `parameter`,
`parent`, `path`, `player`, `player_slide`, `poster`, `poster_slide`,
`redirect_to_site_root`, `render`, `render_esi`, `saveXML`, `title`,
`trans`.

Highlights:

- `ngsite()` — site-info globals (fields of the `ng_site_info` object,
  wrapped as `sevenxThemesMediaField` objects); `app()` and `ibexa()`
  provide request/root-location globals.
- `path` / `ibexa_path` / `content_link` / `absolute_url` / `ibexa_url` —
  URL generation from nodes, objects, `expSiteAPIContent` /
  `expSiteAPILocation` value objects or strings.
- `image` / `ng_image_alias` / `poster` — image alias URLs from `ezimage`
  attributes or alias handlers.
- `title` / `intro` — teaser text. `intro` reads only
  `teaser_intro`/`full_intro` (it never falls back to `description`); pass
  an explicit field list as the third argument to intro from another
  field.
- `ng_render_field` / `ng_view_content` — attribute/content rendering.
- `ng_query('subtree')` — child fetch driven by the category's
  `children_class_filter_include`, `page_limit` and `fetch_subtree`
  fields.
- `enhanced_link`, `embed_image`, `component_content` — resolve imported
  references from the reference data set.
- `content_tags` — tags from the imported `eztags` link tables.
- `twig_block_template`, `layout_title`, `item_params`,
  `redirect_to_site_root` — layout-support helpers.
- Compatibility no-ops that intentionally return an empty string:
  `pagerfanta`, `haveToPaginate`, `controller`, `render`, `render_esi`,
  `player`, `player_slide`, `poster_slide`, `ngsite_group_fields`,
  `ngsite_language_name`, `ngsite_topic_path`, `nglayouts_render_result`,
  `nglayouts_render_zone`.

### Image aliases

Shipped in `settings/siteaccess/sevenx_site_user/image.ini.append.php`
(plus `i160`/`i480` globally in `settings/image.ini.append.php`):

| Alias | Geometry |
|---|---|
| `small` | 100x160 scaledown |
| `medium` | 200x290 |
| `large` | 360x440 |
| `i160` | 160x106 scaledown |
| `i480` | width 480 scaledown |
| `listitem`, `articleimage`, `articlethumbnail`, `gallerythumbnail`, `galleryline`, `imagelarge`, `rss`, `logo`, `infoboximage`, `billboard` | See the shipped `image.ini` |

Use them from templates via the shipped operators
(`image( $field, 'i480' )`) or the standard
`attribute_view_gui`/`image_alias` mechanisms.

### Customization

All customization happens from outside the extension — do not edit the
shipped templates or settings in place unless you are maintaining the theme
itself. See [doc/USAGE.md](doc/USAGE.md) for the full guide to the three
customization layers:

- Settings layer — the INI cascade: extend or replace the `[MediaTheme]`
  asset lists, add or redefine image aliases, add or redefine template
  override rules, or point the theme at a different content root.
- Template layer — the design override cascade: prepend your own design to
  the chain and shadow any shipped template at the same relative path.
- PHP layer — register your own operator class side by side, shadow an
  operator name via autoload-path order, hand wrapped or raw
  `eZContentObject(TreeNode)` values to the theme, or add new block types
  in `explayouts` with a matching template.

Documentation
-------------

| Document | Contents |
|---|---|
| [INSTALL.md](INSTALL.md) | Activation (`ActiveAccessExtensions[]`), what the siteaccess settings auto-provide, using a different siteaccess name |
| [doc/USAGE.md](doc/USAGE.md) | Template structure, the full annotated operator list, image aliases, and the settings/template/PHP customization layers |
| [doc/FAQ.md](doc/FAQ.md) | Common questions — including the extension name and the retired converter |
| [doc/TODO.md](doc/TODO.md) | Honest, code-observed gaps |
| [doc/SUPPORT.md](doc/SUPPORT.md) | Support channels and security reporting |
| [LICENSE.md](LICENSE.md) | The complete GNU General Public License agreement |

Troubleshooting
---------------

Read the FAQ
- Some problems are more common than others. The most common ones are
  listed in [doc/FAQ.md](doc/FAQ.md).

Use our support systems
- If you have any questions not handled by this document or the FAQ, or if
  you find a bug or defect, please report it to the
  [7x Themes: Media Issue Tracker](https://github.com/se7enxweb/sevenx_themes_media/issues).
  Include your Exponential and PHP versions, the siteaccess name, the
  template path involved and a URL that reproduces the rendering problem.
- If you discover a security issue, please responsibly report it privately
  by e-mail to info@se7enx.com instead of opening a public issue.
- Commercial support, custom development and hosting for Exponential
  installations are available from 7x: https://se7enx.com
