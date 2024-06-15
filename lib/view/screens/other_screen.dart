import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OtherScreen extends StatefulWidget {
  static const name = 'OtherScreen';
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {

  //Initializes a new instance of the ApplianceScreen class
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://visorgeo.ambientebogota.gov.co/?lon=-74.114887&lat=4.652107&z=14&l=5:1|31:1'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: false,
        title: const Text('Más opciones'),
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
