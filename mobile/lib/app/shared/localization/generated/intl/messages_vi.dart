// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(time) => "Mã xác thực sẽ hết hạn sau ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "TDS": MessageLookupByLibrary.simpleMessage("TDS"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Đã có tài khoản?"),
        "backToLogin":
            MessageLookupByLibrary.simpleMessage("Quay lại đăng nhập"),
        "beforeLogout": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn đăng xuất?"),
        "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
        "chat": MessageLookupByLibrary.simpleMessage("Trò chuyện"),
        "clearForm": MessageLookupByLibrary.simpleMessage("Xóa"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "currentLocation":
            MessageLookupByLibrary.simpleMessage("Vị trí hiện tại"),
        "daysAgo": MessageLookupByLibrary.simpleMessage("ngày trước"),
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Chưa có tài khoản?"),
        "doubleTabToExit":
            MessageLookupByLibrary.simpleMessage("Nhấn lần nữa để thoát"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailInvalid":
            MessageLookupByLibrary.simpleMessage("Email không hợp lệ"),
        "emptyChat":
            MessageLookupByLibrary.simpleMessage("Không có trò chuyện nào"),
        "emptyMap": MessageLookupByLibrary.simpleMessage("Không có bản đồ nào"),
        "emptyNotification":
            MessageLookupByLibrary.simpleMessage("Không có thông báo nào"),
        "enterYourCode":
            MessageLookupByLibrary.simpleMessage("Nhập mã của bạn"),
        "enterYourEmail": MessageLookupByLibrary.simpleMessage("Email của bạn"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Mật khẩu của  bạn"),
        "enterYourPhone":
            MessageLookupByLibrary.simpleMessage("Số điện thoại của bạn"),
        "enterYourUsername":
            MessageLookupByLibrary.simpleMessage("Tên người dùng của bạn"),
        "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
        "expiredVerifyCode": m0,
        "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên?"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "hoursAgo": MessageLookupByLibrary.simpleMessage("giờ trước"),
        "info": MessageLookupByLibrary.simpleMessage("Thông tin"),
        "loading": MessageLookupByLibrary.simpleMessage("Đang tải..."),
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thất bại"),
        "loginSuccess":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thành công"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "map": MessageLookupByLibrary.simpleMessage("Bản đồ"),
        "me": MessageLookupByLibrary.simpleMessage("Cá nhân"),
        "minutesAgo": MessageLookupByLibrary.simpleMessage("phút trước"),
        "no": MessageLookupByLibrary.simpleMessage("Không"),
        "none": MessageLookupByLibrary.simpleMessage("Không có"),
        "notification": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "ok": MessageLookupByLibrary.simpleMessage("Đồng ý"),
        "pH": MessageLookupByLibrary.simpleMessage("pH"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwordInvalid":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không hợp lệ"),
        "passwordNotMatch":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không khớp"),
        "phone": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "phoneInvalid":
            MessageLookupByLibrary.simpleMessage("Số điện thoại không hợp lệ"),
        "register": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "registerNow": MessageLookupByLibrary.simpleMessage("Đăng ký ngay"),
        "rememberMe": MessageLookupByLibrary.simpleMessage("Lưu mật khẩu"),
        "required":
            MessageLookupByLibrary.simpleMessage("Trường này là bắt buộc"),
        "resentCode": MessageLookupByLibrary.simpleMessage("Gửi lại mã"),
        "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "searchLocation": MessageLookupByLibrary.simpleMessage("Tìm kiếm..."),
        "secondsAgo": MessageLookupByLibrary.simpleMessage("giây trước"),
        "signIn": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "signUp": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "somethingWentWrongAgain": MessageLookupByLibrary.simpleMessage(
            "Có lỗi xảy ra, vui lòng thử lại sau"),
        "success": MessageLookupByLibrary.simpleMessage("Thành công"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Thử lại"),
        "username": MessageLookupByLibrary.simpleMessage("Tên người dùng"),
        "verifyCode": MessageLookupByLibrary.simpleMessage("Xác thực mã"),
        "warning": MessageLookupByLibrary.simpleMessage("Cảnh báo"),
        "weHaveSentCodeTo": MessageLookupByLibrary.simpleMessage(
            "Chúng tôi đã gửi mã xác thực đến email của bạn \n"),
        "weeksAgo": MessageLookupByLibrary.simpleMessage("tuần trước"),
        "welcome": MessageLookupByLibrary.simpleMessage("Chào mừng!"),
        "yes": MessageLookupByLibrary.simpleMessage("Có")
      };
}
