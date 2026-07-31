# FAQ — sevenx_themes_media

## Why is this extension still named sevenx_themes_media?

Owner decision: while sibling extensions were renamed to the `exp*` prefix,
this one deliberately **keeps** the `sevenx_` name. Do not rename it — a
rename happens only if the owner explicitly provides a new name. The
composer vendor namespace `se7enxweb/` is likewise correct and stays.

## Can I regenerate the templates from the Twig sources?

**No.** The Twig-to-TPL converter (`ai/bin/convert_media_site_twig.py` in
the project tree) is retired and must never be run again. The templates
under `design/media/templates/` have received extensive hand fixes since the
last conversion and are now the maintained source of truth; a converter
re-run would wipe them. Edit the `.tpl` files directly.

## Nothing changed after I activated the extension for my siteaccess

Two common causes:

1. The extension's scoped settings live in
   `settings/siteaccess/sevenx_site_user/` and only merge for a siteaccess
   with exactly that name. For another siteaccess name, copy that directory
   to `settings/siteaccess/<your-siteaccess>/` (see `INSTALL.md`).
2. Autoloads/caches are stale — run
   `php bin/php/ezpgenerateautoloads.php -e` and
   `php bin/php/ezcache.php --clear-all --allow-root-user`.

## What are all the `.tpl.offer` files?

Staged template variants that have not been adopted yet. The renderer only
uses the file without the `.offer` suffix; the offers are kept as candidate
replacements to review, adopt (by removing the suffix) or drop.

## Why do operators like `pagerfanta` or `render_esi` output nothing?

They are deliberate compatibility no-ops. The converted templates still call
the full set of Twig-era functions; operators whose concepts have no eZ4
counterpart (`pagerfanta`, `controller`, `render`, `render_esi`, `player*`,
`ngsite_group_fields`, ...) return an empty string so the surrounding markup
renders cleanly. See the operator list in `USAGE.md`.

## Why does `intro()` show nothing although the object has a description?

By design. `intro` reads only the `teaser_intro`/`full_intro` fields — it
never falls back to `description`, matching the reference theme. Templates
that need a teaser from another field pass an explicit candidate list as the
operator's third argument.

## Where do the +776 / +554 id offsets come from?

The media-site content was imported from a reference (Nexus) install whose
object ids are offset by +776 and node ids by +554 on this install. The
operators that resolve imported references (`component_content`,
`enhanced_link`, `embed_image`) try the offset id first and fall back to the
raw id.
