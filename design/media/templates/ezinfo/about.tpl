{* The /ezinfo/about page in the media design: version, what Exponential is, the licence,
   contributors, third-party software and the extensions loaded at run time.

   Set by kernel/ezinfo/about.php:
     ezinfo                the version string
     what_is_ez_publish    HTML paragraphs
     license               the text of the LICENSE file (false when it cannot be read)
     contributors          array of hash( 'name', 'files' )
     third_party_software  array of strings
     extensions            extension => its info: ezinfo.php keys (Name, Version, Copyright,
                           License, info_url, 'Includes the following third-party software')
                           or extension.xml keys (the same in lower case, plus description),
                           and version, mtime, mtime_formatted

   Licence and copyright texts are legal notices and are shown as they are. *}
<style>
{literal}
.ezinfo-page .full-page-title{margin-bottom:0}
.ezinfo-page .ezinfo-section{margin:0 0 3rem}
.ezinfo-page .ezinfo-section h2{font-size:1.5rem;margin:0 0 1rem;padding-bottom:.5rem;border-bottom:2px solid #000}
.ezinfo-page .ezinfo-section p{max-width:44rem}
.ezinfo-page .ezinfo-license{max-height:24rem;overflow:auto;margin:0;padding:1rem 1.25rem;background:#f5f5f5;border:1px solid #ddd;font-size:.8125rem;line-height:1.5;white-space:pre-wrap;word-break:break-word}
.ezinfo-page .ezinfo-list{padding-left:1.25rem}
.ezinfo-page .ezinfo-list li{margin-bottom:.35rem;word-break:break-word}
.ezinfo-page .ezinfo-extensions{width:100%;border-collapse:collapse;font-size:.9375rem}
.ezinfo-page .ezinfo-extensions th{text-align:left;font-weight:600;padding:.5rem .75rem .5rem 0;border-bottom:2px solid #000;white-space:nowrap}
.ezinfo-page .ezinfo-extensions td{vertical-align:top;padding:.75rem .75rem .75rem 0;border-bottom:1px solid #ddd;word-break:break-word}
.ezinfo-page .ezinfo-extension-name{font-weight:600}
.ezinfo-page .ezinfo-extension-id,.ezinfo-page .ezinfo-extension-meta{display:block;font-size:.8125rem;color:#555;font-weight:400}
.ezinfo-page .ezinfo-extension-version{white-space:nowrap}
.ezinfo-page .ezinfo-extension-link a,.ezinfo-page .ezinfo-section p a,.ezinfo-page .ezinfo-extension-meta a{word-break:break-all;text-decoration:underline}
@media (max-width:767.98px){
.ezinfo-page .ezinfo-extensions thead{display:none}
.ezinfo-page .ezinfo-extensions tr{display:block;padding:.75rem 0;border-bottom:1px solid #ddd}
.ezinfo-page .ezinfo-extensions td{display:block;padding:.125rem 0;border:0}
.ezinfo-page .ezinfo-extensions td[data-label]:not(:empty)::before{content:attr(data-label) ": ";color:#555}
}
{/literal}
</style>
<div class="ezinfo-page">
    <header class="full-page-header no-breadcrumbs">
        <div class="container">
            <h1 class="full-page-title">{'Exponential information: %version'|i18n( 'design/standard/ezinfo/about',, hash( '%version', $ezinfo ) )|wash}</h1>
        </div>
    </header>

    <div class="container container-narrow">
        <div class="full-page-body">

            <section class="ezinfo-section">
                <h2>{'What is Exponential?'|i18n( 'design/standard/ezinfo/about' )}</h2>
                {if is_set( $what_is_ez_publish )}{$what_is_ez_publish}{/if}
            </section>

            <section class="ezinfo-section">
                <h2>{'License'|i18n( 'design/standard/ezinfo/about' )}</h2>
                {if $license}
                <pre class="ezinfo-license" tabindex="0">{$license|wash}</pre>
                {else}
                <p>{'Could not load LICENSE file! You should have a LICENSE file in your Exponential root directory.'|i18n( 'design/standard/ezinfo/about' )}</p>
                {/if}
            </section>

            {if and( is_set( $contributors ), is_array( $contributors ), count( $contributors )|ge( 1 ) )}
            <section class="ezinfo-section">
                <h2>{'Contributors'|i18n( 'design/standard/ezinfo/about' )}</h2>
                <p>
                    The following is a list of <a href="https://exponential.earth">Exponential</a> contributors who have licensed their work for use by <a href="https://se7enx.com">7x</a> under the terms and conditions of
                    the eZ Systems Contributor Licensing Agreement. As permitted by this agreement with the contributors, <a href="https://se7enx.com">7x</a> is redistributing the
                    contribution under the same license as the file that the contribution is included in. The list of contributors includes the
                    contributors&apos;s name, optional contact info and a list of files that they have either contributed or contributed work to.
                </p>
                <ul class="ezinfo-list">
                {foreach $contributors as $contributor}
                    <li>{$contributor['name']|wash}: {$contributor['files']|wash}</li>
                {/foreach}
                </ul>
            </section>
            {/if}

            <section class="ezinfo-section">
                <h2>{'Copyright Notice'|i18n( 'design/standard/ezinfo/about' )}</h2>
                <p>
                    Copyright for Exponential is included in the License shown above. Portions are copyright by other parties. A complete list of all contributors and third-party
                    software follows.
                </p>
            </section>

            {if and( is_set( $third_party_software ), is_array( $third_party_software ), count( $third_party_software )|ge( 1 ) )}
            <section class="ezinfo-section">
                <h2>{'Third-Party Software'|i18n( 'design/standard/ezinfo/about' )}</h2>
                <p>{'The following is a list of the third-party software that is distributed with this copy of Exponential. The list of third party software includes the license for the software in question and the directory or files that contain the third-party software.'|i18n( 'design/standard/ezinfo/about' )}</p>
                <ul class="ezinfo-list">
                {foreach $third_party_software as $software}
                    <li>{$software|wash}</li>
                {/foreach}
                </ul>
            </section>
            {/if}

            {if and( is_set( $extensions ), is_array( $extensions ), count( $extensions )|ge( 1 ) )}
            <section class="ezinfo-section">
                <h2>{'Extensions'|i18n( 'design/standard/ezinfo/about' )}</h2>
                <p>{'The following is a list of the extensions that have been loaded at run-time by this copy of Exponential.'|i18n( 'design/standard/ezinfo/about' )}</p>
                {def $e_key_lc = ''
                     $e_name = ''
                     $e_version = ''
                     $e_license = ''
                     $e_url = ''
                     $e_copyright = ''
                     $e_description = ''
                     $e_includes = array()
                     $label_name = 'Name'|i18n( 'design/standard/ezinfo/about' )
                     $label_version = 'Version'|i18n( 'design/standard/ezinfo/about' )
                     $label_license = 'License'|i18n( 'design/standard/ezinfo/about' )
                     $label_website = 'Website'|i18n( 'design/standard/ezinfo/about' )
                     $label_includes = 'Includes'|i18n( 'design/standard/ezinfo/about' )}
                <table class="ezinfo-extensions">
                    <thead>
                        <tr><th scope="col">{$label_name|wash}</th><th scope="col">{$label_version|wash}</th><th scope="col">{$label_license|wash}</th><th scope="col">{$label_website|wash}</th></tr>
                    </thead>
                    <tbody>
                    {foreach $extensions as $ext_id => $extension}
                    {if is_array( $extension )}
                        {set $e_name = ''
                             $e_version = ''
                             $e_license = ''
                             $e_url = ''
                             $e_copyright = ''
                             $e_description = ''
                             $e_includes = array()}
                        {foreach $extension as $e_key => $e_value}
                            {set $e_key_lc = $e_key|downcase}
                            {if is_array( $e_value )}
                                {if $e_key_lc|begins_with( 'includes' )}{set $e_includes = $e_includes|append( $e_value )}{/if}
                            {elseif or( $e_value|not, $e_key_lc|begins_with( 'mtime' ) )}
                            {elseif $e_value|begins_with( '//' )}
                                {* an unexpanded build placeholder such as //autogentag// is no value *}
                            {elseif and( $e_key_lc|eq( 'name' ), $e_name|eq( '' ) )}{set $e_name = $e_value}
                            {elseif and( $e_key_lc|eq( 'version' ), $e_version|eq( '' ) )}{set $e_version = $e_value}
                            {elseif and( $e_key_lc|eq( 'license' ), $e_license|eq( '' ) )}{set $e_license = $e_value}
                            {elseif and( $e_key_lc|eq( 'copyright' ), $e_copyright|eq( '' ) )}{set $e_copyright = $e_value}
                            {elseif and( $e_key_lc|eq( 'description' ), $e_description|eq( '' ) )}{set $e_description = $e_value}
                            {elseif and( $e_key_lc|eq( 'info_url' ), $e_url|eq( '' ) )}{set $e_url = $e_value|strip_tags}
                            {/if}
                        {/foreach}
                        {if $e_name|strip_tags|trim|eq( '' )}{set $e_name = $ext_id}{/if}
                        <tr data-extension="{$ext_id|wash}">
                            <td>
                                <span class="ezinfo-extension-name">{$e_name|strip_tags|trim|wash}</span>
                                {if $e_name|strip_tags|trim|ne( $ext_id )}<span class="ezinfo-extension-id">{$ext_id|wash}</span>{/if}
                                {if $e_description|ne( '' )}<span class="ezinfo-extension-meta">{$e_description|strip_tags|wash}</span>{/if}
                                {if $e_copyright|ne( '' )}<span class="ezinfo-extension-meta">{$e_copyright}</span>{/if}
                                {foreach $e_includes as $e_include}
                                    {if and( is_set( $e_include.name ), $e_include.name )}<span class="ezinfo-extension-meta">{$label_includes|wash}: {$e_include.name|wash}{if and( is_set( $e_include.version ), $e_include.version )} {$e_include.version|wash}{/if}{if and( is_set( $e_include.license ), $e_include.license )} ({$e_include.license|wash}){/if}</span>
                                    {elseif and( is_set( $e_include.Name ), $e_include.Name )}<span class="ezinfo-extension-meta">{$label_includes|wash}: {$e_include.Name|wash}{if and( is_set( $e_include.Version ), $e_include.Version )} {$e_include.Version|wash}{/if}{if and( is_set( $e_include.License ), $e_include.License )} ({$e_include.License|wash}){/if}</span>{/if}
                                {/foreach}
                            </td>
                            <td class="ezinfo-extension-version" data-label="{$label_version|wash}">{$e_version|wash}</td>
                            <td data-label="{$label_license|wash}">{$e_license}</td>
                            <td class="ezinfo-extension-link" data-label="{$label_website|wash}">{if $e_url|ne( '' )}<a href="{if $e_url|begins_with( 'http' )|not}https://{/if}{$e_url|wash}" rel="noopener">{$e_url|wash}</a>{/if}</td>
                        </tr>
                    {/if}
                    {/foreach}
                    </tbody>
                </table>
                {undef $e_key_lc $e_name $e_version $e_license $e_url $e_copyright $e_description $e_includes
                       $label_name $label_version $label_license $label_website $label_includes}
            </section>
            {/if}

        </div>
    </div>
</div>
