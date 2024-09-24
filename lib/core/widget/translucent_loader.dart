import 'package:flutter/material.dart';

class TranslucentLoader extends StatelessWidget {
  final double backgroundColorOpacity;
  final double loaderSize;
  final Widget child;
  final bool enabled;

  const TranslucentLoader({
    super.key,
    required this.child,
    this.enabled = false,
    this.backgroundColorOpacity = 0.4,
    this.loaderSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (enabled)
          Stack(
            children: [
              ModalBarrier(
                color: Colors.black.withOpacity(backgroundColorOpacity),
                dismissible: false,
              ),
              Center(
                child: SizedBox(
                  width: loaderSize,
                  height: loaderSize,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
