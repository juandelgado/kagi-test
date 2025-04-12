import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/narrow/article/view/article_page.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/widgets/article/article_view_widget.dart';

import '../../../../helpers/a11y.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  group(ArticlePage, () {
    testWidgets(
      'renders $ArticleView',
      (tester) async {
        await tester.pumpApp(
          ArticlePage(
            cluster: _emptyCluster,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(ArticleView), findsOneWidget);
        await tester.a11yCheck();
      },
    );
  });
}

final _emptyCluster = Cluster(
  title: 'empty',
  shortSummary: 'another short summary',
  talkingPoints: [],
  perspectives: [],
  timeline: [],
  articles: [],
);
