# sevenx_themes_media changelog

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
