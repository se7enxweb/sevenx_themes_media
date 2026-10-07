{def $ft_site_info = fetch('content','object',hash('object_id',false(),'remote_id', ezini('SiteInfo','RemoteID','menu.ini')))}

{if is_object($ft_site_info)}
<footer class="site-footer">
    <div class="container">
        {include uri='design:content/parts/site_logo.tpl'}

        <div class="footer-menu">
        {def $ft_ids = ezini('SiteInfo','FooterMenuID','menu.ini')|unique}
        {def $ft_last = count($ft_ids)|sub(1)}
        {def $ft_node = false()}
        {def $ft_display_id = false()}
        {def $ft_nexus_ids = ezini('SiteInfo','NexusFooterMenuID','menu.ini')|unique}
        {if $ft_ids|count|gt(0)}
            <ul class="nav navbar-nav">
            {foreach $ft_ids as $ft_index => $ft_id}
                {set $ft_node = fetch('content','node',hash('node_id',$ft_id))}
                {set $ft_display_id = $ft_id}
                {if and( is_set($ft_nexus_ids[$ft_index]), $ft_nexus_ids[$ft_index]|ne('') )}
                    {set $ft_display_id = $ft_nexus_ids[$ft_index]}
                {/if}
                {if is_object($ft_node)}
                {def $ft_href = cond($ft_node.url_alias|begins_with('fit-healthy/'), $ft_node.url_alias|ezroot, $ft_node.url_alias|ezurl)}
                <li id="menu-item-additional_menu-location-id-{$ft_display_id}"{if $ft_index|eq(0)} class="firstli"{elseif $ft_index|eq($ft_last)} class="lastli"{/if} data-location-id="{$ft_display_id}">
                    <a href={$ft_href}>{$ft_node.name|wash}</a>
                </li>
                {undef $ft_href}
                {/if}
            {/foreach}
            </ul>
        {/if}
        </div>

                <nav class="footer-social" role="navigation">
            <ul>
                {if and(is_set($ft_site_info), $ft_site_info.data_map.facebook.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.facebook.content}" aria-label="{'Visit us on %social'|i18n('design/media/pagelayout', '', hash('%social', 'Facebook'))}" target="_blank" noreferrer="" noopener="">
                            <i class="icon-facebook"></i>
                            <span class="tt">Facebook</span>
                        </a>
                    </li>
                {/if}
                {if and(is_set($ft_site_info), $ft_site_info.data_map.twitter.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.twitter.content}" aria-label="{'Visit us on %social'|i18n('design/media/pagelayout', '', hash('%social', 'Twitter'))}" target="_blank" noreferrer="" noopener="">
                            <i class="icon-twitter"></i>
                            <span class="tt">Twitter</span>
                        </a>
                    </li>
                {/if}
                {if and(is_set($ft_site_info), $ft_site_info.data_map.instagram.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.instagram.content}" aria-label="{'Visit us on %social'|i18n('design/media/pagelayout', '', hash('%social', 'Instagram'))}" target="_blank" noreferrer="" noopener="">
                            <i class="icon-instagram"></i>
                            <span class="tt">Instagram</span>
                        </a>
                    </li>
                {/if}
                {if and(is_set($ft_site_info), $ft_site_info.data_map.linkedin.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.linkedin.content}" aria-label="{'Visit us on %social'|i18n('design/media/pagelayout', '', hash('%social', 'LinkedIn'))}" target="_blank" noreferrer="" noopener="">
                            <i class="icon-linkedin"></i>
                            <span class="tt">LinkedIn</span>
                        </a>
                    </li>
                {/if}
            </ul>
        </nav>

        {* The second link line (sign-in, cart, site map ...): the children of the folder with the
           remote id [SiteInfo] FooterLinksRemoteID in menu.ini (default media-o-footer-links),
           ng_menu_item objects edited in the admin, in their priority order. Same markup as the
           menu line above. A URL that names a view without its id gets it here, so the content
           stays the same on every site:
             /content/edit          -> the object of the page being viewed (anonymous: the sign-in
                                       page, which returns to the edit form)
             /content/view/sitemap  -> the home node of the siteaccess (IndexPage)
             /content/view/tagcloud -> likewise *}
        {def $ft_links_rid = 'media-o-footer-links'}
        {if ezini_hasvariable( 'SiteInfo', 'FooterLinksRemoteID', 'menu.ini' )}
            {set $ft_links_rid = ezini( 'SiteInfo', 'FooterLinksRemoteID', 'menu.ini' )}
        {/if}
        {def $ft_links_object = fetch( 'content', 'object', hash( 'object_id', false(), 'remote_id', $ft_links_rid ) )}
        {if and( is_object( $ft_links_object ), $ft_links_object.main_node_id )}
            {def $ft_links = fetch( 'content', 'list', hash( 'parent_node_id', $ft_links_object.main_node_id,
                                                             'sort_by', $ft_links_object.main_node.sort_array,
                                                             'class_filter_type', 'include',
                                                             'class_filter_array', array( 'ng_menu_item' ) ) )
                 $ft_links_last = 0
                 $ft_links_home = ezini( 'SiteSettings', 'IndexPage', 'site.ini' )|explode( '/' )|extract_right( 1 )|implode( '' )|int
                 $ft_links_object_id = false()
                 $ft_links_url = ''}
            {if $ft_links_home|lt( 1 )}{set $ft_links_home = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}{/if}
            {if and( is_set( $module_result ), is_set( $module_result.content_info ), is_set( $module_result.content_info.object_id ) )}
                {set $ft_links_object_id = $module_result.content_info.object_id}
            {/if}
            {set $ft_links_last = count( $ft_links )|sub( 1 )}
            {if $ft_links|count|gt( 0 )}
        <div class="footer-menu footer-links">
            <ul class="nav navbar-nav">
            {foreach $ft_links as $ft_links_index => $ft_link}
                {set $ft_links_url = $ft_link.data_map.item_url.content|trim}
                {if $ft_links_url|eq( '' )}{continue}{/if}
                {if $ft_links_url|eq( '/content/edit' )}
                    {set $ft_links_url = cond( $ft_links_object_id, concat( '/content/edit/', $ft_links_object_id ), '/user/login' )}
                {elseif or( $ft_links_url|eq( '/content/view/sitemap' ), $ft_links_url|eq( '/content/view/tagcloud' ) )}
                    {set $ft_links_url = concat( $ft_links_url, '/', $ft_links_home )}
                {/if}
                <li id="menu-item-footer_links-location-id-{$ft_link.node_id}"{if $ft_links_index|eq( 0 )} class="firstli"{elseif $ft_links_index|eq( $ft_links_last )} class="lastli"{/if} data-location-id="{$ft_link.node_id}">
                    <a href={if $ft_links_url|begins_with( 'http' )}"{$ft_links_url|wash}"{else}{$ft_links_url|ezurl}{/if}{if $ft_link.data_map.target_blank.data_int} target="_blank" rel="noopener noreferrer"{/if}>{$ft_link.name|wash}</a>
                </li>
            {/foreach}
            </ul>
        </div>
            {/if}
            {undef $ft_links $ft_links_last $ft_links_home $ft_links_object_id $ft_links_url}
        {/if}
        {undef $ft_links_rid $ft_links_object}

        <div class="footer-info">
                        {include uri='design:parts/cookie_settings_link.tpl'}

            <div>
                <div class="exp_richtext-field">
                    <p>{'This demo site is built on Exponential 6.0.15+ and Exponential Layouts.'|i18n('design/media/pagelayout')}</p>
                </div>
            </div>

            <address>
                {'Powered by %company &amp; %exponential'|i18n( 'design/media/pagelayout',, hash( '%company', '<a href="https://se7enx.com">7x</a>', '%exponential', '<a href="https://exponential.earth">Exponential</a>' ) )}
            </address>
        </div>
    </div>
</footer>
{/if}
{undef $ft_site_info}
