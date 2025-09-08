import 'package:flutter/foundation.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class ValidateCheck {
  static String? validateEmail({String? value}) {
    const pattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final kEmailValid = RegExp(pattern);
    bool isValid = kEmailValid.hasMatch(value.toString());
    if (value!.isEmpty) {
      return '\u26A0 ${'Yêu cầu nhập email'}';
    } else if (isValid == false) {
      return '\u26A0 ${"Địa chỉ email không hợp lệ"}';
    }
    return null;
  }

  static String? validateEmptyText({String? value, String? message, String? name}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Yêu cầu nhập $name';
    }
    return null;
  }

  static String? validatePhone({String? value, String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Yêu cầu nhập số điện thoại';
    }
    return null;
  }

  static String? validatePassword({String? value, String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Yêu cầu nhập mật khẩu';
    } else if (value.length < 8) {
      return 'Mật khẩu phải ít nhất 8 ký tự';
    }
    return null;
  }

  static String? validateConfirmPassword({String? value, String? password}) {
    if (value == null || value.isEmpty) {
      return 'Yêu cầu nhập lại mật khẩu';
    } else if (value != password) {
      return 'Xác nhận mật khẩu không khớp';
    }
    return null;
  }

  static String getValidPhone(String number, {bool withCountryCode = false}) {
    bool isValid = false;
    String phone = "";

    try {
      PhoneNumber phoneNumber = PhoneNumber.parse(number);
      isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      if (isValid) {
        phone = withCountryCode ? "+${phoneNumber.countryCode}${phoneNumber.nsn}" : phoneNumber.nsn.toString();
        if (kDebugMode) {
          print("Phone Number : $phone");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return phone;
  }
}
