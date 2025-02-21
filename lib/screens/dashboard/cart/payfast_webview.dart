import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PayFastWebView extends StatefulWidget {
  final String url;
  final Function(String) onPaymentCompleted;

  const PayFastWebView({
    super.key,
    required this.url,
    required this.onPaymentCompleted,
  });

  @override
  PayFastWebViewState createState() => PayFastWebViewState();
}

class PayFastWebViewState extends State<PayFastWebView> {
  late InAppWebViewController webViewController;

  bool isLoading = true;
  bool hasError = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PayFast Payment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // body: InAppWebView(
      //   initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
      //   onWebViewCreated: (controller) {
      //     webViewController = controller;
      //   },
      //   onLoadStart: (controller, url) {},
      //   onLoadStop: (controller, url) {
      //     if (url != null) {
      //       String urlStr = url.toString();
      //       if (urlStr.contains("success")) {
      //         widget.onPaymentCompleted("success");
      //         Navigator.pop(context);
      //       } else if (urlStr.contains("cancel")) {
      //         widget.onPaymentCompleted("failed");
      //         Navigator.pop(context);
      //       }
      //     }
      //   },
      // ),
      body: Stack(
        children: [
          // WebView
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
                hasError = false;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });

              if (url != null) {
                String urlStr = url.toString();
                if (urlStr.contains("success")) {
                  widget.onPaymentCompleted("success");
                  Navigator.pop(context);
                } else if (urlStr.contains("cancel")) {
                  widget.onPaymentCompleted("failed");
                  Navigator.pop(context);
                }
              }
            },
            onLoadError: (controller, url, code, message) {
              setState(() {
                isLoading = false;
                hasError = true;
                errorMessage = message;
              });
            },
          ),

          // Loader
          if (isLoading)
            const Center(
              child: Loader(),
            ),

          // Error Message
          if (hasError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  const Text(
                    "Oops! Something went wrong.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        hasError = false;
                      });
                      webViewController.reload();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
