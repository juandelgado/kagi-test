import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/wide/view/wide_screen_page.dart';
import 'package:juan_kite/layouts/wide/wide_screen_layout.dart';

import '../../helpers/a11y.dart';
import '../../helpers/pump_app.dart';

void main() {
  group(WideScreenLayout, () {
    testWidgets('renders $WideScreenPage', (tester) async {
      await tester.binding.setSurfaceSize(_wideSize);

      await tester.pumpApp(
        WideScreenLayout(
          constrains: BoxConstraints(
            maxWidth: _wideSize.width,
            maxHeight: _wideSize.height,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(WideScreenPage), findsOneWidget);
      await tester.a11yCheck();
    });
  });
}

const _wideSize = Size(1200, 900);
