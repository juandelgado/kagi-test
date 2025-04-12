import 'package:flutter/material.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/widgets/semantics/semantic_widget.dart';

class ContentLoadingWidget extends StatelessWidget {
  const ContentLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SemanticWidget(
      value: l10n.contentLoading,
      isLiveRegion: true,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
