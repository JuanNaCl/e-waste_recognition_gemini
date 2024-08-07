import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter/services.dart';

class GenerateContentProvider extends InheritedWidget {
  final GenerativeModel model;
  final GenerativeModel modelProvision;
  const GenerateContentProvider(
      {super.key,
      required super.child,
      required this.model,
      required this.modelProvision});

  static GenerateContentProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<GenerateContentProvider>()!;

  Future<String?> obtenerRespuestaGemini(String entradaDeTexto) async {
    final content = [Content.text(entradaDeTexto)];
    final response = await model.generateContent(content);
    return response.text;
  }

  Future<String?> comparadorDeImagenes(
      String entradaDeTexto, String pathImg1, String pathImg2) async {
    final img1Bytes = await rootBundle.load(pathImg1);
    final img2Bytes = await rootBundle.load(pathImg2);

    final img1Buffer = img1Bytes.buffer.asUint8List();
    final img2Buffer = img2Bytes.buffer.asUint8List();

    final imageParts = [
      DataPart('image/jpeg', img1Buffer),
      DataPart('image/jpeg', img2Buffer),
    ];

    final prompt = TextPart(entradaDeTexto);
    final response = await modelProvision.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    return Future.value(response.text);
  }

Future<String?> describirImagen(String entradaDeTexto, String pathImg) async {
  Uint8List imgBuffer;

  try {
    // Verifica si la ruta de la imagen es absoluta (comienza con '/')
    if (pathImg.startsWith('/')) {
      final imgFile = File(pathImg);
      imgBuffer = await imgFile.readAsBytes();
    } else {
      // Carga la imagen desde el bundle de recursos
      final imgBytes = await rootBundle.load(pathImg);
      imgBuffer = imgBytes.buffer.asUint8List();
    }

    final imageParts = [
      DataPart('image/jpeg', imgBuffer), // Asegúrate de que la imagen es JPEG
    ];

    final prompt = TextPart(entradaDeTexto);
    final response = await modelProvision.generateContent(
      [
        Content.multi([prompt, ...imageParts])
      ],
    );

    // Imprime la respuesta en la consola para debug
    print('Respuesta Gemini Vision: ${response.text}');

    return Future.value(response.text);
  } catch (e) {
    // Maneja cualquier excepción que ocurra
    print('Error al describir la imagen: ${e.toString()}');
    return null;
  }
}

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
