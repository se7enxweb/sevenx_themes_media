<?php /* #?ini charset="utf-8"?

[AliasSettings]
AliasList[]=i160
AliasList[]=i320
AliasList[]=i400
AliasList[]=i480
AliasList[]=i770
AliasList[]=i1320
AliasList[]=i1920

[i160]
Reference=
Filters[]
Filters[]=geometry/scaledownonly=160;106

[i320]
Reference=
Filters[]
Filters[]=geometry/scalewidthdownonly=320

[i480]
Reference=
Filters[]
Filters[]=geometry/scalewidthdownonly=480

# Between i320 and i480, for the size the list grids actually draw.
#
# Measured in a real browser at a 1280px viewport: 28 of 43 images arrived at
# 480px and were drawn at 352-356px, so about 46% of the delivered pixels were
# discarded during scaling. i320 would have been an upscale and visibly softer;
# i400 covers the slot with a little to spare.
#
# It is offered through srcset rather than swapped in, so the browser still
# takes i480 where it needs it -- a retina display, or a viewport wide enough
# to draw the slot larger.
[i400]
Reference=
Filters[]
Filters[]=geometry/scalewidthdownonly=400

[i1320]
Reference=
Filters[]
Filters[]=geometry/scaledownonly=1320;1320

[i1920]
Reference=
Filters[]
Filters[]=geometry/scaledownonly=1920;1920

[large]
Reference=
Filters[]
Filters[]=geometry/scaledownonly=1200;800

[i770]
Reference=
Filters[]
Filters[]=geometry/scalewidthdownonly=770

*/ ?>
