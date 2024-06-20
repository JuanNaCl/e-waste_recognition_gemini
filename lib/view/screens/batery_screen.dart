import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class BatteryScreen extends StatefulWidget {
  static const name = 'BatteryScreen';
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {

  //Initializes a new instance of the ApplianceScreen class
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.recoenergy.com.co/puntos-recoe/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text('Baterías'),
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
