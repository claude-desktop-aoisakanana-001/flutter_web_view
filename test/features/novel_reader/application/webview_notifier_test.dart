import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/features/novel_reader/application/webview_notifier.dart';

void main() {
  group('WebViewNotifier', () {
    test('initial state is correct', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(webViewNotifierProvider);

      expect(state.currentUrl, '');
      expect(state.isLoading, false);
      expect(state.canGoBack, false);
      expect(state.canGoForward, false);
      expect(state.pageTitle, null);
    });

    test('onPageStarted updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.onPageStarted('https://syosetu.com/');

      final state = container.read(webViewNotifierProvider);
      expect(state.currentUrl, 'https://syosetu.com/');
      expect(state.isLoading, true);
    });

    test('onPageFinished updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.onPageStarted('https://syosetu.com/');
      notifier.onPageFinished('https://syosetu.com/');

      final state = container.read(webViewNotifierProvider);
      expect(state.currentUrl, 'https://syosetu.com/');
      expect(state.isLoading, false);
    });

    test('updateNavigationState updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.updateNavigationState(canGoBack: true, canGoForward: false);

      final state = container.read(webViewNotifierProvider);
      expect(state.canGoBack, true);
      expect(state.canGoForward, false);
    });

    test('onError updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.onPageStarted('https://syosetu.com/');
      notifier.onError('Network error');

      final state = container.read(webViewNotifierProvider);
      expect(state.isLoading, false);
    });

    test('updatePageTitle updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.updatePageTitle('小説家になろう');

      final state = container.read(webViewNotifierProvider);
      expect(state.pageTitle, '小説家になろう');
    });
  });
}
