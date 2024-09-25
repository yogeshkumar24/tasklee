import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasklee/core/core.dart';

class AppToast {
  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.successColor,
    );
  }

  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.errorColor,
    );
  }
}
