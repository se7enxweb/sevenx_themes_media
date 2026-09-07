{* tpl_block block_name = article_header.
   Renders the full-view header region (topic eyebrow, h1, author line) as a
   standalone layout block. The part resolves its own node from
   $module_result.content_info.node_id, so no block parameters are needed. *}
{include uri='design:content/parts/full_header.tpl' module_result=$module_result}
