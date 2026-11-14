{* Register the navigation cache.

   A conditional request for a page this browser already holds is answered in
   about 0.36ms of server time, and the visitor still waits roughly 12ms,
   because that is the round trip to the server and a revalidation is one round
   trip by definition. Nothing done on the server shortens it. Answered from
   the browser's own store there is no round trip to shorten.

   Registered after load, not during it. Installing a worker costs a fetch and
   some main-thread time, and during the page's own load both are wanted
   elsewhere; nothing it does helps the view it is registered on, only the ones
   after.

   The session check is in JavaScript rather than here, deliberately. It has to
   be right at the moment the worker would act, and document.cookie is the same
   thing the worker itself can see. A first attempt put an eZ condition around
   this block, got the syntax wrong, and emitted nothing at all -- which is the
   good failure, but it is a reminder that a guard nobody can see fail is worse
   than one that is obvious. The admin runs a different design and never
   includes this file.

   The worker is /index.js, the Exponential Service Workers Index. Browsers
   registered before it was renamed hold /sw.js; that address stays, as a
   one-line script that loads /index.js, so they run the same code until this
   page registers /index.js over it (same scope, so the registration moves to
   the new script). Signed-in visitors never reach the register call below, which
   is why /sw.js has to stay.

   The kill switch: replace the body of index.js with
   self.registration.unregister(). Every browser that has it drops it on its
   next update check, which is at most 24 hours and usually the next
   navigation, because index.js is served no-cache.

   The code is in javascript/exp-service-worker.js (no inline script, so the
   page runs under a script-src 'self' policy). The one value it needs from
   here, the name of the session cookie, goes in the data block before it: the
   worker and the response cache can then never disagree about who is signed
   in. *}
{set-block variable=$exp_sw_config}{json_encode( hash( 'sessionCookie', ezini( 'Session', 'SessionNamePrefix', 'site.ini' ) ) )}{/set-block}
<script type="application/json" id="exp-sw-config">{$exp_sw_config|explode( '<' )|implode( '\u003c' )|explode( '>' )|implode( '\u003e' )}</script>
{ezscript( array( 'exp-service-worker.js' ) )}
{undef $exp_sw_config}
{* Image aliases made on demand (Exponential 6.0.15): the kernel's small script that swaps the placeholder of an
   alias still being made for the real image once it is there. Only this script, not the whole FrontendJavaScriptList:
   that list also carries jQuery and the eztags scripts, which this theme does not use. image.ini [AliasSettings]
   SwapScript=disabled leaves it out. *}
{if ezini( 'AliasSettings', 'SwapScript', 'image.ini' )|ne( 'disabled' )}{ezscript( array( 'exp_image_swap.js' ) )}{/if}
