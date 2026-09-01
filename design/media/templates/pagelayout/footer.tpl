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

        <div class="footer-info">
                        <a href="#" class="js-open-ng-cc d-block my-2">{'Cookie settings'|i18n('design/media/pagelayout')}</a>

            <div>
                <div class="ibexa_richtext-field">
                    <p>{'This demo site is built on Exponential 6.0.15+ and Exponential Layouts.'|i18n('design/media/pagelayout')}</p>
                </div>
            </div>

            <address>
                {'Powered by'|i18n('design/media/pagelayout')} <a href="https://se7enx.com">7x</a> &amp; <a href="https://exponential.earth">Exponential</a>
            </address>
        </div>
    </div>
</footer>
{/if}
{undef $ft_site_info}
