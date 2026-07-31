# Usage — sevenx_themes_media

See `../INSTALL.md` for activation. Everything here assumes the extension is
active for your siteaccess.

> **Never run the retired Twig converter.** The `.tpl` files under
> `design/media/templates/` are hand-maintained source code. Edit them
> directly; a converter re-run would wipe the hand fixes.

## Template structure

The `media` design (`design/media/`) is organised as:

- `templates/pagelayout.tpl` + `pagelayout/` — page shell, header, footer,
  breadcrumbs, head links/meta/title.
- `templates/content/` — node/view templates selected through the shipped
  `override.ini` rules (`full_*`, `embed_*`, line/listitem/card view types)
  plus `content/parts/` fragments (full_header, full_image, full_body, ...).
- `templates/explayouts/` — `layout.tpl`, `zone.tpl` and `block/` templates
  rendered by the `explayouts` engine. These block templates are
  hand-authored and are what actually renders page content.
- `templates/nglayouts/`, `parts/`, `pages/`, `forms/`, `modules/`,
  `emails/`, `error(s)/`, `user/`, `themes/` — supporting views.
- `stylesheets/` + `javascript/` — the compiled theme assets loaded via
  `[MediaTheme]`; `sass/nexus/` holds the SCSS sources they were built from.
- Files ending in `.tpl.offer` are staged variants not yet adopted; the
  active file is the one without the suffix.

### How a page renders

1. The siteaccess design chain is `media` → `standard` → `simple` →
   `ezwebin` → `base` (shipped `site.ini.append.php`).
2. `override.ini` (~166 rules) picks the `full_*`/`embed_*` template for the
   content class being viewed.
3. Layout pages are resolved by `explayouts`; its zones/blocks render
   through `templates/explayouts/` and the block templates.
4. The pagelayout loads the `[MediaTheme]` asset lists:
   CSS `explayouts.css`, `index.css`, `index-noncritical.css`;
   JS `runtime.js`, `index.js`, `index-noncritical.js`.

## Template operators

`sevenxThemesMediaOperators` (`autoloads/sevenxthemesmediaoperators.php`) is
registered through `autoloads/eztemplateautoload.php` and activated by
`[TemplateSettings] ExtensionAutoloadPath[]=sevenx_themes_media`. The
operators emulate the Twig functions/filters the templates were converted
from. Complete `$Operators` list:

`absolute_url`, `app`, `asset`, `content_link`, `content_tags`,
`controller`, `twig_block_template`, `layout_title`, `embed_image`,
`component_content`, `enhanced_link`, `fieldRelation`, `fieldRelations`,
`fieldValue`, `filterChildren`, `filterFieldRelationLocations`,
`filterFieldRelations`, `getParameter`, `get_netgen_open_graph`, `hasField`,
`hasParameter`, `haveToPaginate`, `ibexa`, `ibexa_path`, `ibexa_url`,
`image`, `image_link`, `intro`, `item_content_link`, `item_image_link`,
`item_params`, `ng_image_alias`, `ng_query`, `ng_render_field`,
`ng_view_content`, `nglayouts_render_result`, `nglayouts_render_zone`,
`ngsite`, `ngsite_group_fields`, `ngsite_language_name`,
`ngsite_topic_path`, `pagerfanta`, `parameter`, `parent`, `path`, `player`,
`player_slide`, `poster`, `poster_slide`, `redirect_to_site_root`,
`render`, `render_esi`, `saveXML`, `title`, `trans`.

Highlights:

- `ngsite()` — site-info globals (fields of the `ng_site_info` object,
  wrapped as `sevenxThemesMediaField` objects); `app()` and `ibexa()`
  provide request/root-location globals.
- `path` / `ibexa_path` / `content_link` / `absolute_url` / `ibexa_url` —
  URL generation from nodes, objects, `expSiteAPIContent` /
  `expSiteAPILocation` value objects or strings.
- `image` / `ng_image_alias` / `poster` — image alias URLs from `ezimage`
  attributes or alias handlers.
- `title` / `intro` — teaser text. **`intro` reads only
  `teaser_intro`/`full_intro`** (never falls back to `description`); pass an
  explicit field list as the third argument to intro from another field.
- `ng_render_field` / `ng_view_content` — attribute/content rendering.
- `ng_query('subtree')` — child fetch driven by the category's
  `children_class_filter_include`, `page_limit` and `fetch_subtree` fields.
- `enhanced_link`, `embed_image`, `component_content` — resolve imported
  Nexus references (they apply the +776 object / +554 node id offsets of the
  imported data set).
- `content_tags` — tags from the imported `eztags` link tables.
- `twig_block_template`, `layout_title`, `item_params`,
  `redirect_to_site_root` — layout-support helpers.
- Compatibility no-ops that intentionally return an empty string:
  `pagerfanta`, `haveToPaginate`, `controller`, `render`, `render_esi`,
  `player`, `player_slide`, `poster_slide`, `ngsite_group_fields`,
  `ngsite_language_name`, `ngsite_topic_path`, `nglayouts_render_result`,
  `nglayouts_render_zone`.

