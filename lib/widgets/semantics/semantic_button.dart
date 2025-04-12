import 'package:flutter/material.dart';

class SemanticButton extends StatelessWidget {
  const SemanticButton({
    required this.child,
    required this.hint,
    this.liveRegion = false,
    super.key,
  });

  final Widget child;
  final String hint;
  final bool liveRegion;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: liveRegion,
      button: true,
      hint: hint,
      child: ExcludeSemantics(
        child: child,
      ),
    );
  }
}
