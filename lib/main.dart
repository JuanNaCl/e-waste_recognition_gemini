
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:proyecto_reconocimiento/config/router/app_router.dart';
import 'provider/generate_content_provider.dart';

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GenerateContentProvider(
      model: configurarModelo(),
      modelProvision: configurarModeloVision(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}

GenerativeModel configurarModelo() {
  final apiKey = dotenv.env['API_KEY_GEMINI_PRO'];
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey!);
  return model;
}

GenerativeModel configurarModeloVision() {
  final apiKey = dotenv.env['API_KEY_GEMINI_PRO'];
  final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey!);
  return model;
}
