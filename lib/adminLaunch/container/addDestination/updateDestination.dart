// FLUTTER MATERIAL
import 'package:flutter/material.dart';
// FLUTTER FUNCTION PAGE
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
// import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';
import 'dart:convert';
// FLUTTER PAGE LAUNCHER
// FIREBASE FUNCTION
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/invoice/model/product.dart';
import 'package:tubespariwisata/pdf/pdf_view.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// MODEL IMPORTER
// import 'package:tubespariwisata/entity/destinasi.dart';

class UpdatePageDestination extends StatefulWidget {
  const UpdatePageDestination({Key? superKey, required this.destinasi}) : super(key: superKey);

  final Destinasi destinasi;

  @override
  State<UpdatePageDestination> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePageDestination> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerLatitude = TextEditingController();
  TextEditingController controllerLongitude = TextEditingController();
  TextEditingController controllerImage = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  TextEditingController controllerRating = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  String id = const Uuid().v1();
  File? image;
  String? base64string;

  List<Product> products = [
    Product("Action", 50000),
  ];

  @override
  void initState() {
    if (image != null) {
      converting(image!);
    } else {
      // print('Error: Image is null');
    }

    super.initState();
  }

  Future pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      final Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
        pickedImage.path,
        minWidth: 10,
        minHeight: 10,
        quality: 20,
      );

      if (compressedImage != null) {
        final imageTemp = File(pickedImage.path)..writeAsBytesSync(compressedImage);

        setState(() {
          this.image = imageTemp;
          base64string = compressedImage.toString();
          converting(imageTemp);
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image : $e');
    }
  }

  Future converting(File image) async {
    Uint8List imagebytes = await image.readAsBytes();
    base64string = base64.encode(imagebytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resources/images/bali.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              margin: const EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'resources/images/logo.png',
                        width: 150,
                        height: 150,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Destination',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Enter input data below',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: image != null
                            ? Image.file(
                                image!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              )
                            : InkWell(
                                onTap: () {
                                  image = null;
                                  pickImage();
                                },
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {
                          image = null;
                          
                          setState(() {
                            pickImage();
                            controllerImage.text = base64string!;
                          });
                        },
                        child: const Text(
                          'Add Photo',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: controllerName,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city),
                            labelText: 'Destination Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Name must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: controllerAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_on),
                            labelText: 'Destination Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Address must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: controllerDescription,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.description),
                            labelText: 'Destination Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Description must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controllerLatitude,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.format_list_numbered_outlined),
                            labelText: 'Destination Latitude',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Latitude must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controllerLongitude,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.format_list_numbered_outlined),
                            labelText: 'Destination Longitude',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Longitude must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: controllerCategory,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.catching_pokemon),
                            labelText: 'Destination Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Category must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controllerRating,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.star),
                            labelText: 'Destination Rating',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Rating must be filled';
                            }
                            return null;
                          }),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            // Handle validation errors
                          } else {
                            ApiDestinasiHelper.updateDestinasi(
                              id: widget.destinasi.id!,
                              destinationName: controllerName.text,
                              alamatDestinasi: controllerAddress.text,
                              deskripsiDestinasi: controllerDescription.text,
                              latitude: double.parse(controllerLatitude.text),
                              longitude: double.parse(controllerLongitude.text),
                              imageFoto: base64string!,
                              destinationCategory: controllerCategory.text,
                              rating: int.parse(controllerRating.text)
                            );
                            popperToRoot(context);
                            pushAdminHomePage(context);
                          }
                        },
                        child: const Text(
                          'Add Destination',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 28),
                      buttonCreatePDF(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buttonCreatePDF(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 28),
      child: ElevatedButton(
        onPressed: () {
          if (image == null ||
              controllerName.text.isEmpty ||
              controllerAddress.text.isEmpty ||
              controllerDescription.text.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Warning'),
                content: const Text("Please fill in all the field"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'),
                  )
                ],
              ),
            );
            return;
          } else {
            createPdf(controllerName, controllerDescription, controllerAddress,
                id, image!, context, products);
            setState(() {
              const uuid = Uuid();
              id = uuid.v1();
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }
}
