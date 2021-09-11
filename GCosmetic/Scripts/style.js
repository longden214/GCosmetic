
$('.subscribe-box button').click(function () {
    var email = ValidateEmail();

    $.ajax({
        url: '/Home/SendRegisterEmail',
        type: 'Post',
        data: { emailID: email },
        dataType: 'json',
        success: function (res) {
            if (res) {
                toastr["success"]("Đăng ký nhận tin thành công", "Success", {
                    closeButton: true,
                    progressBar: true
                });
            } else {
                toastr["error"]("Đăng ký nhận tin không thành công", "Error", {
                    closeButton: true,
                    progressBar: true
                });
            }

            $('#subscribe_email').val("");
        }
    });
});

function ValidateEmail() {
    var _email = $('#subscribe_email').val();

    var check = "";
    if (_email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)) {
        check = _email;
    }

    return check;
}