loadData(null, null, null, null, "id-desc", "", "");

$("body").on("click", ".btn-remove-all-filter", function () {
    $('.categorie-filter input').prop('checked', false);
    $('.brand-filter input').prop('checked', false);

    $("#product-sorter .nice-select ul li.option").removeClass('selected');
    $("#product-sorter .nice-select ul li.option:first").addClass('selected');
    $("#product-sorter .nice-select span.current").html($("#product-sorter .nice-select ul li.option.selected").html());

    $('#price-range-min').val('');
    $('#price-range-max').val('');

    changeBrandByCategory("");

    loadData(null, null, null, null, "id-desc", "", "");
});

$("body").on("click", ".categorie-filter .more", function () {
    $('.categorie-filter ul').removeClass('collapsed');
    $('.categorie-filter ul').addClass('expanded');

    $('.btn-category-extra.less').css('display', 'inline-block');
});

$("body").on("click", ".btn-category-extra.less", function () {
    $('.categorie-filter ul').addClass('collapsed');
    $('.categorie-filter ul').removeClass('expanded');

    $('.btn-category-extra.less').css('display', 'none');
});

$("body").on("click", ".brand-filter .more", function () {
    $('.brand-filter ul').removeClass('collapsed');
    $('.brand-filter ul').addClass('expanded');

    $('.btn-brand-extra.less').css('display','inline-block');
});

$("body").on("click", ".btn-brand-extra.less", function () {
    $('.brand-filter ul').addClass('collapsed');
    $('.brand-filter ul').removeClass('expanded');

    $('.btn-brand-extra.less').css('display', 'none');
});

$("body").on("click", ".btn-filter-price-product", function () {
    if (ValidationFilterPrice()) {
        var _sorter = $('#product-sorter option:selected').attr('value');

        var _priceMin = $('#price-range-min').val();
        var _priceMax = $('#price-range-max').val();

        var cateId = "";
        $('.categorie-filter input').each(function () {
            if ($(this).is(':checked')) {
                cateId += $(this).val() + ",";
            }
        });

        cateList = cateId.slice(0, cateId.length - 1);

        var brand = "";
        $('.brand-filter input').each(function () {
            if ($(this).is(':checked')) {
                brand += "'" + $(this).val() + "'" + ",";
            }
        });
        brandList = brand.slice(0, brand.length - 1);

        loadData(null, null, _priceMin, _priceMax, _sorter, cateList, brandList);
    }
});

function ValidationFilterPrice() {
    var check = true;
    var _priceMin = Number($('#price-range-min').val());
    var _priceMax = Number($('#price-range-max').val());
    var ccc = $('#price-range-max').val();
    if (_priceMin == 0 && _priceMax == 0) {
        $('.price-range-filter__inputs-error').html("Vui lòng điền khoảng giá phù hợp!");
        check = false;
    } else if (_priceMin > 0 && _priceMax > 0 && _priceMin > _priceMax) {
        $('.price-range-filter__inputs-error').html("Vui lòng điền khoảng giá phù hợp!");
        check = false;
    } else if (_priceMin > 0 && _priceMax == 0 && ccc != "") {
        $('.price-range-filter__inputs-error').html("Vui lòng điền khoảng giá phù hợp!");
        check = false;
    }else {
        $('.price-range-filter__inputs-error').html("");
    }

    return check;
}

$('.categorie-filter input').on('change', function () {
    //loại bỏ các checked khác ngoại trừ cái hiện tại
    //$('.categorie-filter input').not(this).prop('checked', false);
    $('.brand-filter input').prop('checked', false);

    var _sorter = $('#product-sorter option:selected').attr('value');

    $('#price-range-min').val("");
    $('#price-range-max').val("");

    var cateId = "";
     //lọc nhiều nhiều
    $('.categorie-filter input').each(function () {
        if ($(this).is(':checked')) {
            cateId += $(this).val() + ",";
        }
    });

    cateList = cateId.slice(0, cateId.length - 1);

    loadData(null, null, null, null, _sorter, cateList, "");
});

$("body").on("click", ".categorie-filter input", function () {

    var _sorter = $('#product-sorter option:selected').attr('value');

    var cateId = "";
    //lọc nhiều nhiều
    $('.categorie-filter input').each(function () {
        if ($(this).is(':checked')) {
            cateId += $(this).val() + ",";
        }
    });

    cateList = cateId.slice(0, cateId.length - 1);
    changeBrandByCategory(cateList);

    var brand = "";
    $('.brand-filter input').each(function () {
        if ($(this).is(':checked')) {
            brand += "'" + $(this).val() + "'" + ",";
        }
    });
    brandList = brand.slice(0, brand.length - 1);

    //loadData(null, null, null, null, _sorter, cateList, brandList);
});

