import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../provider/generate_content_provider.dart';

class PickImageScreen extends StatefulWidget {
  static const name = 'PickImageScreen';
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final Map<String, dynamic> _response = {
    '1': 'baterias para carro',
    '2': 'electrodomesticos',
    '3': 'pilas',
    '4': 'computadores o accesorios relacionados',
    '5': 'un elemento que no entra en ninguna de las categorias de e-waste',
  };
  final Map<String, dynamic> _routes = {
    '1': '/battery',
    '2': '/appliance',
    '3': '/cell',
    '4': '/computer',
    '5': '/other',
  };

  File? _image;
  final picker = ImagePicker();
  static const prompt =
      'Te voy a enviar una imagen y debes decirme si la imagen enviada entra dentro de una de las siguientes categorias, "Baterias para carro" en ese caso respondeme con un 1, "Electrodomesticos" en ese caso respondeme con un 2, "Pilas" en ese caso respondeme con un 3, "Computadores o accesorios relacionados" en ese caso respondeme con un 4 y si no entra en ninguno de esas categorias respondeme con un 5';
  // ignore: unused_field
  static const prompt2 =
      'Te voy a enviar una imagen y debes decirme si la imagen enviada entra dentro de una de las siguientes categorias, "Baterias para carro" en ese caso respondeme con un "Baterias carro", "Electrodomesticos" en ese caso respondeme con solo "Electrodomesticos", "Pilas" en ese caso respondeme con solo con un "Pilas", "Computadores o accesorios relacionados" en ese caso respondeme con un Partes de "computadores" y si no entra en ninguno de esas categorias respondeme con un "imagen no relacionada con e-waste"';
  GenerateContentProvider? generateContentProvider;
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      },
    );
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    generateContentProvider = GenerateContentProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    generateContentProvider = GenerateContentProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.5,
              //padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: getImageFromGallery,
                child: const Text('Seleccionar imagen'),
              ),
            ),
            Container(
              width: size.width * 0.5,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: getImageFromCamera,
                child: const Text('Tomar foto'),
              ),
            ),
            if (_image != null) ...[
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.file(
                    _image!,
                    fit: BoxFit.contain,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: FutureBuilder(
                    future: generateContentProvider!.describirImagen(prompt,
                        _image == null ? './images/lior.jpeg' : _image!.path),
                    builder: (context, respuestaAsync) {
                      if (respuestaAsync.connectionState ==
                          ConnectionState.done) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Text(
                                    textAlign: TextAlign.center,
                                    "Se ha detectado ${_response[respuestaAsync.data?.trim() ?? '5']} \n Deseas ver los puntos de reciclaje cercanos para este tipo de elemento?"),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print(respuestaAsync.data?.trim() ?? '5');
                                      context.push(
                                          '${_routes[respuestaAsync.data?.trim() ?? '5']}');
                                    },
                                    child: const Text('Ver puntos de reciclaje'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
