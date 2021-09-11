
$('#main-menu-navigation > li').removeClass('active');
$('#main-menu-navigation > li:eq(1)').addClass('sidebar-group-active');
$('#main-menu-navigation .has-sub ul li:eq(1)').addClass('active');

if ($('#pro_search').length == 1) {
    var productlength = $('#DataTables_product_length option:selected').attr('value');
    var txtSearch = $('#pro_search').val();
    loadData(txtSearch, null, productlength);
}

$(document).on('change', '#DataTables_product_length', function () {
    var productlength = $(this).val();
    var txtSearch = $('#pro_search').val();

    loadData(txtSearch, null, productlength);
});

$(".upload-image-list").on("click", ".upload-image-item .image-bg", function () {
    var finder = new CKFinder();
    var row = $(this);
    finder.selectActionFunction = function (fileUrl) {
        row.next().attr('style', "background-image:url(" + fileUrl + ")");
        row.next().attr('data-url', fileUrl);
    };
    finder.popup();
});

$('#pro_search').keyup(function () {
    var txtSearch = $('#pro_search').val();
    $('.pro-table tbody').html('');

    var productlength = $('#DataTables_product_length option:selected').attr('value');
    loadData(txtSearch, null, productlength);
});


$('#product-add-name').keyup(function () {
    var name = $('#product-add-name').val();

    $('#product-add-slug').val(slugAuto(name));
});

function convertString(str) {
    var strTrim = str.trim();
    let splitSent = strTrim.toLowerCase().split(" ");
    for (let i = 0; i < splitSent.length; i++) {
        splitSent[i] = splitSent[i][0].toUpperCase() + splitSent[i].slice(1);
    }

    return splitSent.join(" ");
}

$(document).on('click', '.btn-save-product', function () {
    if (ValidationProduct()) {
        var proName = $('#product-add-name').val();
        var proBrand = convertString($('#product-add-brand').val());
        var category_id = $('#product-add-category option:selected').attr('value');
        var proDescription = $('#product-add-description').val();
        var proPrice = $('#product-add-price').val();
        if ($('.product-pr[style="display: none;"]').length == 1) {
            proPrice = 0
        }

        var proSlug = $('#product-add-slug').val();
        var proStatus = $('.product-add-status:checked').attr('value') == 1 ? true : false;
        var proContent = CKEDITOR.instances['product-content'].getData();
        var proImg = $('.upload-image-item:first .show-image').attr('data-url');

        var proImgList = new Array();
        $(".upload-image-list .upload-image-item").each(function () {
            var row = $(this);
            var url = row.find(".show-image").attr('data-url');

            proImgList.push(url);
        });

        var productData = {
            name: proName,
            brand: proBrand,
            image: proImg,
            image_list: proImgList.toString(),
            price: proPrice,
            description: proDescription,
            category_id: category_id,
            content: proContent,
            status: proStatus,
            slug: proSlug
        };

        SaveProduct(productData);
    }
});

