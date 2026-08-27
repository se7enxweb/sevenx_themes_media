{* Full view of a legacy 'gallery' class: header plus a grid of child image/video thumbnails. *}
{def $gallery_children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                           'class_filter_type', 'include',
                                                           'class_filter_array', array( 'image', 'video' ),
                                                           'sort_by', array( array( 'priority', true() ), array( 'published', true() ) ) ) )}
<div class="view-type view-type-full gallery">
    <header class="full-page-header">
        <div class="container">
            <h1 class="full-page-title">{$node.name|wash}</h1>
        </div>
    </header>

    <div class="container">
        <div class="gallery-grid">
        {foreach $gallery_children as $child}
            {node_view_gui content_node=$child view='image_gallery'}
        {/foreach}
        </div>
    </div>
</div>
{undef $gallery_children}
