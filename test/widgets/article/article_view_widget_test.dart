import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/widgets/article/article_view_widget.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    ArticleView,
    () {
      testWidgets(
        'renders title',
        (tester) async {
          await tester.pumpApp(
            ArticleView(
              cluster: _emptyCluster,
            ),
          );
          await tester.pumpAndSettle();

          final titleWidget = find.byType(TitleWidget);
          expect(titleWidget, findsOne);

          expect(
            find.descendant(
              of: titleWidget,
              matching: find.text(_emptyCluster.title),
            ),
            findsOne,
          );

          await tester.a11yCheck();
        },
      );

      testWidgets(
        'renders summary',
        (tester) async {
          await tester.pumpApp(
            ArticleView(
              cluster: _emptyCluster,
            ),
          );
          await tester.pumpAndSettle();

          final summaryWidget = find.byType(SummaryWidget);
          expect(summaryWidget, findsOne);

          expect(
            find.descendant(
              of: summaryWidget,
              matching: find.text(_emptyCluster.shortSummary),
            ),
            findsOne,
          );

          await tester.a11yCheck();
        },
      );

      testWidgets(
        'does not render perspectives if there arent any',
        (tester) async {
          await tester.pumpApp(
            ArticleView(
              cluster: _emptyCluster,
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(PerspectiveWidget), findsNothing);
          await tester.a11yCheck();
        },
      );

      testWidgets(
        'renders perspectives if they are available',
        (tester) async {
          await tester.pumpApp(
            ArticleView(
              cluster: _clusterWithPerspective,
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(PerspectiveWidget), findsOne);
          await tester.a11yCheck();
        },
      );

      testWidgets(
        'does not render articles if not available',
        (tester) async {
          await tester.pumpApp(
            ArticleView(
              cluster: _emptyCluster,
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ArticleWidget), findsNothing);
          await tester.a11yCheck();
        },
      );

      testWidgets(
        'renders articles if available',
        (tester) async {
          await tester.pumpApp(
            ArticleView(
              cluster: _clusterWithArticle,
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ArticleWidget), findsOne);
          await tester.a11yCheck();
        },
      );
    },
  );

  group(ImageWidget, () {
    testWidgets(
      'does not render an image if there is none in the articles',
      (tester) async {
        await tester.pumpApp(
          ImageWidget(
            articles: _emptyCluster.articles,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(CachedNetworkImage), findsNothing);
        await tester.a11yCheck();
      },
    );

    testWidgets(
      'renders an image if there is one in the articles',
      (tester) async {
        await tester.pumpApp(
          ImageWidget(
            articles: _clusterWithImage.articles,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(CachedNetworkImage), findsExactly(1));
        await tester.a11yCheck();
      },
      skip:
          true, // see https://github.com/Baseflow/flutter_cache_manager/issues/467
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

final _clusterWithPerspective = Cluster(
  title: 'with perspectives',
  shortSummary: 'another short summary',
  talkingPoints: [],
  perspectives: [Perspective([], text: 'some perspective')],
  timeline: [],
  articles: [],
);

final _clusterWithArticle = Cluster(
  title: 'with article',
  shortSummary: 'another short summary',
  talkingPoints: [],
  perspectives: [],
  timeline: [],
  articles: [
    Article(
      title: 'title',
      link: 'link',
      domain: 'domain',
      date: 'date',
      image: '',
      imageCaption: '',
    ),
  ],
);

final _clusterWithImage = Cluster(
  title: 'with image',
  shortSummary: 'another short summary',
  talkingPoints: [],
  perspectives: [],
  timeline: [],
  articles: [
    Article(
      title: 'title',
      link: 'link',
      domain: 'domain',
      date: 'date',
      image: 'https://http.cat/images/200.jpg',
      imageCaption: 'imageCaption',
    ),
  ],
);
