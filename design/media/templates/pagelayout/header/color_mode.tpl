{* The header's color mode switch, before the search button (pagelayout/header.tpl): light, dark, darker, or the
   system's mode. A button that steps through the four and stores the step (javascript/exp-color-mode.js, loaded in
   <head> so the mode is set before anything is drawn); its name and title say the mode in use (data-label-*), the
   icon shows it (a sun, a moon, a moon with stars, a half circle for the system's mode; exp-color-mode.css shows the
   one of html[data-exp-theme-choice]), and #exp-theme-status announces a press. The markup is the same for every
   visitor, so it can sit in the cached layout. Without the script the button does nothing and the
   page stays light. *}
<div class="header-theme">
    <button type="button" class="header-theme-toggle" id="exp-theme-toggle"
            title="{'Color mode: Follow system'|i18n( 'design/media/pagelayout' )|wash}"
            data-label-light="{'Color mode: Light'|i18n( 'design/media/pagelayout' )|wash}"
            data-label-dark="{'Color mode: Dark'|i18n( 'design/media/pagelayout' )|wash}"
            data-label-darker="{'Color mode: Darker'|i18n( 'design/media/pagelayout' )|wash}"
            data-label-system="{'Color mode: Follow system'|i18n( 'design/media/pagelayout' )|wash}">
        <svg class="header-theme-icon header-theme-icon-light" aria-hidden="true" focusable="false" viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="12" cy="12" r="4.5"/><path d="M12 1.5v2.5M12 20v2.5M1.5 12H4M20 12h2.5M4.6 4.6l1.8 1.8M17.6 17.6l1.8 1.8M4.6 19.4l1.8-1.8M17.6 6.4l1.8-1.8"/></svg>
        <svg class="header-theme-icon header-theme-icon-dark" aria-hidden="true" focusable="false" viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><path d="M20.5 14.5A8.5 8.5 0 0 1 9.5 3.5a8.5 8.5 0 1 0 11 11z"/></svg>
        <svg class="header-theme-icon header-theme-icon-darker" aria-hidden="true" focusable="false" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M20.5 14.5A8.5 8.5 0 0 1 9.5 3.5a8.5 8.5 0 1 0 11 11z"/><path d="M17 2l.9 2.1L20 5l-2.1.9L17 8l-.9-2.1L14 5l2.1-.9zM21 8.5l.5 1.2 1.2.5-1.2.5-.5 1.2-.5-1.2-1.2-.5 1.2-.5z"/></svg>
        <svg class="header-theme-icon header-theme-icon-system" aria-hidden="true" focusable="false" viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18z" fill="currentColor"/></svg>
        <span class="sr-only header-theme-label">{'Color mode: Follow system'|i18n( 'design/media/pagelayout' )|wash}</span>
    </button>
    <span class="sr-only" id="exp-theme-status" role="status" aria-live="polite"></span>
</div>
