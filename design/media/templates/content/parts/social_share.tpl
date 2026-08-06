{def $share_url = $node.url_alias|ezurl('full')
     $share_title = $node.name|wash}
<div class="social-share-wrapper">
    <div class="social-share static-social-buttons">
        <ul class="social">
            <li>
                <a class="static-social-button" aria-label="{'ngsite.share_on_twitter'|trans}" target="_blank" rel="nofollow" href="https://twitter.com/intent/tweet?url={$share_url|urlencode}">
                    <i class="icon-twitter"></i>
                </a>
            </li>

            <li>
                <a class="static-social-button" aria-label="{'ngsite.share_on_linkedin'|trans}" target="_blank" rel="nofollow" href="https://www.linkedin.com/shareArticle?mini=true&amp;url={$share_url|urlencode}&amp;title={$share_title|urlencode}">
                    <i class="icon-linkedin"></i>
                </a>
            </li>

            <li>
                <a class="static-social-button" aria-label="{'ngsite.share_on_facebook'|trans}" target="_blank" rel="nofollow" href="https://www.facebook.com/sharer.php?u={$share_url|urlencode}&amp;t={$share_title|urlencode}">
                    <i class="icon-facebook"></i>
                </a>
            </li>
        </ul>
    </div>
</div>
{undef $share_url $share_title}
