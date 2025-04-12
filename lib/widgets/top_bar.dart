import 'package:flutter/material.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/app_buttons.dart';
import 'package:juan_kite/widgets/semantics/semantic_widget.dart';

class TopBar extends StatelessWidget {
  const TopBar({this.title, this.displayBackButton = true, super.key});

  final String? title;
  final bool displayBackButton;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final children = <Widget>[];

    if (displayBackButton) {
      // this makes the icon grow or shrink
      // with user changes to font size in system settings
      final textScaler = MediaQuery.of(context).textScaler;

      children.add(
        PrimaryButton(
          hint: l10n.topBarGoBack,
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButtonTheme.of(context).style?.copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.only(left: AppSpacing.sm),
                ),
              ),
          child: Icon(
            Icons.arrow_back,
            size: textScaler.scale(AppSpacing.lg * 2),
          ),
        ),
      );
    }

    if (title != null) {
      children.add(
        Expanded(
          child: SemanticWidget(
            value: title!,
            child: ColoredBox(
              color: colorScheme.surfaceContainerLow,
              child: Padding(
                padding: AppSpacing.horizontalPaddingSm,
                child: Text(
                  title!,
                  style: textTheme.headlineLarge
                      ?.copyWith(color: colorScheme.primary),
                  textAlign: TextAlign.right,
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
