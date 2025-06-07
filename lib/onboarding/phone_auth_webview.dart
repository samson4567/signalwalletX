import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PhoneAuthWebview extends StatefulWidget {
  final String registrationUrl;
  final String successRedirectUrl;
  final Function(BuildContext context) onfinished;

  const PhoneAuthWebview({
    Key? key,
    required this.registrationUrl,
    required this.successRedirectUrl,
    required this.onfinished,
  }) : super(key: key);

  @override
  State<PhoneAuthWebview> createState() => _PhoneAuthWebviewState();
}

class _PhoneAuthWebviewState extends State<PhoneAuthWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {

    // }
    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can add a loading indicator here if you want
            debugPrint('WebView is loading (progress: $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onUrlChange: (change) {
            print("asjdksadakdahdkadh-onUrlChange-url_is${change.url}");
            if (change.url?.contains(widget.successRedirectUrl) ?? false) {
              debugPrint('Blocking navigation to ${change.url}');
              // This is our success URL, so we'll close the WebView
              // and potentially navigate to a success screen in the app.
              widget.onfinished.call(context);
            }
            debugPrint('Allowing navigation to ${change.url}');
          },
          onNavigationRequest: (NavigationRequest request) {
            print(
                "asjdksadakdahdkadh-onNavigationRequest-url_is${request.url}");
            if (request.url.contains(widget.successRedirectUrl)) {
              debugPrint('Blocking navigation to ${request.url}');
              // This is our success URL, so we'll close the WebView
              // and potentially navigate to a success screen in the app.
              widget.onfinished.call(context);

              return NavigationDecision
                  .prevent; // Prevent the WebView from loading this URL
            }
            debugPrint('Allowing navigation to ${request.url}');
            return NavigationDecision.navigate; // Allow other navigations
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.registrationUrl));

    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setTextZoom(100); // Optional: Adjust text zoom
    // }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () =>
              Navigator.of(context).pop(), // Allow users to close the WebView
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
