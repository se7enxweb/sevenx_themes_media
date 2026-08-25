{def $show_path = false}

<form action={"/content/search/"|ezurl} method="get" class="form-search">
    <header class="full-page-header full-search-header no-breadcrumbs">
        <div class="container">
            <div class="search-inputs">
                <div class="input-group">
                    <input type="text" aria-label="Search text" value="{$search_text|wash}" name="SearchText" id="Search" class="form-control" placeholder="Search text" />
                    <button type="submit" aria-label="Submit search" class="btn btn-sm btn-dark">Search<i class="icon-search" aria-hidden="true"></i></button>
                </div>

                {if not($search_text|count()|eq(0))}
                    {if $search_count|eq(0)}
                        <div class="result-message result-message-error">
                            <p role="status" class="search-text">{"No results were found when searching for %1"|i18n("ngsite/search","",array($search_text|wash))}</p>

                            {if is_set($search_suggestion)}
                                {if not($search_suggestion|count()|eq(0))}
                                    <div class="result-notice">
                                        <p>
                                            {"Did you mean:"|i18n("ngsite/search")}
                                            <a href={concat('/content/search/?SearchText=', $search_suggestion|urlencode)|ezurl}>{$search_suggestion}</a>?
                                        </p>
                                    </div>
                                {/if}
                            {/if}
                        </div>
                    {else}
                        <div class="result-message result-message-success">
                            <p role="status" class="search-text">{"Search for %1 returned %2 matches"|i18n("ngsite/search","",array($search_text|wash,$search_count))}</p>
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
                        {if $search_count|gt(0)}
                            {include name=Navigator
                                     uri='design:navigator/google.tpl'
                                     page_uri='/content/search'
                                     page_uri_suffix=concat('?SearchText=',$search_text|urlencode)
                                     item_count=$search_count
                                     view_parameters=$view_parameters
                                     item_limit=$page_limit}

                            <div id="search-result" class="search-result">
                                {foreach $search_result as $search_item}
                                    {ng_view_content($search_item, 'search')}
                                {/foreach}
                            </div>

                            {include name=Navigator
                                     uri='design:navigator/google.tpl'
                                     page_uri='/content/search'
                                     page_uri_suffix=concat('?SearchText=',$search_text|urlencode)
                                     item_count=$search_count
                                     view_parameters=$view_parameters
                                     item_limit=$page_limit}
                        {else}
                            <ul class="full-no-results-list">
                                <li>{"Check the spelling of your keywords."|i18n("ngsite/search")}</li>
                                <li>{"Try using different keywords."|i18n("ngsite/search")}</li>
                                <li>{"Try using fewer keywords."|i18n("ngsite/search")}</li>
                                <li>{"Try using more generic keywords."|i18n("ngsite/search")}</li>
                            </ul>
                        {/if}
                    </div>
                </div>
            {/if}
        </div>
    </div>
</form>
