# sevenx_themes_media changelog

## 1.5.87 (2026-10-31)

- Updated: The "My account" link above API access (apikey/list) has the
  yellow underline of the other account pages, in .tpl, .stpl and .twig. Its
  column lacked the account class that carries the account colors, so the
  link was drawn without the line.
- Updated: The "Find another user" link above an administrator's view of a
  user's e-mail preferences has the same yellow underline, in all three
  engines, for the same reason.
- Updated: The tabs of the e-mail preference administration (Status,
  Categories, Suppression list, Consent log, A user) are the media design's
  pill tabs, as on Security activity, in .tpl, .stpl and .twig, in light,
  dark and darker; the current page is the yellow pill. They were a plain
  bulleted list, because the media design does not load the kernel's styles
  for them. The pill row's spacing uses logical properties, so it reads the
  same in right-to-left languages.
- Updated: The buttons of the e-mail preference pages read in the dark and
  darker modes: "Turn off all optional e-mail" and the other dark buttons
  were white text on a near-white button, and the yellow "Save" buttons
  light text on yellow. Their colors now come from account tokens with a
  value for each mode (the text on ink, the hovered ink, the button paper,
  the text on yellow); every button state measures at least 4.5:1.
- Updated: The administrators' e-mail preference status
  (mailpreferences/admin/status) is drawn on-model in .tpl, .stpl and .twig:
  the problems as account notices, the figures as the tiles of Security
  activity, the sender details, the settings in use and the related pages
  in account cards, the settings as the account facts list. It was a set
  of plain bulleted lists.

## 1.5.86 (2026-10-31)

- Added: My bookmarks (content/bookmark) in the media design, in .tpl, .stpl
  and .twig: the overview, the folders with New folder, the folder shown with
  Rename, Move and Remove folder, the search and the order, the bookmarks of
  items and of system pages as cards grouped by folder, Move up, Move down and
  the position in the folder, the number per page and the paging, and moving
  or removing the selected bookmarks. It replaced the kernel's unstyled page.
- Added: Security activity (user/security) in the media design, in all three
  engines: Secure your account, the counts, the filter, the events with "Was
  this you?", the paging and Download my sign-in data, in the account cards.
  It replaced the kernel's page, which followed the system's dark mode and
  showed the administration's orange links on the media site.
- Added: The profile (user/edit) links to Security activity and My bookmarks.
- Updated: The account pages (profile, Your devices, passkeys, password, the
  e-mail and notification settings, the edit form, Security activity, My
  bookmarks) follow the header's dark and darker modes: their cards, text,
  lines and notices take the mode's colors. They were drawn as light cards
  with black text on the dark page.
- Updated: API access (apikey/list) takes the media design's colors, square
  buttons and yellow primary button instead of the administration's orange,
  in light, dark and darker.

## 1.5.82 (2026-10-29)

- Updated: One copyright notice, Exponential Foundation and 7x.

## 1.5.81 (2026-10-29)

- Added: A color mode switch in the header of the media design, before the
  search button: light, dark, darker, or the system's mode (the default). The
  choice is kept in the browser and set before the page is drawn, so there is
  no flash of the light page; every part of the design has dark and darker
  colors, with text at 4.5:1 or more. The labels are in every catalogue.
- Updated: The user menu in the header says Cart instead of Basket.

## 1.5.80 (2026-10-28)

- Added: Translations into 110 more languages: afr-ZA, aka-GH, amh-ET, ara-SA,
  arc-IQ, asm-IN, aze-AZ, bel-BY, ben-BD, bho-IN, bod-CN, bos-BA, bul-BG,
  cat-ES, ceb-PH, che-RU, chi-CN, chi-TW, ckb-IQ, cym-GB, dsb-DE, ell-GR,
  eng-AU, est-EE, eus-ES, fas-IR, fil-PH, fin-FI, ful-SN, gla-GB, gle-IE,
  glg-ES, guj-IN, hau-NG, haw-US, hin-IN, hun-HU, huy-IL, hye-AM, ibo-NG,
  ind-ID, isl-IS, jav-ID, jpn-JP, kal-GL, kan-IN, kat-GE, kaz-KZ, khm-KH,
  kik-KE, kin-RW, kir-KG, kor-KR, kur-TR, lao-LA, lav-LV, lin-CD, lit-LT,
  ltz-LU, lug-UG, mai-IN, mal-IN, mar-IN, mkd-MK, mlg-MG, mlt-MT, mon-MN,
  mri-NZ, msa-MY, mya-MM, nep-NP, ori-IN, orm-ET, pan-IN, pcm-NG, pnb-PK,
  por-PT, pus-AF, ron-RO, run-BI, rus-RU, ser-SR, sin-LK, slk-SK, slv-SI,
  sna-ZW, snd-PK, som-SO, sqi-AL, srp-RS, sun-ID, swa-KE, syr-IQ, tam-IN,
  tat-RU, tel-IN, tgk-TJ, tha-TH, tir-ET, tuk-TM, uig-CN, ukr-UA, urd-PK,
  uzb-UZ, vie-VN, wol-SN, xho-ZA, yid-US, yor-NG and zul-ZA.
- Updated: The eng-US, fre-FR and ger-DE translations are complete.
- Updated: The buttons of the login, register and forgot password pages are
  spaced alike side by side and stacked.

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
