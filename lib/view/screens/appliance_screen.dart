import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApplianceScreen extends StatefulWidget {
  static const name = 'ApplianceScreen';
  const ApplianceScreen({super.key});

  @override
  State<ApplianceScreen> createState() => _ApplianceScreenState();
}

class _ApplianceScreenState extends State<ApplianceScreen> {
  //Initializes a new instance of the ApplianceScreen class
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.redverde.co'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: false,
        title: const Text('Electrodomésticos'),
      ),
      body:  Center(
        child: Expanded(
          child: WebViewWidget(
            controller: controller,
          )
        ),
      ),
    );
  }
}
