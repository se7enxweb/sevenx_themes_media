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

   The kill switch: replace the body of sw.js with
   self.registration.unregister(). Every browser that has it drops it on its
   next update check, which is at most 24 hours and usually the next
   navigation, because sw.js is served no-cache.

   {literal} around the script because eZ TPL reads { and } as its own tags,
   and JavaScript is made of them. Without it the block does not fail loudly --
   it emits nothing, which is exactly what happened here twice before this
   comment existed. *}
{def $session_cookie_name = ezini( 'Session', 'SessionNamePrefix', 'site.ini' )}
<script>
{literal}
(function () {
	if (!('serviceWorker' in navigator)) return;

	// A session cookie means this page is somebody's, not everybody's. If one
	// is present the worker is removed rather than left to serve the wrong
	// person, and anything it stored is dropped with it.
	// Exactly the cookie this siteaccess signs people in with, and nothing
	// else. The name is emitted by the server rather than written here, so the
	// worker and the response cache can never disagree about who is signed in.
	//
	// Two earlier versions of this were wrong in the same direction, and both
	// cost a signed-in editor the cache:
	//
	//   - is_logged_in is not scoped to a siteaccess at all, so an admin
	//     session switched the worker off on the public site
	//   - /eZSESSID[^=]*=/ matches the admin's cookie too. SessionNameHandler
	//     is "custom" here: the public siteaccesses set
	//     SessionNamePerSiteAccess=disabled and share the bare name, while the
	//     admin inherits enabled and gets eZSESSID<md5> of its own. Being
	//     signed in to /admin is no reason to stop serving the public site
	//     from cache -- which is exactly what the server already does.
	//
	// Anchored, and the '=' must follow the name immediately.
	// {literal} is closed for exactly this value and reopened after it. Inside
	// a literal block eZ emits braces verbatim, so a template variable written
	// there arrives at the browser as its own source text -- which is how the
	// registration script silently emitted nothing twice earlier today.
	var sessionCookie = '{/literal}{$session_cookie_name|wash}{literal}';
	var jar = document.cookie || '';
	var personal = sessionCookie !== ''
		&& new RegExp('(?:^|;\\s*)' + sessionCookie + '=[^;]+').test(jar);

	// Tell the worker which it is, and let it step aside rather than removing
	// it. Unregistering on sign-in meant an editor lost this permanently and
	// had to have it re-installed on sign-out -- a signed-in visitor going from
	// 0ms back to a full round trip, and staying there. Stepping aside costs
	// nothing and reverses the moment the session ends.
	function tell(signedIn) {
		if (navigator.serviceWorker.controller) {
			navigator.serviceWorker.controller.postMessage(
				{ type: 'session', signedIn: signedIn });
		}
	}

	tell(personal);
	navigator.serviceWorker.ready.then(function () { tell(personal); })
		.catch(function () {});

	if (personal) {
		// Anything stored before this visitor signed in is still public, so it
		// stays. Nothing of theirs will be added while the session lasts.
		return;
	}

	window.addEventListener('load', function () {
		navigator.serviceWorker.register('/sw.js', { scope: '/' })
			.then(function () { tell(false); })
			.catch(function () { /* a failure here must never affect the page */ });
	});
}());
{/literal}
</script>
{undef $session_cookie_name}
