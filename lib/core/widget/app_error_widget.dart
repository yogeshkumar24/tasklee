import 'package:flutter/material.dart';
import 'package:tasklee/core/app_constants.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    this.errorMsg = AppConstants.defaultErrorMsg,
    super.key,
  });

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMsg),
    );
  }
}
