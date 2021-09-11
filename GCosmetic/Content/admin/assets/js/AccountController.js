$('#main-menu-navigation > li').removeClass('active');
$('#main-menu-navigation > li:eq(2)').addClass('active');

$(".btn-upload-avatar").click(function () {
    var finder = new CKFinder();
    finder.selectActionFunction = function (fileUrl) {
        $("#account-upload-avatar").val(fileUrl);
        $("#account-upload-img").attr("src", fileUrl);
    };
    finder.popup();
});

$(".btn-website-upload").click(function () {
    var finder = new CKFinder();
    finder.selectActionFunction = function (fileUrl) {
        $("#website-upload").val(fileUrl);
        $("#website-upload-img").attr("src", fileUrl);
    };
    finder.popup();
});

$(".btn-upload-favicon").click(function () {
    var finder = new CKFinder();
    finder.selectActionFunction = function (fileUrl) {
        $("#website-upload-favicon").val(fileUrl);
        $("#upload-favicon-img").attr("src", fileUrl);
    };
    finder.popup();
});

$(".btn-reset-avatar").click(function () {
    var img_old = "/Content/admin/app-assets/images/portrait/small/avatar-s-11.jpg";
    $("#account-upload-avatar").val(img_old);
    $("#account-upload-img").attr("src", img_old);
});

$(document).on('click', '.btn-save-account', function () {
    var _uname = $('#account_username').val();
    var _name = $('#account_name').val();
    var _avatar = $('#account-upload-avatar').val();
    var _email = $('#account_email').val();

    var model = {
        username: _uname,
        displayName: _name,
        avatar: _avatar,
        email: _email
    };

    if (ValidateAccount()) {
        editAccount(model);
    }

});

$(document).on('click', '.btn-website-save', function () {
    var configs = new Array();

    $(".config-item").each(function () {
        var config = {};

        config.id = $(this).find(".config-title").data("id");
        config.value = $(this).find(".config-title").val(); 
        config.status = $(this).find(".config-status").is(":checked");

        configs.push(config);
    });

    if ($("#website-upload").val() != "") {
        var config = {};

        config.id = $(".config-title-logo").data("id");
        config.value = $(".config-title-logo").val();
        config.status = true;

        configs.push(config);
    }

    if ($("#website-upload-favicon").val() != "") {
        var config = {};

        config.id = $(".config-title-favicon").data("id");
        config.value = $(".config-title-favicon").val();
        config.status = true;

        configs.push(config);
    }

    if (ValidateWebsiteConfig()) {
        editWebsite(configs);
    }

});

$(document).on('click', '.btn-change-password', function () {
    var _pw = $('#account-retype-new-password').val();

    var model = {
        password: _pw
    };

    if (ValidateAccountPassword()) {
        ChangePassword(model);
    }

});

