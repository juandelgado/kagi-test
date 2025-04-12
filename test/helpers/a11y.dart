import 'package:flutter_test/flutter_test.dart';

extension A11Y on WidgetTester {
  // https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#testing-accessibility-on-mobile
  // NOTE: these are just basic accessibility checks, they won't ever replace
  // testing with real users!!
  Future<void> a11yCheck() async {
    final handle = ensureSemantics();
    await expectLater(this, meetsGuideline(androidTapTargetGuideline));
    await expectLater(this, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(this, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(this, meetsGuideline(textContrastGuideline));
    handle.dispose();
  }
}
