import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/html_parser/domain/models/parsed_novel.dart';

void main() {
  group('ParsedNovel', () {
    test('should create ParsedNovel with required fields', () {
      // Arrange & Act
      const novel = ParsedNovel(
        title: 'テスト小説',
        author: 'テスト作者',
        paragraphs: [
          '第一段落のテキスト。',
          '第二段落のテキスト。',
        ],
      );

      // Assert
      expect(novel.title, 'テスト小説');
      expect(novel.author, 'テスト作者');
      expect(novel.paragraphs.length, 2);
      expect(novel.paragraphs[0], '第一段落のテキスト。');
      expect(novel.metadata, isNull);
    });

    test('should create ParsedNovel with metadata', () {
      // Arrange & Act
      const novel = ParsedNovel(
        title: 'テスト小説',
        author: 'テスト作者',
        paragraphs: ['本文'],
        metadata: {
          'preface': '前書き',
          'postscript': '後書き',
          'subtitle': '第一章',
        },
      );

      // Assert
      expect(novel.metadata, isNotNull);
      expect(novel.metadata!['preface'], '前書き');
      expect(novel.metadata!['postscript'], '後書き');
      expect(novel.metadata!['subtitle'], '第一章');
    });

    test('should support copyWith', () {
      // Arrange
      const original = ParsedNovel(
        title: 'Original Title',
        author: 'Original Author',
        paragraphs: ['paragraph 1'],
      );

      // Act
      final updated = original.copyWith(
        title: 'Updated Title',
        paragraphs: ['paragraph 1', 'paragraph 2'],
      );

      // Assert
      expect(updated.title, 'Updated Title');
      expect(updated.author, 'Original Author'); // 変更されていない
      expect(updated.paragraphs.length, 2);
    });

    test('should support equality comparison', () {
      // Arrange
      const novel1 = ParsedNovel(
        title: 'Test',
        author: 'Author',
        paragraphs: ['p1', 'p2'],
      );

      const novel2 = ParsedNovel(
        title: 'Test',
        author: 'Author',
        paragraphs: ['p1', 'p2'],
      );

      const novel3 = ParsedNovel(
        title: 'Different',
        author: 'Author',
        paragraphs: ['p1', 'p2'],
      );

      // Assert
      expect(novel1, equals(novel2));
      expect(novel1, isNot(equals(novel3)));
    });
  });
}
