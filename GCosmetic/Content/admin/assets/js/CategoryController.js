$('#main-menu-navigation > li').removeClass('active');
$('#main-menu-navigation > li:eq(1)').addClass('sidebar-group-active');
$('#main-menu-navigation .has-sub ul li:eq(0)').addClass('active');

loadData("", null, null);
$('#category-search').keyup(function () {
    var txtSearch = $('#category-search').val();
    $('.category_table tbody').html('');
    loadData(txtSearch, null, null);
});

$('#category-name').keyup(function () {
    var name = $('#category-name').val();

    $('#category-slug').val(slugAuto(name));
});

$(document).on('click', '#btn-add-category', function () {
    var CateName = $('#category-name').val();
    var CateSlug = $('#category-slug').val();
    var CateId = $('#category-id').val();
    var model = {
        name: CateName,
        slug: CateSlug,
        id: CateId
    };

    if (Validate()) {
        AddCategory(model);
    }

});

$(document).on('click', '.category-delete', function () {
    var id = Number($(this).data('id'));

    DeleteCategory(id);
});

$(document).on('click', '.category-edit', function () {
    var id = Number($(this).data('id'));

    GetDataById(id);
});

function loadData(search, page, pageSize) {
    $.ajax({
        url: 'Category/loadData',
        type: 'GET',
        data: { search: search, page: page, pageSize: pageSize },
        dataType: 'json',
        success: function (res) {
            if (res.TotalItems > 0) {
                var data = res.proList;
                var html = '';
                var template = $('#category-list').html();
                $.each(data, function (i, item) {
                    html += Mustache.render(template, {
                        CateId: item.id,
                        CateName: item.name,
                        Slug: item.slug
                    });
                });
            }

            $('.category_table tbody').html(html);
            Pagination(res.CurrentPage, res.NumberPage, res.PageSize);
        }
    })
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

        $('#category-navigation nav ul').html(renderTwoSide);
    } else {
        if (curPage != totalPages) {
            render += `<li class="paginate_button page-item next" ><a href="javascript:void(0);" onclick="NextPage(${curPage + 1},${pageSize})" class="page-link">&nbsp;</a></li>`;
        } else {
            render += `<li class="paginate_button page-item next disabled" ><a href="javascript:void(0);"  class="page-link">&nbsp;</a></li>`;
        }

        $('#category-navigation nav ul').html(render);
    }
}

function renderPage(index, active = "", pageSize) {
    return `<li class="paginate_button page-item ${active}">
        <a class="page-link" href="javascript:void(0);" onclick="NextPage(${index},${pageSize})">${index}</a>
    </li>`;
}

function NextPage(page, pageSize) {
    var txtSearch = $('#category-search').val();

    loadData(txtSearch, page, pageSize);
}

function AddCategory(model) {
    $.ajax({
        url: 'Category/Create',
        type: 'POST',
        data: model,
        success: function (res) {
            if (res.success && !res.edit) {
                toastr.success('Thêm mới thành công!', 'Success!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            } else if (!res.success && !res.edit) {
                toastr.error('Tên danh mục đã tồn tại!', 'Error!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            }

            if (res.success && res.edit) {
                toastr.success('Cập nhật thành công!', 'Success!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            } else if (!res.success && res.edit) {
                toastr.error('Tên danh mục đã tồn tại!', 'Error!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            }
            $('#category-id').val(0);
            loadData("", null, null);
        }
    });
}

function DeleteCategory(id) {
    $.ajax({
        url: 'Category/Delete',
        type: 'POST',
        data: { id: id },
        success: function (res) {
            if (res.success) {
                loadData("", null, null);

                $('#category-id').val(0);
                $('#category-name').val('');
                $('#category-slug').val('');

                toastr.success('Xóa thành công!', 'Success!', {
                    closeButton: true,
                    tapToDismiss: false
                });

            } else {
                toastr.error('Danh mục đang chứa sản phẩm!', 'Error!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            }
        }
    });
}

function Validate() {
    var check = false;
    var CateName = $('#category-name').val();
    var CateSlug = $('#category-slug').val();

    if (CateName === '') {
        $('#category-name').parent().next().html('Vui lòng nhập tên!');
        check = false;
    } else {
        $('#category-name').parent().next().html('');
        check = true;
    }

    if (CateSlug === '') {
        $('#category-slug').parent().next().html('Vui lòng nhập Slug!');
        check = false;
    } else {
        $('#category-slug').parent().next().html('');
        check = true;
    }

    return check;
}

function GetDataById(_id) {
    $.ajax({
        url: 'Category/GetById',
        type: 'GET',
        data: { id: _id },
        success: function (res) {

            $('#category-id').val(res.id);
            $('#category-name').val(res.name);
            $('#category-slug').val(res.slug);

        }
    });
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