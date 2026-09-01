{def $view_type = 'full'}



{* EXTENDS design:$nglayouts.layoutTemplate *}

{* IMPORT content/macros/video.tpl AS video *}

{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{explblock name='content'}
    <div class="view-type view-type-{$view_type} ng-video vf3">
        <div class="container">
            {explblock name='article_media'}
            <div class="full-video-player">
                {player($video, $content)}
            </div>
            {/explblock}

            {explblock name='article_header'}
            <header class="full-video-header">
                <h1 class="title">{ng_render_field($content.fields.title)}</h1>
                {if $content.contentInfo.publishedDate}
                    <time>{$content.contentInfo.publishedDate|format_date}</time>
                {/if}
            </header>
            {/explblock}

            {explblock name='article_body'}
            {if not($content.fields.teaser_intro['empty'])}
                <div class="short">
                    {ng_render_field($content.fields.teaser_intro)}
                </div>
            {/if}

            {if not($content.fields.description['empty'])}
                <div class="body">
                    {ng_render_field($content.fields.description)}
                </div>
            {/if}
            {/explblock}
        </div>
    </div>
{/explblock}