var _search = "";
if ($('li.searchbar-mobile-table').css('display') == "none") {
    _search = $('#search-content-large').val();
} else if ($('li.searchbar-mobile-table').css('display') == 'block') {
    _search = $('#search-content-mobile').val();
}

loadData(null, null, _search, "id-desc");

$(document).on('change', '#product-sorter select', function () {
    var _search = "";
    if ($('li.searchbar-mobile-table').css('display') == "none") {
        _search = $('#search-content-large').val();
    } else if ($('li.searchbar-mobile-table').css('display') == 'block') {
        _search = $('#search-content-mobile').val();
    }

    var _sorter = $(this).val();


    loadData(null, null, _search, _sorter);
});

function loadData(_page, _pageSize, _search, _sort) {
    $.ajax({
        url: '/Home/loadDataSearch',
        type: 'GET',
        data: { page: _page, pageSize: _pageSize, search: _search, sort: _sort },
        dataType: 'json',
        success: function (res) {
            if (res.TotalItems > 0) {
                $('.show-items-lenght').html(res.TotalItems);
                var data = res.proList;
                var html_grid = '';
                var template_grid = $('#product_grid_view_search').html();
                $.each(data, function (i, item) {
                    html_grid += Mustache.render(template_grid, {
                        ProId: item.id,
                        ProName: item.name,
                        Slug: item.slug,
                        Price: ProductPrice(item.price, item.priceMax, item.priceMin),
                        Image: item.image
                    });
                });

                $('.product-search-grid-view').html(html_grid);

                var html_list = '';
                var template_list = $('#product_list_view_search').html();
                $.each(data, function (i, item) {
                    html_list += Mustache.render(template_list, {
                        ProId: item.id,
                        ProName: item.name,
                        Slug: item.slug,
                        Price: ProductPrice(item.price, item.priceMax, item.priceMin),
                        Description: item.description,
                        Image: item.image
                    });
                });

                $("p.shop-product-info").css("display", "none");
                $(".shop-products-grid-list").css({ "display": "block", "position": "static", "left": "0" });
                $(".shop-product-ares").css("display", "block");
                $(".shop-product-pagination").css("display", "block");

                $('.product-search-list-view').html(html_list);
                Pagination(res.CurrentPage, res.NumberPage, res.PageSize);
            } else {
                $("p.shop-product-info").css("display", "block");
                $(".shop-products-grid-list").css({ "display": "none", "position": "absolute", "left": "-9999px" });
                $(".shop-product-ares").css("display", "none");
                $(".shop-product-pagination").css("display", "none");
            }
        }
    })
}

function ProductPrice(price, priceMax, priceMin) {
    var p = "";
    var priceStr = price.toString();
    var priceMaxStr = priceMax.toString();
    var priceMinStr = priceMin.toString();
    if (price > 0) {
        p = priceStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + " VNĐ";
    } else {
        if (priceMax == priceMin && priceMax > 0 && priceMin > 0) {
            p = priceMaxStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + " VNĐ";
        } else if (priceMax == 0 && priceMin == 0 && price == 0) {
            p = "Liên hệ";
        } else {
            p = priceMinStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "~" + priceMaxStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + " VNĐ";
        }
    }

    return p;
}

function Pagination(curPage, totalPages, pageSize) {
    const delta = 2; // số hiển thị 2 bên curPage VD curPage = 6: ... 4 5 6 7 8 ...
    var truncate = true;
    const range = delta + 4; // use for handle visible number of links left side

    let render = "";
    let renderTwoSide = "";

    if (curPage != 1) {
        render += `<li class="float-left prev 1_1"><a href="javascript:void(0);" onclick="NextPage(${curPage - 1},${pageSize})"><i class="fa fa-angle-left" aria-hidden="true"></i>Previous</a></li>`;
    } else {
        render += `<li class="float-left prev 1_2"><a href="javascript:void(0);"><i class="fa fa-angle-left" aria-hidden="true"></i>Previous</a></li>`;
    }

    let dot = `<li><a href="javascript:void(0);">...</a></li>`;
    let countTruncate = 0; // use for ellipsis - truncate left side or right side

    // use for truncate two side
    const numberTruncateLeft = curPage - delta;
    const numberTruncateRight = curPage + delta;

    let active = "";
    for (let pos = 1; pos <= totalPages; pos++) {
        active = pos === curPage ? "active" : "";

        // truncate
        if (totalPages >= 2 * range - 1 && truncate) { // truncate = true có thu gọn bằng ...
            if (numberTruncateLeft > 3 && numberTruncateRight < totalPages - 3 + 1) {//Thu gọn bên trái và cả bên phải
                // truncate 2 side
                if (pos >= numberTruncateLeft && pos <= numberTruncateRight) {
                    renderTwoSide += renderPage(pos, active, pageSize);
                }
            } else {
                // truncate left side or right side
                if (
                    (curPage < range && pos <= range) ||
                    (curPage > totalPages - range && pos >= totalPages - range + 1) ||
                    pos === totalPages ||
                    pos === 1
                ) {//Thu gọn bên trái không thu gọn bên phải || Thu gọn bên phải không thu gọn bên trái
                    render += renderPage(pos, active, pageSize);
                } else {
                    countTruncate++;
                    if (countTruncate === 1) render += dot;
                }
            }
        } else {
            // truncate = false không thu gọn bằng ...
            render += renderPage(pos, active, pageSize);
        }
    }

    if (renderTwoSide) {//nếu có thu gọn ... 
        var prevTwoSide = "";
        if (curPage != 1) {
            prevTwoSide += `<li class="float-left prev 2_1"><a href="javascript:void(0);" onclick="NextPage(${curPage - 1},${pageSize})"><i class="fa fa-angle-left" aria-hidden="true"></i>Previous</a></li>`;
        }

        renderTwoSide = prevTwoSide + renderPage(1, "", pageSize) + dot + renderTwoSide + dot + renderPage(totalPages, "", pageSize);

        if (curPage != totalPages) {
            renderTwoSide += `<li class="float-right next 2_3"><a href="javascript:void(0);" onclick="NextPage(${curPage + 1},${pageSize})"> Next<i class="fa fa-angle-right" aria-hidden="true"></i></a>`;
        }

        $('.shop-product-pagination ul').html(renderTwoSide);
    } else {
        if (curPage != totalPages) {
            render += `<li class="float-right next 1_3"><a href="javascript:void(0);" onclick="NextPage(${curPage + 1},${pageSize})"> Next<i class="fa fa-angle-right" aria-hidden="true"></i></a>`;
        } else {
            render += `<li class="float-right next 1_4"><a href="javascript:void(0);"> Next<i class="fa fa-angle-right" aria-hidden="true"></i></a>`;
        }

        $('.shop-product-pagination ul').html(render);
    }
}

function renderPage(index, active = "", pageSize) {
    return `<li class="${active}"><a href="javascript:void(0);" onclick="NextPage(${index},${pageSize})">${index}</a></li>`;
}

function NextPage(page, pageSize) {
    var _search = "";
    if ($('li.searchbar-mobile-table').css('display') == "none") {
        _search = $('#search-content-large').val();
    } else if ($('li.searchbar-mobile-table').css('display') == 'block') {
        _search = $('#search-content-mobile').val();
    }

    var _sorter = $('#product-sorter option:selected').attr('value');

    loadData(page, pageSize,_search, _sorter);
}