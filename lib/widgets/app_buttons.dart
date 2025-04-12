import 'package:flutter/material.dart';
import 'package:juan_kite/widgets/semantics/semantic_button.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.hint,
    required this.child,
    this.onPressed,
    this.style,
    this.liveRegion = false,
    super.key,
  });

  final String hint;
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool liveRegion;

  @override
  Widget build(BuildContext context) {
    return SemanticButton(
      hint: hint,
      liveRegion: liveRegion,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}

class PrimaryTextButton extends PrimaryButton {
  PrimaryTextButton({
    required String text,
    required super.hint,
    super.onPressed,
    super.style,
    super.key,
    super.liveRegion,
  }) : super(
          child: Text(text),
        );
}
