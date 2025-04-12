import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/app/view/app.dart';
import 'package:juan_kite/app/view/app_layout_switcher.dart';

import '../../helpers/pump_app.dart';

void main() {
  group(App, () {
    testWidgets('renders $AppLayoutSwitcher', (tester) async {
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();
      expect(find.byType(AppLayoutSwitcher), findsOneWidget);
    });
  });
}
