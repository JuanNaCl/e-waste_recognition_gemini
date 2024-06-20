import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
  bool _isImageLoaded = false;
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'E-waste Classifier',
          style: GoogleFonts.mPlusRounded1c(
              fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: GoogleFonts.mPlusRounded1c(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Baterías', style: GoogleFonts.mPlusRounded1c()),
              onTap: () {
                context.push('/battery');
              },
            ),
            ListTile(
              title: Text('Electrodomésticos',
                  style: GoogleFonts.mPlusRounded1c()),
              onTap: () {
                context.push('/appliance');
              },
            ),
            ListTile(
              title: Text('Pilas', style: GoogleFonts.mPlusRounded1c()),
              onTap: () {
                context.push('/cell');
              },
            ),
            ListTile(
              title: Text('Computadores', style: GoogleFonts.mPlusRounded1c()),
              onTap: () {
                context.push('/computer');
              },
            ),
            ListTile(
              title: Text('Otros', style: GoogleFonts.mPlusRounded1c()),
              onTap: () {
                context.push('/other');
              },
            ),
          ],
        ),
      ),              
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              if (_image != null) ...[
                SizedBox(
                  height: size.height * 0.4,
                  width: size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  height: size.height * 0.4,
                  width: size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/uploadImage.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Bienvenido a ',
                style: GoogleFonts.mPlusRounded1c(),
              ),
              Text(
                'E-waste Classifier',
                style: GoogleFonts.mPlusRounded1c(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: size.width * 0.8,
                //padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: FilledButton(
                    onPressed: () async {
                      await getImageFromGallery();
                      _image == null
                          ? QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: 'No has seleccionado ninguna imagen',
                            )
                          : _isImageLoaded = true;
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Seleccionar imagen',
                        style: GoogleFonts.mPlusRounded1c(color: Colors.white),
                      ),
                    )),
              ),
              Container(
                width: size.width * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: getImageFromCamera,
                  child: const ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Tomar foto'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                child: _isImageLoaded
                    ? FutureBuilder(
                        future: generateContentProvider!.describirImagen(
                            prompt,
                            _image == null
                                ? './images/lior.jpeg'
                                : _image!.path),
                        builder: (context, respuestaAsync) {
                          if (respuestaAsync.connectionState ==
                              ConnectionState.done) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Se ha detectado ${_response[respuestaAsync.data?.trim() ?? '5']} \n ¿Deseas ver los puntos de reciclaje cercanos para este tipo de elemento?",
                                      style: GoogleFonts.mPlusRounded1c(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print(respuestaAsync.data?.trim() ??
                                              '5');
                                          context.push(
                                              '${_routes[respuestaAsync.data?.trim() ?? '5']}');
                                        },
                                        child: const Text(
                                            'Ver puntos de reciclaje'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
