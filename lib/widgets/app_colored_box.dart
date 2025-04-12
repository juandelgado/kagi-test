import 'package:flutter/widgets.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/theme/app_spacing.dart';

class AppColoredBox extends StatelessWidget {
  const AppColoredBox({
    required this.child,
    this.insets = AppSpacing.horizontalPaddingSm,
    super.key,
  });

  final Widget child;
  final EdgeInsets insets;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return ColoredBox(
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: insets,
        child: child,
      ),
    );
  }
}
