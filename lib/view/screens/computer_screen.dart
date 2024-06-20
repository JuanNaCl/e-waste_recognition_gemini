import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComputerScreen extends StatefulWidget {
  static const name = 'ComputerScreen';
  const ComputerScreen({super.key});

  @override
  State<ComputerScreen> createState() => _ComputerScreenState();
}

class _ComputerScreenState extends State<ComputerScreen> {

  //Initializes a new instance of the ApplianceScreen class
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://ecocomputo.com/puntos-de-recoleccion/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text('Computadores'),
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
