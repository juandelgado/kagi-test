import 'package:flutter/material.dart';
import 'package:juan_kite/layouts/narrow/narrow_screen_layout.dart';
import 'package:juan_kite/layouts/wide/wide_screen_layout.dart';

class AppLayoutSwitcher extends StatelessWidget {
  const AppLayoutSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth > 600
            ? WideScreenLayout(
                constrains: constraints,
              )
            : const NarrowScreenLayout();
      },
    );
  }
}
