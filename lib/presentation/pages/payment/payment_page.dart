import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:beliyuk/presentation/pages/payment/payment_failed_page.dart';
import 'package:beliyuk/presentation/pages/payment/payment_success_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (url.contains('status_code=202&transaction_status=deny')) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentFailedPage(),
                ),
                (_) => false,
              );
            }
            if (url.contains('status_code=200&transaction_status=settlement')) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentSuccessPage(),
                ),
                (_) => false,
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebViewWidget(controller: _webViewController!),
    );
  }
}
