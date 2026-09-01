<footer class="site-footer">
    <div class="container">
        <a class="site-logo" href={"/"|ezurl()} title="Fit &amp; Healthy">
            <img src="/var/site/storage/original/image/e88a83ca0b5484f343458f434a3daf11.svg" alt="">
        </a>

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
                <li id="menu-item-additional_menu-location-id-{$ft_display_id}" class="{if $ft_index|eq(0)}firstli{elseif $ft_index|eq($ft_last)}lastli{/if}" data-location-id="{$ft_display_id}"><a href={$ft_href}>{$ft_node.name|wash}</a></li>
                {undef $ft_href}
                    {/if}
                {/foreach}
            </ul>
            {/if}
        </div>

        <nav class="footer-social" role="navigation">
            <ul>
                <li><a href="https://www.facebook.com" aria-label="Visit us on Facebook" target="_blank" rel="noopener noreferrer"><i class="icon-facebook" aria-hidden="true"></i><span class="tt">Facebook</span></a></li>
                <li><a href="https://www.twitter.com" aria-label="Visit us on Twitter" target="_blank" rel="noopener noreferrer"><i class="icon-twitter" aria-hidden="true"></i><span class="tt">Twitter</span></a></li>
                <li><a href="https://www.instagram.com" aria-label="Visit us on Instagram" target="_blank" rel="noopener noreferrer"><i class="icon-instagram" aria-hidden="true"></i><span class="tt">Instagram</span></a></li>
                <li><a href="https://www.linkedin.com" aria-label="Visit us on LinkedIn" target="_blank" rel="noopener noreferrer"><i class="icon-linkedin" aria-hidden="true"></i><span class="tt">LinkedIn</span></a></li>
            </ul>
        </nav>

        <div class="footer-info">
            <a href="#" class="js-open-ng-cc d-block my-2">Cookie settings</a>
            <div>
                <p>This demo site is built on Exponential CMS and Netgen Layouts.</p>
            </div>
            <address>Powered by <a href="https://se7enx.com">7x</a> &amp; <a href="https://exponential.earth">Exponential</a></address>
            <p class="copyright">&copy; {currentdate()|datetime( 'custom', '%Y' )} Fit &amp; Healthy.</p>
        </div>
    </div>
</footer>
