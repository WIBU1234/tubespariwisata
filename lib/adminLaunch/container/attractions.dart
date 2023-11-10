// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
// IMPORT LIB FROM FUNCTION
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class AttractionContainer extends StatefulWidget {
  const AttractionContainer({Key? key}) : super(key: key);

  @override
  State<AttractionContainer> createState() => _AttractionContainerState();
}

class _AttractionContainerState extends State<AttractionContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: 280,
                    height: 500,
                    color: Colors.black,
                  ),
            
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {
                          addDestination(context);
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            

          ),
        ),
      ),
    );
  }
}