function changeBrandByCategory(cateList) {
    $.ajax({
        url: '/Home/getBrandByCategory',
        type: 'GET',
        data: { listCate: cateList },
        success: function (res) {
            $('.brand-filter ul').remove();
            $('.btn-brand-extra.less').remove();

            var _html = '<ul class="sidbar-style collapsed">';
            
            var j = 1;
            $.each(res.data, function (i, item) {
                if (j > 6) {
                    if (j == 7) {
                        _html += '<li class="form-check more">Xem thêm <i class="fa fa-angle-down" aria-hidden="true"></i></li>'
                    }

                    _html += '<li class="form-check extra">'
                    _html += '<input class="form-check-input" value="' + item.brandName + '" id="' + item.brandName + '" type="checkbox">'
                    _html += '<label class="form-check-label " for="' + item.brandName + '">' + item.brandName + '</label>'
                    _html += '</li>'
                }
                else {
                    _html += '<li class="form-check">'
                    _html += '<input class="form-check-input" value="' + item.brandName + '" id="' + item.brandName + '" type="checkbox">'
                    _html += '<label class="form-check-label " for="' + item.brandName + '">' + item.brandName + '</label>'
                    _html += '</li>'
                }
                j++;
            });

            _html += '</ul>'
            _html += '<span class="btn-brand-extra less"> Thu gọn <i class="fa fa-angle-up" aria-hidden="true"></i> </span>'

            $('.brand-filter').append(_html);
        }
    });
}

$("body").on("click", ".brand-filter input", function () {

    var _sorter = $('#product-sorter option:selected').attr('value');

    var _priceMin = $('#price-range-min').val();
    var _priceMax = $('#price-range-max').val();

    var cateId = "";
    $('.categorie-filter input').each(function () {
        if ($(this).is(':checked')) {
            cateId += $(this).val() + ",";
        }
    });

    cateList = cateId.slice(0, cateId.length - 1);

    var brand = "";
    $('.brand-filter input').each(function () {
        if ($(this).is(':checked')) {
            brand += "'" + $(this).val() + "'" + ",";
        }
    });
    brandList = brand.slice(0, brand.length - 1);

    loadData(null, null, _priceMin, _priceMax, _sorter, cateList, brandList);
});

$(document).on('change', '#product-sorter select', function () {

    var _sorter = $(this).val();

    var _priceMin = $('#price-range-min').val();
    var _priceMax = $('#price-range-max').val();

    var cateId = "";
    $('.categorie-filter input').each(function () {
        if ($(this).is(':checked')) {
            cateId += $(this).val() + ",";
        }
    });

    cateList = cateId.slice(0, cateId.length - 1);

    var brand = "";
    $('.brand-filter input').each(function () {
        if ($(this).is(':checked')) {
            brand += "'" + $(this).val() + "'" + ",";
        }
    });
    brandList = brand.slice(0, brand.length - 1);

    loadData(null, null, _priceMin, _priceMax, _sorter, cateList, brandList);
});
function loadData(_page, _pageSize, _priceMin, _priceMax, _sort, _cateFilter, _brFilter) {
    $.ajax({
        url: '/Home/loadData',
        type: 'GET',
        data: { page: _page, pageSize: _pageSize, priceMin: _priceMin, priceMax: _priceMax, sort: _sort, cateFilter: _cateFilter, brFilter: _brFilter },
        dataType: 'json',
        success: function (res) {
            if (res.TotalItems > 0) {
                $('.show-items-lenght').html(res.TotalItems);
                var data = res.proList;
                var html_grid = '';
                var template_grid = $('#product_grid_view_teamplate').html();
                $.each(data, function (i, item) {
                    html_grid += Mustache.render(template_grid, {
                        ProId: item.id,
                        ProName: item.name,
                        Slug: item.slug,
                        Price: ProductPrice(item.price, item.priceMax, item.priceMin),
                        Image: item.image
                    });
                });

                $('.product-gcosmetic-grid-view').html(html_grid);

                var html_list = '';
                var template_list = $('#product_list_view_teamplate').html();
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

                $('.product-gcosmetic-list-view').html(html_list);
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

    var _sorter = $('#product-sorter option:selected').attr('value');

    var _priceMin = $('#price-range-min').val();
    var _priceMax = $('#price-range-max').val();

    var cateId = "";
    $('.categorie-filter input').each(function () {
        if ($(this).is(':checked')) {
            cateId += $(this).val() + ",";
        }
    });

    cateList = cateId.slice(0, cateId.length - 1);

    var brand = "";
    $('.brand-filter input').each(function () {
        if ($(this).is(':checked')) {
            brand += "'" + $(this).val() + "'" + ",";
        }
    });
    brandList = brand.slice(0, brand.length - 1);

    loadData(page, pageSize, _priceMin, _priceMax, _sorter, cateList, brandList);
}