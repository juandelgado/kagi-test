import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/model/category_content.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/widgets/category/category_loaded_widget.dart';

import '../../helpers/a11y.dart';
import '../../helpers/pump_app.dart';

void main() {
  group(CategoryLoadedWidget, () {
    testWidgets('renders expected $ClusterListItem', (tester) async {
      await tester.pumpApp(
        CategoryLoadedWidget(
          title: 'hola',
          content: _mockContent,
          onArticleSelected: (value) {},
        ),
      );

      expect(find.text('hola'), findsOne);

      final clusterWidget = find.byType(ClusterListItem);
      expect(clusterWidget, findsOne);

      expect(
        find.descendant(
          of: clusterWidget,
          matching: find.text(_mockContent.clusters.first.title),
        ),
        findsOne,
      );

      await tester.a11yCheck();
    });

    testWidgets('article selected is called on tap', (tester) async {
      Cluster? selectedArticle;

      await tester.pumpApp(
        CategoryLoadedWidget(
          title: 'hola',
          content: _mockContent,
          onArticleSelected: (article) => selectedArticle = article,
        ),
      );

      await tester.tap(find.byType(ClusterListItem).first);
      expect(selectedArticle, _mockContent.clusters.first);

      await tester.a11yCheck();
    });
  });
}

final _mockContent = CategoryContent(
  timestamp: 12345,
  read: 54321,
  clusters: [
    Cluster(
      title: 'another cluster',
      shortSummary: 'another short summary',
      talkingPoints: [],
      perspectives: [],
      timeline: [],
      articles: [],
    ),
  ],
);
