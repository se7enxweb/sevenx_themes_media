{* EXTENDS design:$nglayouts.layoutTemplate *}

{def $show_path = false}

{* BLOCK content *}
    <form action="{path('ngsite_content_search')}" method="get" class="form-search">
        <header class="full-page-header full-search-header no-breadcrumbs">
            <div class="container">
                <div class="search-inputs">
                    <div class="input-group">
                        <input type="text" aria-label="{$'ngsite.search.placeholder'|trans}" value="{$search_text}" name="searchText" id="Search" class="form-control" placeholder="{$'ngsite.search.placeholder'|trans}" />
                        <button type="submit" aria-label="{$'ngsite.search.submit_search'|trans}" class="btn btn-sm btn-dark">{$'ngsite.search.button'|trans}<i class="icon-search" aria-hidden="true"></i></button>
                    </div>

                    {if not($search_text|count()|eq(0))}
                        {if $pager.nbResults|eq(0)}
                            <div class="result-message result-message-error">
                                <p role="status" class="search-text">{$'ngsite.search.no_results'|trans(hash('%searchText%', $search_text))}</p>

                                {if not($search_suggestion|count()|eq(0))}
                                    <div class="result-notice">
                                        <p>
                                            {$'ngsite.search.did_you_mean'|trans}
                                            <a href="{path('ngsite_content_search', hash('searchText', $search_suggestion))}">{$search_suggestion}</a>?
                                        </p>
                                    </div>
                                {/if}
                            </div>
                        {else}
                            <div class="result-message result-message-success">
                                <p role="status" class="search-text">{$'ngsite.search.results'|trans(hash('%searchText%', $search_text, '%searchCount%', $pager.nbResults))}</p>
                            </div>
                        {/if}
                    {/if}
                </div>
            </div>
        </header>

        <div class="full-search-results">
            <div class="container">
                {if not($search_text|count()|eq(0))}
                    <div class="row">
                        <div class="col-xs-12">
                            {if $pager.nbResults|gt(0)}
                                {if haveToPaginate($pager)}
                                    {pagerfanta($pager, 'ngsite')}
                                {/if}

                                <div id="search-result" class="search-result">
                                    {foreach $pager.currentPageResults.searchHits as $search_hit}
                                        {def $score = null}
                                        {if and(and(and(not($search_hit.score|eq(null)), is_set($pager.adapter.maxScore)), not($pager.adapter.maxScore|eq(null))), ($pager.adapter.maxScore|ne(0)))}
                                            {def $score = $search_hit.score|div($pager.adapter.maxScore)|mul(100)|round}
                                        {/if}

                                        {ng_view_content($search_hit.valueObject, 'search', hash('params', hash('score_percent', $score)))}
                                    {/foreach}
                                </div>

                                {if haveToPaginate($pager)}
                                    {pagerfanta($pager, 'ngsite')}
                                {/if}
                            {else}
                                <ul class="full-no-results-list">
                                    <li>{$'ngsite.search.no_results.check_spelling'|trans}</li>
                                    <li>{$'ngsite.search.no_results.change_keywords'|trans}</li>
                                    <li>{$'ngsite.search.no_results.less_specific_keywords'|trans}</li>
                                    <li>{$'ngsite.search.no_results.reduce_keywords'|trans}</li>
                                </ul>
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    </form>
{* ENDBLOCK content *}
