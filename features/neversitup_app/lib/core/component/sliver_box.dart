import 'package:flutter/material.dart';

class SliverBox extends StatelessWidget {
  const SliverBox({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
  });

  final Widget child;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
