# Installing sevenx_themes_media

## Requirements

- Exponential Legacy 6.x, PHP 8.1+.
- `explayouts` active (block/zone rendering used by the theme's layout
  templates).
- `expsite_data_media` installed (the content model and content root the
  theme renders; the shipped `content.ini` `RootNode` points at its data).
- ImageMagick enabled in `image.ini` so the theme's image aliases can be
  generated.

## 1. Get the extension

Copy or check out the extension into `extension/sevenx_themes_media`.

## 2. Activate — the one bootstrap line

The extension is **siteaccess-scoped**. An extension cannot activate itself,
so the single line a siteaccess needs, in
`settings/siteaccess/<your-siteaccess>/site.ini.append.php`, is:

```ini
[ExtensionSettings]
ActiveAccessExtensions[]=sevenx_themes_media
```

Order matters relative to other design extensions: list
`sevenx_themes_media` before more generic theme extensions (for example
`sevenx_themes_simple`) so its design fallbacks are found first.

## 3. What activation auto-provides

Everything else ships inside the extension's own
`settings/siteaccess/sevenx_site_user/` directory and applies automatically
to the `sevenx_site_user` siteaccess:

- `site.ini.append.php` — `SiteDesign=media` + fallback design chain,
  `ExtensionAutoloadPath[]` for the template operators, and the
  `[MediaTheme]` CSS/JS asset lists.
- `override.ini.append.php` — ~166 template override rules.
- `image.ini.append.php` — the complete image alias list.
- `content.ini.append.php` — `[NodeSettings] RootNode` (media content root)
  and related browse/version-view settings.
- `design.ini.append.php` — site/classes CSS package files.

**Using a different siteaccess name?** The scoped settings only merge for a
siteaccess literally named `sevenx_site_user`. For another name, copy
`extension/sevenx_themes_media/settings/siteaccess/sevenx_site_user/` to
`extension/sevenx_themes_media/settings/siteaccess/<your-siteaccess>/` (or
into the global `settings/siteaccess/<your-siteaccess>/`).

Note: the extension's root `settings/site.ini.append.php` is intentionally
contentless — root-level site.ini appends from access-scoped extensions
merged unreliably on this stack, so the real registration lives in the
`settings/siteaccess/<sa>/` placement (see the comment in the file and
`ai/doc/SETTINGS_REQUIRED.md` in the project root).

## 4. Regenerate autoloads and clear caches

```bash
php bin/php/ezpgenerateautoloads.php -e
php bin/php/ezcache.php --clear-all --allow-root-user
```

Restart PHP-FPM if the web runtime caches classes:

```bash
systemctl restart php-fpm
```

## 5. Verify

Load the front page of the siteaccess. The `media` pagelayout should render
with the `[MediaTheme]` stylesheets (`explayouts.css`, `index.css`,
`index-noncritical.css`) and scripts (`runtime.js`, `index.js`,
`index-noncritical.js`) in the page head, and content pages should use the
`full_*` override templates from `design/media/templates/`.
