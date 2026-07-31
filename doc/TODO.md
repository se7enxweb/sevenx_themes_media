# TODO — sevenx_themes_media

Honest, code-observed items.

## Templates and assets

- Review the `*.tpl.offer` staged templates under `design/media/templates/`
  (pagelayout, pagelayout/*, forms/theme, pages/search): adopt (drop the
  `.offer` suffix) or remove each.
- Remove the editor backup file
  `design/media/stylesheets/main.css~`.
- Decide the fate of `exponential.css`, `nexus_to_alpha.css` and `main.css`:
  the `[MediaTheme]` comment in
  `settings/siteaccess/sevenx_site_user/site.ini.append.php` documents that
  they are deliberately not loaded by the media pagelayout (they fight the
  compiled `index.css`), yet the extension's root
  `settings/design.ini.append.php` still adds `exponential.css` and
  `nexus_to_alpha.css` to the standard `CSSFileList[]` for non-media
  pagelayouts. Trim once the simple/ezwebin siteaccesses are verified.

## Operators (`autoloads/sevenxthemesmediaoperators.php`)

- The Nexus id offsets (+776 object / +554 node) are hard-coded in
  `componentContent()`, `enhancedLink()` and `embedImage()`; move them to an
  INI setting so a re-import with different offsets does not require code
  edits.
- `twigBlockTemplate()` carries a hard-coded block-id → template map for the
  imported twig_block blocks; the mapping should live in configuration or on
  the block itself.
- `contentTags()` falls back to a direct SQLite connection with the
  hard-coded path `var/storage/sqlite3/sqlite.db` and logs via
  `error_log()`; replace the fallback with a proper eZDB reconnect and
  `eZDebug` logging, and make it database-agnostic (MySQL installs).
- Several operators are compatibility no-ops returning empty strings
  (`pagerfanta`, `haveToPaginate`, `controller`, `render`, `render_esi`,
  `player`, `player_slide`, `poster_slide`, `ngsite_group_fields`,
  `ngsite_language_name`, `ngsite_topic_path`, `nglayouts_render_result`,
  `nglayouts_render_zone`); implement the ones with real eZ4 counterparts
  (pagination first) or document them permanently as no-ops.
- `ngsiteGlobals()` filters the `ng_site_info` object by the hard-coded name
  fragment "Bold Agency" (skips the reference-demo object); make the
  selection configurable.

## Settings

- The extension root `settings/site.ini.append.php` is intentionally
  contentless because root-level appends from access-scoped extensions
  merged unreliably; revisit after the kernel-side extension settings
  handling is hardened, so the `settings/siteaccess/sevenx_site_user/`
  placement is no longer the only reliable one.
- The scoped settings directory is bound to the literal siteaccess name
  `sevenx_site_user`; document/generate copies for installs that use other
  siteaccess names (currently a manual step, see `INSTALL.md`).
