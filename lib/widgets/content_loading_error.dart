import 'package:flutter/material.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/app_buttons.dart';
import 'package:juan_kite/widgets/semantics/semantic_widget.dart';

class ContentLoadingErrorWidget extends StatelessWidget {
  const ContentLoadingErrorWidget({
    required this.retryOnPressed,
    this.backOnPressed,
    super.key,
  });

  final VoidCallback retryOnPressed;
  final VoidCallback? backOnPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;

    final options = <Widget>[];

    if (backOnPressed != null) {
      options.add(
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: PrimaryTextButton(
            text: l10n.errorBack,
            hint: l10n.errorBack,
            onPressed: backOnPressed,
          ),
        ),
      );
    }

    options.add(
      PrimaryTextButton(
        text: l10n.errorRetry,
        hint: l10n.errorRetry,
        onPressed: retryOnPressed,
      ),
    );

    return SemanticWidget(
      value: l10n.contentLoadingError,
      isLiveRegion: true,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              color: colorScheme.surfaceContainerLow,
              size: AppSpacing.spaceUnit * 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: options,
            ),
          ],
        ),
      ),
    );
  }
}
