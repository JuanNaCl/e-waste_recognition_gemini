import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class CellScreen extends StatefulWidget {
  static const name = 'CellScreen';
  const CellScreen({super.key});

  @override
  State<CellScreen> createState() => _CellScreenState();
}

class _CellScreenState extends State<CellScreen> {
  //Initializes a new instance of the ApplianceScreen class
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.pilascolombia.com/puntos'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text('Pilas'),
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
