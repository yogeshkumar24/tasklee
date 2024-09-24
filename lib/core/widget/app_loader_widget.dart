import 'package:flutter/material.dart';

class AppLoaderWidget extends StatelessWidget {
  const AppLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
