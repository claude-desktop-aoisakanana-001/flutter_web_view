import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/html_parser/application/narou_url_detector.dart';

void main() {
  group('NarouUrlDetector', () {
    group('isNovelPage', () {
      test('連載小説のURLを正しく検出する', () {
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/1/'),
          true,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/10/'),
          true,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n9876xy/123/'),
          true,
        );
      });

      test('連載小説のURL（末尾スラッシュなし）を正しく検出する', () {
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/1'),
          true,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/10'),
          true,
        );
      });

      test('短編小説のURLを正しく検出する', () {
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/'),
          true,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n9876xy/'),
          true,
        );
      });

      test('短編小説のURL（末尾スラッシュなし）を正しく検出する', () {
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab'),
          true,
        );
      });

      test('HTTP URLも正しく検出する', () {
        expect(
          NarouUrlDetector.isNovelPage('http://ncode.syosetu.com/n1234ab/1/'),
          true,
        );
        expect(
          NarouUrlDetector.isNovelPage('http://ncode.syosetu.com/n1234ab/'),
          true,
        );
      });

      test('非小説ページのURLを正しく判定する', () {
        expect(
          NarouUrlDetector.isNovelPage('https://syosetu.com/'),
          false,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/'),
          false,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://yomou.syosetu.com/'),
          false,
        );
        expect(
          NarouUrlDetector.isNovelPage('https://example.com/'),
          false,
        );
      });

      test('不正なURLを正しく判定する', () {
        expect(
          NarouUrlDetector.isNovelPage(''),
          false,
        );
        expect(
          NarouUrlDetector.isNovelPage('not-a-url'),
          false,
        );
      });
    });

    group('getPageType', () {
      test('連載小説のページタイプを正しく判定する', () {
        expect(
          NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab/1/'),
          NovelPageType.series,
        );
        expect(
          NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab/10/'),
          NovelPageType.series,
        );
        expect(
          NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab/1'),
          NovelPageType.series,
        );
      });

      test('短編小説のページタイプを正しく判定する', () {
        expect(
          NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab/'),
          NovelPageType.shortStory,
        );
        expect(
          NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab'),
          NovelPageType.shortStory,
        );
      });

      test('非小説ページの場合 null を返す', () {
        expect(
          NarouUrlDetector.getPageType('https://syosetu.com/'),
          null,
        );
        expect(
          NarouUrlDetector.getPageType('https://ncode.syosetu.com/'),
          null,
        );
        expect(
          NarouUrlDetector.getPageType('https://example.com/'),
          null,
        );
        expect(
          NarouUrlDetector.getPageType(''),
          null,
        );
      });
    });
  });
}
