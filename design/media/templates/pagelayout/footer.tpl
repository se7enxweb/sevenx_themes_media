{def $ft_site_info = fetch('content','object',hash('object_id',839))}

{if is_object($ft_site_info)}
<footer class="site-footer">
    <div class="container">
        {include uri='design:content/parts/site_logo.tpl'}

        <div class="footer-menu">
        {if and(is_set($ft_site_info), $ft_site_info.data_map.additional_menu.has_content)}
            {def $ft_relations = $ft_site_info.data_map.additional_menu.content.relation_list}
            {def $ft_last = $ft_relations|count|sub(1)}
            {def $ft_object = false()}
            {def $ft_node = false()}
            <ul class="nav navbar-nav">
            {foreach $ft_relations as $ft_index => $ft_relation}
                {set $ft_object = fetch('content','object',hash('object_id',$ft_relation.contentobject_id))}
                {set $ft_node = false()}
                {if $ft_object}
                    {set $ft_node = $ft_object.main_node}
                {/if}
                {if $ft_node}
                <li id="menu-item-additional_menu-location-id-{$ft_node.node_id}"{if $ft_index|eq(0)} class="firstli"{elseif $ft_index|eq($ft_last)} class="lastli"{/if} data-location-id="{$ft_node.node_id}">
                    <a href={$ft_node.url_alias|ezurl}>{$ft_node.name|wash}</a>
                </li>
                {/if}
            {/foreach}
            </ul>
            {undef $ft_relations}
            {undef $ft_last}
            {undef $ft_object}
            {undef $ft_node}
        {/if}
        </div>

                <nav class="footer-social" role="navigation">
            <ul>
                {if and(is_set($ft_site_info), $ft_site_info.data_map.facebook.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.facebook.content}" aria-label="Visit us on Facebook" target="_blank" noreferrer="" noopener="">
                            <i class="icon-facebook"></i>
                            <span class="tt">Facebook</span>
                        </a>
                    </li>
                {/if}
                {if and(is_set($ft_site_info), $ft_site_info.data_map.twitter.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.twitter.content}" aria-label="Visit us on Twitter" target="_blank" noreferrer="" noopener="">
                            <i class="icon-twitter"></i>
                            <span class="tt">Twitter</span>
                        </a>
                    </li>
                {/if}
                {if and(is_set($ft_site_info), $ft_site_info.data_map.instagram.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.instagram.content}" aria-label="Visit us on Instagram" target="_blank" noreferrer="" noopener="">
                            <i class="icon-instagram"></i>
                            <span class="tt">Instagram</span>
                        </a>
                    </li>
                {/if}
                {if and(is_set($ft_site_info), $ft_site_info.data_map.linkedin.has_content)}
                    <li>
                        <a href="{$ft_site_info.data_map.linkedin.content}" aria-label="Visit us on LinkedIn" target="_blank" noreferrer="" noopener="">
                            <i class="icon-linkedin"></i>
                            <span class="tt">LinkedIn</span>
                        </a>
                    </li>
                {/if}
            </ul>
        </nav>

        <div class="footer-info">
                        <a href="#" class="js-open-ng-cc d-block my-2">Cookie settings</a>

            {if and(is_set($ft_site_info), $ft_site_info.data_map.footer_block.has_content)}
                <div>
                    <div class="ibexa_richtext-field">
                        {attribute_view_gui attribute=$ft_site_info.data_map.footer_block}
                    </div>
                </div>
            {/if}

            <address>
                Powered by <a href="https://se7enx.com">7x</a> &amp; <a href="https://exponential.earth">Exponential</a>
            </address>
        </div>
    </div>
</footer>
{/if}
{undef $ft_site_info}
