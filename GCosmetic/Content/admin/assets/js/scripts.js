
$('.cancel-classify button').click(function (argument) {
    $('.classification-details').css('display', 'none');
    $('.classify-add').css('display', 'block');
    $('.product-pr').css('display', 'block');
});

$('#btn-addnew-classify').click(function (argument) {
    var numClassify = $('.classify-item').length;
    if (numClassify == 1) {
        $('.add-new-classify').css('display', 'none');
        $('.classify-list').find('.classify-table thead tr th:first').after('<th scope="col">Tên</th>');
        $('.classify-list').find('.classify-table tbody tr td:nth-of-type(1)').after('<td scope="row">Loại</td>');
    }

    if (numClassify == 0) {
        $('.classify-list').find('.classify-table thead tr th:first').before('<th scope="col">Tên</th>');
        $('.classify-list').find('.classify-table tbody tr td:nth-of-type(1)').before('<td rowspan="1" scope="rowgroup">Loại</td>');
    }
});

$('.classify-delete').click(function () {
    var numClassify = $('.classify-item').length;
    if (numClassify == 1) {
        $('.classify-add').css('display', 'block');
        $('.classification-details').css('display', 'none');
    } else {
        $('.add-new-classify').css('display', 'flex');
    }
});

$('.btn-add-classify').click(function (argument) {

    $('.classify-add').css('display', 'none');
    $('.product-pr').css('display', 'none');
    $('.classification-details').css('display', 'block');

    var numClassify = $('.classify-item').length;
    if (numClassify == 0) {
        $('.add-new-classify .col-form-label').html('<label for="first-name">Phân loại 1</label>');
    }

});

dragula([$('#card-drag-area')]);

$(document).on('change keyup', '.classify-item:first .classify-name input', function () {
    $('.classify-table thead > tr >th:first').text($(this).val());
});

$(document).on('change keyup', '.classify-item:nth-child(2) .classify-name input', function () {
    $('.classify-table thead > tr >th:nth-child(2)').text($(this).val());
});


$(document).on('click', '.classify-item:first .btn-add-classify-table', function () {

    var tbody = $('.classify-list').find('.classify-table tbody:last');
    if (tbody.length > 0) {
        var clone = tbody.clone();
        clone.find(':text').val('');
        tbody.after(clone);
    } else {
        var numRowSpan = $('.classify-item:nth-child(2) .classify-item2').length;
        $('.classify-list').find('.classify-table').append('<tbody> <tr><td rowspan="' + numRowSpan + '" scope="rowgroup">Loại</td><td ><input type="text" class="form-control form-control-sm" id="colFormLabelSm" placeholder="Nhập Giá" name="classify-price"></td><td ><input type="text" class="form-control form-control-sm" id="colFormLabelSm" placeholder="Nhập SKU" name="classify-sku"></td></tr> </tbody>');
    }

});


$('body').on('click', '.classify-item:nth-child(2) .btn-add-classify-table', function () {
    var numRowSpan = $('.classify-table tbody:first tr:first td:first').attr('rowspan');
    $('.classify-table tbody tr td[rowspan]').attr('rowspan', Number(numRowSpan) + 1);
    $('.classify-list').find('.classify-table tbody').append('<tr><td scope="row">Loại</td><td ><input type="text" class="form-control form-control-sm" id="colFormLabelSm" placeholder="Nhập Giá" name="classify-price"></td><td ><input type="text" class="form-control form-control-sm" id="colFormLabelSm" placeholder="Nhập SKU" name="classify-sku"></td></tr>');
});

$('body').on('click', '.classify-item .classify-delete', function (event) {
    var ndx = $(this).parent().parent().parent().index() + 1;
    $('.classify-table th', event.delegateTarget).remove(':nth-child(' + ndx + ')');
    $('.classify-table tbody tr:first-child td', event.delegateTarget).remove(':nth-child(' + ndx + ')');
    $('.classify-table tbody tr:not(:nth-child(1))').remove();
    $('.classify-table tbody tr td[rowspan]').attr('rowspan', 1);

    $('.classify-item:last .col-form-label').html('<label for="first-name">Phân loại 1</label>');
    $('.add-new-classify').css('display', 'flex');
});

$('body').on('click', '.classify-item:first .classify-box-list-item span', function () {
    var ndx = $(this).parent().parent().index() + 1;
    $('.classify-table tbody', event.delegateTarget).remove(':nth-child(' + ndx + ')');
});

$('body').on('click', '.classify-item:nth-child(2) .classify-box-list-item span', function () {
    var ndx = $(this).parent().parent().index();
    $('.classify-table tbody tr', event.delegateTarget).remove(':nth-child(' + ndx + ')');

    var numRowSpan = $('.classify-table tbody:first tr:first td:first').attr('rowspan');
    $('.classify-table tbody tr td[rowspan]').attr('rowspan', Number(numRowSpan) - 1);
});


$(document).on('change keyup', '.classify-item:first .classify-item2 input', function () {
    var ndx = $(this).parent().parent().index() + 1;
    $('.classify-table tbody:nth-child(' + ndx + ') tr td[rowspan]').text($(this).val());
});

$(document).on('change keyup', '.classify-item:nth-child(2) .classify-item2 input', function () {
    var ndx = $(this).parent().parent().index();
    $('.classify-table tbody tr:nth-child(' + ndx + ') td[scope="row"]').text($(this).val());
});

$('.tips-all-classify').click(function (argument) {
    var tip_Price = $('.tip-price input').val();
    var tip_sku = $('.tip-sku input').val();

    $('.classify-table tbody tr td input[name="classify-price"]').val(tip_Price);
    $('.classify-table tbody tr td input[name="classify-sku"]').val(tip_sku);
});


$(document).on('click', '.btn-change-status-product', function () {
    var thisBtn = $(this);
    var idpro = thisBtn.data('id');
    var pro = { id: idpro };

    if (idpro > 0) {
        $.ajax({
            url: 'Product/EditStatus',
            type: 'POST',
            data: pro,
            success: function (res) {
                if (res) {
                    var status = thisBtn.parents(":eq(2)").prev().children("div").html();
                    
                    if (status == 'Hiện') {
                        thisBtn.parents(":eq(2)").prev().html('<div class="badge badge-glow badge-danger">Ẩn</div>');
                    } else {
                        thisBtn.parents(":eq(2)").prev().html('<div class="badge badge-glow badge-success">Hiện</div>');
                    }
                }
                else {
                    toastr.error('Cập nhật thất bại!', 'Error!', {
                        closeButton: true,
                        tapToDismiss: false
                    });
                }
            }
        });
    }
});

$(document).on('click', '.btn-delete-product', function () {
    var thisBtn = $(this);
    var idpro = thisBtn.data('id');
    var pro = { id: idpro };

    if (idpro > 0) {
        $.ajax({
            url: 'Product/DeleteProduct',
            type: 'POST',
            data: pro,
            success: function (res) {
                if (res) {
                    thisBtn.parents(":eq(3)").remove();
                }
                else {
                    toastr.error('Xóa thất bại!', 'Error!', {
                        closeButton: true,
                        tapToDismiss: false
                    });
                }
            }
        });
    }
});
