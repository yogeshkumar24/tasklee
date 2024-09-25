import 'package:flutter/material.dart';
import 'package:tasklee/core/constant/app_constants.dart';
import 'package:tasklee/core/core.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    this.errorMsg = AppText.defaultErrorMsg,
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
