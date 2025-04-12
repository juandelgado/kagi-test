import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/widgets/content_loading_error.dart';

import '../helpers/a11y.dart';
import '../helpers/pump_app.dart';

void main() {
  group(ContentLoadingErrorWidget, () {
    testWidgets(
      'does not render back button if no callback is passed',
      (tester) async {
        await tester.pumpApp(
          ContentLoadingErrorWidget(
            retryOnPressed: () {},
          ),
        );

        expect(find.text('Back'), findsNothing);
        await tester.a11yCheck();
      },
    );

    testWidgets(
      'renders back button if callback is passed',
      (tester) async {
        await tester.pumpApp(
          ContentLoadingErrorWidget(
            backOnPressed: () {},
            retryOnPressed: () {},
          ),
        );

        expect(find.text('Back'), findsOne);
        await tester.a11yCheck();
      },
    );

    testWidgets(
      'back button callback is called on tap',
      (tester) async {
        var counter = 0;

        await tester.pumpApp(
          ContentLoadingErrorWidget(
            backOnPressed: () => counter++,
            retryOnPressed: () {},
          ),
        );

        await tester.tap(find.text('Back'));
        expect(counter, equals(1));
        await tester.a11yCheck();
      },
    );

    testWidgets(
      'renders retry button',
      (tester) async {
        await tester.pumpApp(
          ContentLoadingErrorWidget(
            retryOnPressed: () {},
          ),
        );

        expect(find.text('Retry'), findsOne);
        await tester.a11yCheck();
      },
    );

    testWidgets(
      'retry button callback is called on tap',
      (tester) async {
        var counter = 0;

        await tester.pumpApp(
          ContentLoadingErrorWidget(
            retryOnPressed: () => counter++,
          ),
        );

        await tester.tap(find.text('Retry'));
        expect(counter, equals(1));
        await tester.a11yCheck();
      },
    );
  });
}
