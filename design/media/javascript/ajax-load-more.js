(function () {
    function initLoadMore() {
        document.querySelectorAll('.ajax-collection').forEach(function (collection) {
            var nav = collection.querySelector('.ajax-navigation');
            if (!nav) return;
            var loadMore = nav.querySelector('.ajax-load-more');
            if (!loadMore) {
                nav.style.display = 'none';
                return;
            }

            loadMore.addEventListener('click', function (e) {
                e.preventDefault();

                var blockId = loadMore.getAttribute('data-block-id');
                var nodeId = loadMore.getAttribute('data-node-id');
                var page = parseInt(loadMore.getAttribute('data-page'), 10);
                var totalPages = parseInt(nav.getAttribute('data-total-pages'), 10);

                if (!blockId || !nodeId || !page || page > totalPages) {
                    loadMore.style.display = 'none';
                    nav.style.display = 'none';
                    return;
                }

                if (loadMore.getAttribute('aria-busy') === 'true') {
                    return;
                }

                loadMore.setAttribute('aria-busy', 'true');
                loadMore.classList.add('ajax-loading');

                var url = '/ezjscore/call/expajaxloadmore::loadMore::' + encodeURIComponent(blockId) + '::' + encodeURIComponent(page) + '?ContentType=json&node_id=' + encodeURIComponent(nodeId);

                fetch(url, {
                    headers: { 'Accept': 'application/json' }
                })
                .then(function (response) {
                    if (!response.ok) throw new Error('Network response was not ok');
                    return response.json();
                })
                .then(function (data) {
                    if (data && data.error_text) throw new Error(data.error_text);
                    var html = data && data.content ? data.content : '';

                    if (!html || !html.trim()) {
                        loadMore.style.display = 'none';
                        nav.style.display = 'none';
                        return;
                    }

                    var fragment = document.createRange().createContextualFragment(html);

                    var container = collection.querySelector('.ajax-container');
                    var isGridRow = container && (container.classList.contains('row') || /(^| )row( |$)/.test(container.className));

                    if (container && !isGridRow) {
                        container.appendChild(fragment);
                    } else {
                        nav.parentNode.insertBefore(fragment, nav);
                    }

                    collection.dispatchEvent(new CustomEvent('ajax-paging-added', { bubbles: true }));

                    if (page < totalPages) {
                        loadMore.setAttribute('data-page', page + 1);
                        nav.setAttribute('data-page', page + 1);
                    } else {
                        loadMore.style.display = 'none';
                        nav.style.display = 'none';
                    }
                })
                .catch(function (error) {
                    window.console && console.error('Load more failed', error);
                })
                .finally(function () {
                    loadMore.removeAttribute('aria-busy');
                    loadMore.classList.remove('ajax-loading');
                });
            });
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initLoadMore);
    } else {
        initLoadMore();
    }
})();
