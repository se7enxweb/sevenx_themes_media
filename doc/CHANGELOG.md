# sevenx_themes_media changelog

## 1.5.79 (2026-10-26)

- Added: Your devices, Passkeys and Verify it's you pages in the media design.
- Updated: The login page offers passkey sign-in, and the Passkeys link shows
  only where the view exists.
- Updated: The account page links Passkeys and Your devices, as the standard
  design's account page does.
- Fixed: Translations that contradicted their language guide: wrong meanings,
  glossary breaches, forms of address, typos and English left in the text,
  from ekked's pull request #3.

## 1.5.75 (2026-10-21)

- Fixed: A layout mapping with a Route target applies on the media pages that
  are not content pages (search, user, a module of an extension). The
  pagelayout laid out content pages only, so a Route mapping never showed;
  on its other pages it now asks `fetch( 'explayouts', 'resolve_route_layout',
  hash() )`, which answers only for a rule with a Route target that names the
  page's module view (`content/search`, `user/*`). The path rules and the
  catch-all keep to content pages, as before. Needs explayouts 1.4.42.

## 1.5.74 (2026-10-21)

- Fixed: The media design loads the stylesheets other extensions add to
  `design.ini [StylesheetSettings] CSSFileList[]` and
  `FrontendCSSFileList[]`. They used to be ignored, because the pagelayout
  listed its stylesheets in `pagelayout/head/style.tpl` only. They now load
  after the theme's own files, in the same ezcss_load packer bundle, each
  file once.
- Updated: The theme's dead `CSSFileList[]` entries (`main.css`,
  `main.res.css`, `exponential.css`, `nexus_to_alpha.css`) are replaced by
  `MediaReplacedCSSFileList[]`, which keeps them and the simple theme's base
  styles off the media pages, as before.