## Image aliases

Shipped in `settings/siteaccess/sevenx_site_user/image.ini.append.php`
(plus `i160`/`i480` globally in `settings/image.ini.append.php`):

`small` (100x160 scaledown), `medium` (200x290), `large` (360x440),
`listitem`, `articleimage`, `articlethumbnail`, `gallerythumbnail`,
`galleryline`, `imagelarge`, `i160` (160x106 scaledown), `i480`
(width 480 scaledown), `rss`, `logo`, `infoboximage`, `billboard`.

Use them from templates via the shipped operators
(`image( $field, 'i480' )`) or the standard
`attribute_view_gui`/`image_alias` mechanisms.

---

## Customization

All customization happens from *outside* the extension — do not edit the
shipped templates or settings in place unless you are maintaining the theme
itself.

### Settings layer (INI cascade)

INI values merge in ascending priority:

1. Extension defaults — `extension/sevenx_themes_media/settings/` (global)
   and `extension/sevenx_themes_media/settings/siteaccess/<sa>/`
   (siteaccess-scoped; this is where the theme's real configuration lives).
2. Install-level siteaccess settings —
   `settings/siteaccess/<sa>/<file>.ini.append.php`.
3. Global override — `settings/override/<file>.ini.append.php` (wins over
   everything).

Practical recipes:

- **Change/extend the `[MediaTheme]` asset lists** — add to
  `settings/siteaccess/<sa>/site.ini.append.php`:

  ```ini
  [MediaTheme]
  CSSFiles[]=my_site_tweaks.css
  JSFiles[]=my_site_tweaks.js
  ```

  and ship those files in your own design's `stylesheets/`/`javascript/`
  directories. To *replace* the lists, reset first (`CSSFiles[]` on its own
  line clears the array).

- **Add or change an image alias** — same cascade in `image.ini.append.php`:

  ```ini
  [AliasSettings]
  AliasList[]=hero_wide

  [hero_wide]
  Reference=
  Filters[]
  Filters[]=geometry/scalewidthdownonly=1600
  ```

  Redefining a shipped alias block (e.g. `[i480]`) in a higher layer changes
  its filters; clear caches and the alias regenerates on next request.

- **Add or change template override rules** — append your own blocks in
  `settings/siteaccess/<sa>/override.ini.append.php`; a block with the same
  name as a shipped rule (e.g. `[full_article]`) redefines it, so you can
  point a class at your own template file.

- **Point the theme at a different content root** — override
  `[NodeSettings] RootNode` in `content.ini.append.php`.

Always clear caches after INI changes:
`php bin/php/ezcache.php --clear-all --allow-root-user`.

### Template layer (design override cascade)

The design chain is `media` → `standard` → `simple` → `ezwebin` → `base`.
To override any shipped template *without touching the extension*, provide
the same relative path in a design searched **before** `media`:

1. Create your own design extension (or use the install's `design/` tree)
   with a design, e.g. `design/mysite/`.
2. Prepend it to the chain in your siteaccess settings:

   ```ini
   [DesignSettings]
   SiteDesign=mysite
   AdditionalSiteDesignList[]
   AdditionalSiteDesignList[]=media
   AdditionalSiteDesignList[]=standard
   AdditionalSiteDesignList[]=simple
   AdditionalSiteDesignList[]=ezwebin
   AdditionalSiteDesignList[]=base
   ```

3. Copy the template you want to change — e.g.
   `design/media/templates/pagelayout/header.tpl` →
   `design/mysite/templates/pagelayout/header.tpl` — and edit the copy.

The same works for override-rule targets: either shadow the same
`templates/full/article.tpl` path in your design, or redefine the
`override.ini` rule to point at your own `MatchFile`.

### PHP layer (safe extension points)

- **Extra template operators** — do not extend the shipped class in place.
  Register your own operator class from your own extension via an
  `autoloads/eztemplateautoload.php` and
  `[TemplateSettings] ExtensionAutoloadPath[]=<your_extension>`; both
  operator sets are then available side by side.
- **Shadowing an operator** — operator names are resolved in autoload-path
  order, so an extension listed after `sevenx_themes_media` can re-register
  an operator name to change its behaviour (use sparingly; prefer new
  names).
- **Value-object integration** — operators transparently unwrap
  `expSiteAPIContent` / `expSiteAPILocation` (from the `expsite_api` layer),
  so custom fetch functions can hand either wrapped or raw
  `eZContentObject(TreeNode)` values to the theme.
- **Block rendering** — new block types belong in `explayouts` (block
  definitions) plus a matching block template; the theme only supplies
  templates, so a custom block only needs its template placed in a design
  the chain can see.

Regenerate autoloads after adding classes:
`php bin/php/ezpgenerateautoloads.php -e`.
