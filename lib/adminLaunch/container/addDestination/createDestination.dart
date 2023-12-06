// FLUTTER MATERIAL
import 'package:flutter/material.dart';
// FLUTTER FUNCTION PAGE
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
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

class CreatePage extends StatefulWidget {
  const CreatePage({Key? superKey}) : super(key: superKey);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
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
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      final Uint8List? compressedImage =
          await FlutterImageCompress.compressWithFile(
        pickedImage.path,
        minWidth: 256,
        minHeight: 256,
        quality: 60,
      );

      if (compressedImage != null) {
        final imageTemp = File(pickedImage.path)
          ..writeAsBytesSync(compressedImage);

        setState(() {
          image = imageTemp;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              padding: EdgeInsets.all(screenWidth * 0.055),
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
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.2,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Destination',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Enter input data below',
                              style: TextStyle(
                                fontSize: screenWidth * 0.047,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: image != null
                            ? Image.file(
                                image!,
                                width: screenWidth * 0.2,
                                height: screenHeight * 0.2,
                                fit: BoxFit.cover,
                              )
                            : InkWell(
                                onTap: () {
                                  image = null;
                                  pickImage();
                                },
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: screenWidth * 0.2,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      SizedBox(height: screenHeight * 0.026),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                              vertical: screenHeight * 0.016),
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
                        child: Text(
                          'Add Photo',
                          style: TextStyle(
                              fontSize: screenWidth * 0.048,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextFormField(
                          controller: controllerName,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city),
                            labelText: 'Destination Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Name must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
                      TextFormField(
                          controller: controllerAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_on),
                            labelText: 'Destination Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Address must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
                      TextFormField(
                          controller: controllerDescription,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.description),
                            labelText: 'Destination Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Description must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Latitude must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Longitude must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
                      TextFormField(
                          controller: controllerCategory,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.catching_pokemon),
                            labelText: 'Destination Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Category must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controllerRating,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.star),
                            labelText: 'Destination Rating',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.022),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Destination Rating must be filled';
                            }
                            return null;
                          }),
                      SizedBox(height: screenHeight * 0.025),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.024),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle validation errors

                            ApiDestinasiHelper.createDestinasi(
                              destinationName: controllerName.text,
                              alamatDestinasi: controllerAddress.text,
                              deskripsiDestinasi: controllerDescription.text,
                              latitude: double.parse(controllerLatitude.text),
                              longitude: double.parse(controllerLongitude.text),
                              imageFoto: base64string!,
                              destinationCategory: controllerCategory.text,
                              rating: int.parse(controllerRating.text),
                            );
                            popperToRoot(context);
                            pushAdminHomePage(context);

                          } else {
                            ApiDestinasiHelper.createDestinasi(
                              destinationName: controllerName.text,
                              alamatDestinasi: controllerAddress.text,
                              deskripsiDestinasi: controllerDescription.text,
                              latitude: double.parse(controllerLatitude.text),
                              longitude: double.parse(controllerLongitude.text),
                              imageFoto: base64string!,
                              destinationCategory: controllerCategory.text,
                              rating: int.parse(controllerRating.text),
                            );
                            popperToRoot(context);
                            pushAdminHomePage(context);
                          }
                        },
                        child: Text(
                          'Create Destination',
                          style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
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