function SaveProduct(productData) {
    $.ajax({
        url: 'SaveProduct',
        type: 'POST',
        data: JSON.stringify(productData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (res) {
            if ($('.classification-details[style="display: block;"]').length == 1) {
                if (res.proId > 0) {

                    // Save Attributes
                    var dataAttribute = new Array();
                    $(".classify-group .classify-item").each(function () {
                        var row = $(this);
                        var attribute = {};
                        attribute.name = row.find(".classify-name input").val();
                        attribute.product_id = res.proId;

                        dataAttribute.push(attribute);
                    });

                    $.ajax({
                        url: 'SaveAttribute',
                        type: 'POST',
                        data: JSON.stringify(dataAttribute),
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (attrId) {
                            if (attrId.length > 0) {
                                $('.classify-group .classify-item:first-child .classify-box-list .classify-item2').find('input').attr('data-id', attrId[0]);
                                if ($(".classify-group .classify-item:nth-child(2)").length == 1) {
                                    $('.classify-group .classify-item:nth-child(2) .classify-box-list .classify-item2').find('input').attr('data-id', attrId[1]);
                                }

                                var dataAttributeValues = new Array();
                                $(".classify-item .classify-box-list .classify-item2").each(function () {
                                    var row = $(this);
                                    var value = {};
                                    value.name = row.find("input").val();
                                    value.attribute_id = row.find("input").data('id');
                                    value.status = row.find(".product-attr-status input").prop('checked');

                                    dataAttributeValues.push(value);
                                });

                                $.ajax({
                                    url: 'SaveAttributeValue',
                                    type: 'POST',
                                    data: JSON.stringify(dataAttributeValues),
                                    dataType: "json",
                                    contentType: "application/json; charset=utf-8",
                                    success: function (result) {
                                        if (result == true) {
                                            // save Skus
                                            var dataSkus = new Array();
                                            $(".classify-table tbody tr").each(function () {
                                                var row = $(this);
                                                var sku = {};
                                                sku.price = row.find("input[name='classify-price']").val();
                                                sku.sku1 = row.find("input[name='classify-sku']").val();
                                                sku.product_id = res.proId;

                                                var attr_index = row.parent().index() - 1;
                                                var attr_name = $(".classify-item:first-child .classify-name").find("input").val();

                                                sku_attributes_object = {};
                                                sku_attributes_object[attr_name] = $(".classify-item:first-child .classify-box-list .classify-item2").eq(attr_index).find("input").val();;
                                                if ($(".classify-group .classify-item:nth-child(2)").length == 1) {
                                                    var attr_name_two = $(".classify-item:nth-child(2) .classify-name").find("input").val();
                                                    sku_attributes_object[attr_name_two] = row.find("td[scope='row']").html();
                                                }

                                                sku.sku_attributes = JSON.stringify(sku_attributes_object);

                                                dataSkus.push(sku);
                                            });

                                            $.ajax({
                                                url: 'SaveSkus',
                                                type: 'POST',
                                                data: JSON.stringify(dataSkus),
                                                dataType: "json",
                                                contentType: "application/json; charset=utf-8",
                                                success: function (returndata) {
                                                    if (returndata.ok)
                                                        window.location = returndata.newurl;
                                                    else
                                                        toastr.error('Thêm mới thất bại!', 'Error!', {
                                                            closeButton: true,
                                                            tapToDismiss: false
                                                        });
                                                }
                                            });
                                        } else {
                                            toastr.error('Thêm mới thất bại!', 'Error!', {
                                                closeButton: true,
                                                tapToDismiss: false
                                            });
                                        }
                                    }
                                });
                            } else {
                                toastr.error('Thêm mới thất bại!', 'Error!', {
                                    closeButton: true,
                                    tapToDismiss: false
                                });
                            }
                        }
                    });
                } else {
                    toastr.error('Thêm mới thất bại!', 'Error!', {
                        closeButton: true,
                        tapToDismiss: false
                    });
                }
            } else if ($('.classification-details[style="display: block;"]').length == 0) {
                if (res.proId > 0)
                    window.location = res.newurl;
                else
                    toastr.error('Thêm mới thất bại!', 'Error!', {
                        closeButton: true,
                        tapToDismiss: false
                    });
            }
        }
    });
}

$(document).on('click', '.btn-edit-product', function () {
    if (ValidationProduct()) {
        var proId = $('#product-edit-id').val();
        var proName = $('#product-add-name').val();
        var proBrand = convertString($('#product-add-brand').val());
        var category_id = $('#product-add-category option:selected').attr('value');
        var proDescription = $('#product-add-description').val();
        var proPrice = $('#product-add-price').val();
        if ($('.product-pr[style="display: none;"]').length == 1) {
            proPrice = 0
        }

        var proSlug = $('#product-add-slug').val();
        var proStatus = $('.product-add-status:checked').attr('value') == 1 ? true : false;
        var proContent = CKEDITOR.instances['product-content'].getData();
        var proImg = $('.upload-image-item:first .show-image').attr('data-url');

        var proImgList = new Array();
        $(".upload-image-list .upload-image-item").each(function () {
            var row = $(this);
            var url = row.find(".show-image").attr('data-url');

            proImgList.push(url);
        });

        var productData = {
            id: proId,
            name: proName,
            brand: proBrand,
            image: proImg,
            image_list: proImgList.toString(),
            price: proPrice,
            description: proDescription,
            category_id: category_id,
            content: proContent,
            status: proStatus,
            slug: proSlug
        };

        EditProduct(productData);
    }
});

function EditProduct(productData) {
    $.ajax({
        url: 'EditProduct',
        type: 'POST',
        data: JSON.stringify(productData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (res) {
            if ($('.classification-details[style="display: block;"]').length == 1) {
                if (res.proId > 0) {
                    // Edit Attributes
                    var dataAttribute = new Array();
                    $(".classify-group .classify-item").each(function () {
                        var row = $(this);
                        var attribute = {};
                        attribute.name = row.find(".classify-name input").val();
                        attribute.product_id = res.proId;

                        dataAttribute.push(attribute);
                    });

                    $.ajax({
                        url: 'SaveAttribute',
                        type: 'POST',
                        data: JSON.stringify(dataAttribute),
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (attrId) {
                            if (attrId.length > 0) {
                                $('.classify-group .classify-item:first-child .classify-box-list .classify-item2').find('input').attr('data-id', attrId[0]);
                                if ($(".classify-group .classify-item:nth-child(2)").length == 1) {
                                    $('.classify-group .classify-item:nth-child(2) .classify-box-list .classify-item2').find('input').attr('data-id', attrId[1]);
                                }

                                var dataAttributeValues = new Array();
                                $(".classify-item .classify-box-list .classify-item2").each(function () {
                                    var row = $(this);
                                    var value = {};
                                    value.name = row.find("input").val();
                                    value.attribute_id = row.find("input").data('id');
                                    value.status = row.find(".product-attr-status input.status-n3").prop('checked');

                                    dataAttributeValues.push(value);
                                });

                                $.ajax({
                                    url: 'SaveAttributeValue',
                                    type: 'POST',
                                    data: JSON.stringify(dataAttributeValues),
                                    dataType: "json",
                                    contentType: "application/json; charset=utf-8",
                                    success: function (result) {
                                        if (result == true) {
                                            // save Skus
                                            var dataSkus = new Array();
                                            $(".classify-table tbody tr").each(function () {
                                                var row = $(this);
                                                var sku = {};
                                                sku.price = row.find("input[name='classify-price']").val();
                                                sku.sku1 = row.find("input[name='classify-sku']").val();
                                                sku.product_id = res.proId;

                                                var attr_index = row.parent().index() - 1;
                                                var attr_name = $(".classify-item:first-child .classify-name").find("input").val();

                                                sku_attributes_object = {};
                                                sku_attributes_object[attr_name] = $(".classify-item:first-child .classify-box-list .classify-item2").eq(attr_index).find("input").val();;
                                                if ($(".classify-group .classify-item:nth-child(2)").length == 1) {
                                                    var attr_name_two = $(".classify-item:nth-child(2) .classify-name").find("input").val();
                                                    sku_attributes_object[attr_name_two] = row.find("td[scope='row']").html();
                                                }

                                                sku.sku_attributes = JSON.stringify(sku_attributes_object);

                                                dataSkus.push(sku);
                                            });

                                            $.ajax({
                                                url: 'SaveSkus',
                                                type: 'POST',
                                                data: JSON.stringify(dataSkus),
                                                dataType: "json",
                                                contentType: "application/json; charset=utf-8",
                                                success: function (returndata) {
                                                    if (returndata.ok)
                                                        window.location = returndata.newurl;
                                                    else
                                                        toastr.error('Cập nhật thất bại!', 'Error!', {
                                                            closeButton: true,
                                                            tapToDismiss: false
                                                        });
                                                }
                                            });
                                        } else {
                                            toastr.error('Cập nhật thất bại!', 'Error!', {
                                                closeButton: true,
                                                tapToDismiss: false
                                            });
                                        }
                                    }
                                });
                            } else {
                                toastr.error('Cập nhật thất bại!', 'Error!', {
                                    closeButton: true,
                                    tapToDismiss: false
                                });
                            }
                        }
                    });
                } else {
                    toastr.error('Cập nhật thất bại!', 'Error!', {
                        closeButton: true,
                        tapToDismiss: false
                    });
                }
            } else if ($('.classification-details[style="display: block;"]').length == 0) {
                if (res.proId > 0)
                    window.location = res.newurl;
                else
                    toastr.error('Cập nhật thất bại!', 'Error!', {
                        closeButton: true,
                        tapToDismiss: false
                    });
            }
        }
    });
}

function ValidationProduct() {
    var check = true;
    var prName = $('#product-add-name').val();
    var prCate = $('#product-add-category option:selected').attr('value');
    var prBrand = $('#product-add-brand').val();

    var prSlug = $('#product-add-slug').val();

    if (prName === '') {
        $('#product-add-name').next().html('Vui lòng nhập Tên sản phẩm!');
        check = false;
    } else {
        $('#product-add-name').next().html('');

    }

    if (prBrand === '') {
        $('#product-add-brand').parent().next().html('Vui lòng nhập Thương hiệu!');
        check = false;
    } else {
        $('#product-add-brand').parent().next().html('');
    }

    if (prCate === 0 || prCate == '') {
        $('.cate-error-message').html('Vui lòng chọn Danh mục!');
        check = false;
    } else {
        $('.cate-error-message').html('');

    }

    if ($('.product-pr[style="display: none;"]').length == 0) {
        var prPrice = $('#product-add-price').val();

        if (prPrice === '') {
            $('#product-add-price').parent().next().html('Vui lòng nhập Giá sản phẩm!');
            check = false;
        } else if (!prPrice.match(/^\d+(?:[.,]\d+)*$/)) {
            $('#product-add-price').parent().next().html('Vui lòng nhập đúng định dạng!');
            check = false;
        } else {
            $('#product-add-price').parent().next().html('');
        }
    }

    if (prSlug === '') {
        $('#product-add-slug').next().html('Vui lòng nhập Slug!');
        check = false;
    } else {
        $('#product-add-slug').next().html('');

    }

    $(".upload-image-list .upload-image-item").each(function () {
        var row = $(this);
        var url = row.find(".show-image").attr('data-url');

        if (url === '') {
            row.css('border', '1px dashed red');
            row.children('.icon-adds').css('border', '1px dashed red');
            row.children('.icon-adds').html('<i class="fas fa-exclamation-triangle"></i>').css('color', 'red');

            check = false;
        } else {
            row.css('border', '1px dashed gray');
            row.children('.icon-adds').css('border', '1px dashed gray');
            row.children('.icon-adds').html('<i class="fas fa-plus"></i>').css('color', 'currentColor');
        }
    });

    if ($('.classification-details[style="display: block;"]').length == 1) {
        $(".classify-group .classify-item").each(function () {
            var row = $(this);
            var classify_name = row.find('.classify-name input').val();

            if (classify_name === '') {
                row.find('.classify-name input').next().html('Vui lòng không được để trống!');
                check = false;
            } else {

                //Ktra giá trị trùng
                var myarray3 = new Array();
                var count3 = $(".classify-item").length;

                for (i = 0; i < count3; i++) {
                    $(".classify-item .classify-name .invalid-feedback").eq(i).html("");
                    myarray3[i] = $(".classify-item .classify-name input").eq(i).val();
                }

                for (i = 0; i < count3; i++) {
                    for (j = 0; j < count3; j++) {
                        if (myarray3[i] == "") {
                            check = false;
                            $(".classify-item .classify-name .invalid-feedback").eq(i).html("Vui lòng không được để trống!");
                        }

                        if (i == j || myarray3[i] == "" || myarray3[j] == "") continue;

                        if (myarray3[i] == myarray3[j]) {
                            check = false;
                            $(".classify-item .classify-name .invalid-feedback").eq(i).html("Trùng lặp với tên nhóm phân loại " + (j + 1));
                        }
                    }
                    if (check) $(".classify-item .classify-name .invalid-feedback").eq(i).html("");
                }

                if (check) row.find('.classify-name input').next().html('');
            }

            row.find('.classify-box-list .classify-item2').each(function () {
                var row_child = $(this);
                var classify_name_child = row_child.find('input').val();

                if (classify_name_child === '') {
                    row_child.children('.invalid-feedback').html('Vui lòng không được để trống!');
                    check = false;
                } else {
                    //Ktra giá trị trùng
                    var myarray = new Array();
                    var count = $(".classify-item:first .classify-item2").length;

                    for (i = 0; i < count; i++) {
                        $(".classify-item:first .classify-box-list .invalid-feedback").eq(i).html("");
                        myarray[i] = $(".classify-item:first .classify-box-list input.attr-value-name").eq(i).val();
                    }

                    for (i = 0; i < count; i++) {
                        for (j = 0; j < count; j++) {
                            if (myarray[i] == "") {
                                check = false;
                                $(".classify-item:first .classify-box-list .invalid-feedback").eq(i).html("Vui lòng không được để trống!");
                            }

                            if (i == j || myarray[i] == "" || myarray[j] == "") continue;

                            if (myarray[i] == myarray[j]) {
                                check = false;
                                $(".classify-item:first .classify-box-list .invalid-feedback").eq(i).html("Trùng lặp với giá trị số " + (j + 1));
                            }
                        }
                        if (check) $(".classify-item:first .classify-box-list .invalid-feedback").eq(i).html("");
                    }

                    var myarray2 = new Array();
                    var count2 = $(".classify-item:nth-child(2) .classify-item2").length;

                    for (i = 0; i < count2; i++) {
                        $(".classify-item:nth-child(2) .classify-box-list .invalid-feedback").eq(i).html("");
                        myarray2[i] = $(".classify-item:nth-child(2) .classify-box-list input.attr-value-name").eq(i).val();
                    }

                    for (i = 0; i < count2; i++) {
                        for (j = 0; j < count2; j++) {
                            if (myarray2[i] == "") {
                                check = false;
                                $(".classify-item:nth-child(2) .classify-box-list .invalid-feedback").eq(i).html("Vui lòng không được để trống!");
                            }

                            if (i == j || myarray2[i] == "" || myarray2[j] == "") continue;

                            if (myarray2[i] == myarray2[j]) {
                                check = false;
                                $(".classify-item:nth-child(2) .classify-box-list .invalid-feedback").eq(i).html("Trùng lặp với giá trị số " + (j + 1));
                            }
                        }
                        if (check) $(".classify-item:nth-child(2) .classify-box-list .invalid-feedback").eq(i).html("");
                    }

                    if (check) {
                        row_child.children('.invalid-feedback').html('');
                    }

                }
            });
        });

        $(".classify-table tbody tr").each(function () {
            var row = $(this);

            var price = row.find("input[name='classify-price']").val();
            var sku = row.find("input[name='classify-sku']").val();

            if (price === '' || !price.match(/^\d+(?:[.,]\d+)*$/)) {
                row.find("input[name='classify-price']").css({ 'border-bottom': '2px solid red', 'border-radius': 'initial' });
                check = false;
            } else {
                row.find("input[name='classify-price']").css('border-bottom', 'none');
            }

            if (sku === '') {
                row.find("input[name='classify-sku']").css({ 'border-bottom': '2px solid red', 'border-radius': 'initial' });
                check = false;
            } else {
                row.find("input[name='classify-sku']").css('border-bottom', 'none');
            }
        });
    }

    return check;
}

function loadData(search, page, pageSize) {
    $.ajax({
        url: 'Product/loadData',
        type: 'GET',
        data: { search: search, page: page, pageSize: pageSize },
        dataType: 'json',
        success: function (res) {
            if (res.TotalItems > 0) {
                var data = res.proList;
                var html = '';
                var template = $('#pro-list').html();
                $.each(data, function (i, item) {
                    html += Mustache.render(template, {
                        ProId: item.id,
                        ProName: item.name,
                        Price: ProductPrice(item.price, item.priceMax, item.priceMin),
                        Image: item.image,
                        CateName: item.cateName,
                        ViewCount: item.viewCount,
                        Status: item.status ? '<div class="badge badge-glow badge-success">Hiện</div>' : '<div class="badge badge-glow badge-danger">Ẩn</div>'
                    });
                });
            }

            $('.pro-table tbody').html(html);
            Pagination(res.CurrentPage, res.NumberPage, res.PageSize);
        }
    })
}

function ProductPrice(price, priceMax, priceMin) {
    var p = "";
    var priceStr = price.toString();
    var priceMaxStr = priceMax.toString();
    var priceMinStr = priceMin.toString();
    if (price > 0) {
        p = priceStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    } else {
        if (priceMax == priceMin && priceMax > 0 && priceMin > 0) {
            p = priceMaxStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        } else if (priceMax == 0 && priceMin == 0 && price == 0) {
            p = "Liên hệ";
        } else {
            p = priceMinStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "~" + priceMaxStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
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
        render += `<li class="paginate_button page-item previous" ><a href="javascript:void(0);" onclick="NextPage(${curPage - 1},${pageSize})" class="page-link">&nbsp;</a></li>`;
    } else {
        render += `<li class="paginate_button page-item previous disabled" ><a href="javascript:void(0);" class="page-link">&nbsp;</a></li>`;
    }

    let dot = `<li class="paginate_button page-item"><a class="page-link" href="javascript:void(0);">...</a></li>`;
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
            prevTwoSide += `<li class="paginate_button page-item previous" ><a href="javascript:void(0);" onclick="NextPage(${curPage - 1},${pageSize})" class="page-link">&nbsp;</a></li>`;
        }

        renderTwoSide = prevTwoSide + renderPage(1, "", pageSize) + dot + renderTwoSide + dot + renderPage(totalPages, "", pageSize);

        if (curPage != totalPages) {
            renderTwoSide += `<li class="paginate_button page-item next" ><a href="javascript:void(0);" onclick="NextPage(${curPage + 1},${pageSize})" class="page-link">&nbsp;</a></li>`;
        }

        $('#product_paginate ul').html(renderTwoSide);
    } else {
        if (curPage != totalPages) {
            render += `<li class="paginate_button page-item next" ><a href="javascript:void(0);" onclick="NextPage(${curPage + 1},${pageSize})" class="page-link">&nbsp;</a></li>`;
        } else {
            render += `<li class="paginate_button page-item next disabled" ><a href="javascript:void(0);"  class="page-link">&nbsp;</a></li>`;
        }

        $('#product_paginate ul').html(render);
    }
}

function renderPage(index, active = "", pageSize) {
    return `<li class="paginate_button page-item ${active}">
        <a class="page-link" href="javascript:void(0);" onclick="NextPage(${index},${pageSize})">${index}</a>
    </li>`;
}

function NextPage(page, pageSize) {
    var txtSearch = $('#pro_search').val();

    loadData(txtSearch, page, pageSize);
}

function slugAuto(str) {
    // Chuyển hết sang chữ thường
    str = str.toLowerCase();

    // xóa dấu
    str = str.replace(/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/g, 'a');
    str = str.replace(/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/g, 'e');
    str = str.replace(/(ì|í|ị|ỉ|ĩ)/g, 'i');
    str = str.replace(/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/g, 'o');
    str = str.replace(/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/g, 'u');
    str = str.replace(/(ỳ|ý|ỵ|ỷ|ỹ)/g, 'y');
    str = str.replace(/(đ)/g, 'd');

    // Xóa ký tự đặc biệt
    str = str.replace(/([^0-9a-z-\s])/g, '');

    // Xóa khoảng trắng thay bằng ký tự -
    str = str.replace(/(\s+)/g, '-');

    // xóa phần dự - ở đầu
    str = str.replace(/^-+/g, '');

    // xóa phần dư - ở cuối
    str = str.replace(/-+$/g, '');

    // return
    return str;
};

$('#product-add-brand').keyup(function () {
    var param = $("#product-add-brand").val();
    $.ajax({
        url: 'AutocompleteBrand',
        type: 'POST',
        dataType: 'json',
        data: { brand: param },
        success: function (data) {
            var htmlList = '';
            $.each(data, function (i, item) {
                var nameToLower = item.brandName.toLowerCase();
                var uppercaseFirstLetter = nameToLower.charAt(0).toUpperCase() + nameToLower.slice(1);
                htmlList += '<li><a href="javascript:void(0)">' + uppercaseFirstLetter + '</a></li>';
            });

            if (param.length = 0 || param == '') {
                $('.product-brand-box').removeClass('active');
                $('.product-brand-autocom-box ul').html('');
            } else {
                if (data.length > 0) {
                    $('.product-brand-box').addClass('active');
                    $('.product-brand-autocom-box ul').html(htmlList);
                }
            }
        }
    });
});

$(document).on('click', '.product-brand-autocom-box ul li', function () {
    var data = $(this).find('a').html();

    $('#product-add-brand').val(data);
    $('.product-brand-box').removeClass('active');
});