function editAccount(model) {
    $.ajax({
        url: 'Account/EditAccount',
        type: 'POST',
        data: model,
        success: function (res) {
            if (res.success) {
                toastr.success('Cập nhật thành công!', 'Success!', {
                    closeButton: true,
                    tapToDismiss: false
                });

                $('#avatar_header').attr("src", res.avatar_src);
                $('.acc-displayName').html(res.displayName);
            } else{
                toastr.error('Cập nhật thất bại!', 'Error!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            }
        }
    });
}

function editWebsite(configs) {
    $.ajax({
        url: 'Account/EditWebsite',
        type: 'POST',
        data: JSON.stringify(configs),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (res) {
            if (res.success) {
                toastr.success('Cập nhật thành công!', 'Success!', {
                    closeButton: true,
                    tapToDismiss: false
                });

                $('#admin-logo').attr("src", res.adminLogo);
            } else {
                toastr.error('Cập nhật thất bại!', 'Error!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            }
        }
    });
}

function ValidateAccount() {
    var check = true;
    var _uname = $('#account_username').val();
    var _name = $('#account_name').val();
    var _email = $('#account_email').val();

    if (_uname === '') {
        $('#account_username').next().html('Vui lòng nhập UserName!');
        check = false;
    } else {
        $('#account_username').next().html('');
        
    }

    if (_name === '') {
        $('#account_name').next().html('Vui lòng nhập Name!');
        check = false;
    } else {
        $('#account_name').next().html('');
        
    }

    if (_email === '') {
        $('#account_email').next().html('Vui lòng nhập Email!');
        check = false;
    } else if (!_email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)) {
        $('#account_email').next().html('Vui lòng nhập đúng định dạng!');
        check = false;
    }else {
        $('#account_email').next().html('');
        
    }

    return check;
}

function ValidateWebsiteConfig() {
    var check = true;
    var _email = $('#website-Email').val();
    var _phone = $('#website-Phone').val();
    var _address = $('#website-Address').val();
    var _working = $('#website-Working').val();

    if (_address === '') {
        $('#website-Address').next().next().html('Vui lòng nhập địa chỉ!');
        check = false;
    } else {
        $('#website-Address').next().next().html('');
        
    }

    if (_working === '') {
        $('#website-Working').next().next().html('Vui lòng nhập giờ làm!');
        check = false;
    } else {
        $('#website-Working').next().next().html('');
        
    }

    if (_email === '') {
        $('#website-Email').next().next().html('Vui lòng nhập Email!');
        check = false;
    } else if (!_email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)) {
        $('#website-Email').next().next().html('Vui lòng nhập đúng định dạng!');
        check = false;
    } else {
        $('#website-Email').next().next().html('');
        
    }

    if (_phone === '') {
        $('#website-Phone').next().next().html('Vui lòng nhập số điện thoại!');
        check = false;
    } else if (!_phone.match(/^\d{10}$/)) {
        $('#website-Phone').next().next().html('Vui lòng nhập đúng định dạng!');
        check = false;
    } else {
        $('#website-Phone').next().next().html('');
        
    }

    return check;
}

function ChangePassword(model) {
    $.ajax({
        url: 'Account/ChangePassword',
        type: 'POST',
        data: model,
        success: function (res) {
            if (res.success) {
                toastr.success('Cập nhật thành công!', 'Success!', {
                    closeButton: true,
                    tapToDismiss: false
                });

                $('#account-old-password').val("");
                $('#account-new-password').val("");
                $('#account-retype-new-password').val("");
            } else {
                toastr.error('Cập nhật thất bại!', 'Error!', {
                    closeButton: true,
                    tapToDismiss: false
                });
            }
        }
    });
}

function ValidationPassword(pw) {
    var result = false;
    $.ajax({
        url: 'Account/ValidationPassword',
        type: 'POST',
        data: { pass: pw },
        async: false,
        success: function (res) {
            result = res.success
        }
    });

    return result;
}

function ValidateAccountPassword() {
    var check = true;
    
    var _oldPass = $('#account-old-password').val();
    var _newPass = $('#account-new-password').val();
    var _retypePass = $('#account-retype-new-password').val();

    if (_oldPass === '') {
        $('#account-old-password').parent().next().html('Vui lòng nhập mật khẩu cũ!');
        check = false;
    } else if (!ValidationPassword(_oldPass)) {
        $('#account-old-password').parent().next().html('Mật khẩu không chính xác!');
        check = false;
    }else {
        $('#account-old-password').parent().next().html('');
    }

    if (_newPass === '') {
        $('#account-new-password').parent().next().html('Vui lòng nhập mật khẩu mới!');
        check = false;
    } else if (!_newPass.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/)) {
        $('#account-new-password').parent().next().html('Mật khẩu ít nhất 8 ký tự và có ít nhất 1 chữ số, 1 chữ hoa và 1 chữ thường!');
        check = false;
    }else {
        $('#account-new-password').parent().next().html('');
    }

    if (_retypePass === '') {
        $('#account-retype-new-password').parent().next().html('Vui lòng nhập mật khẩu!');
        check = false;
    } else if (_retypePass != _newPass) {
        $('#account-retype-new-password').parent().next().html('Không khớp với mật khẩu mới!');
        check = false;
    } else {
        $('#account-retype-new-password').parent().next().html('');
       
    }

    return check;
}