part of '../screen.dart';

/// {@template AuthWebView}
/// A widget that wraps a webview used for the auth process.
/// {@endtemplate}
class _AuthWebview extends ConsumerStatefulWidget {
  /// Creates an auth webview.
  ///
  /// {@macro AuthWebView}
  ///
  /// This webview is used to visit the [authorizationEndpoint], which finally
  /// returns an endpoint wiht the sabe base URL as the [redirectBaseEndpoint].
  const _AuthWebview({
    Key? key,
    required this.authorizationEndpoint,
    required this.redirectBaseEndpoint,
  }) : super(key: key);

  /// The authorization endpoint to be visited to auth the app.
  final Uri authorizationEndpoint;

  /// The endpoint that holds the base URL for the final redirect endpoint that
  /// includes auth data.
  final Uri redirectBaseEndpoint;

  @override
  __AuthWebviewState createState() => __AuthWebviewState();
}

class __AuthWebviewState extends ConsumerState<_AuthWebview> {
  @override
  void initState() {
    super.initState();
    // Uses the Hybrid Composition based platform view to ensure a good keyboard
    // performance.
    //
    // Reference:
    // https://pub.dev/packages/webview_flutter#android-platform-views
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) => WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.authorizationEndpoint.toString(),
        onWebViewCreated: (controller) {
          // Clears cache and cookies data in order to start a completely new and
          // decoupled auth process.
          controller.clearCache();
          CookieManager().clearCookies();
        },
        navigationDelegate: (navReq) {
          final redirectBaseUrl = widget.redirectBaseEndpoint.toString();
          if (navReq.url.startsWith(redirectBaseUrl)) {
            // Returns the obtained redirect endpoint that holds auth data.
            ref.read(appRouterPod).pop(Uri.parse(navReq.url));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      );
}
