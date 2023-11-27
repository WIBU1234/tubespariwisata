import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';


class AttractionContainer extends StatefulWidget {
  const AttractionContainer({Key? key}) : super(key: key);

  @override
  State<AttractionContainer> createState() => _AttractionContainerState();
}

class _AttractionContainerState extends State<AttractionContainer> {
  List<Destinasi> destinations = [];

  @override
  void initState() {
    super.initState();
    _fetchDestinations();
  }

  Future<void> _fetchDestinations() async {
    try {
      var response = await ApiDestinasiHelper.getDestinations();

      List<Destinasi> fetchedDestinations = Destinasi.fromJsonList(json.decode(response.body));
      
      setState(() {
        destinations = fetchedDestinations;
      });

    } catch (e) {
      print("Error fetching destinations: $e");
    }
  }

  void _showDeleteConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this destination?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ApiDestinasiHelper.deleteDestination(id);

                _fetchDestinations();

                Navigator.of(context).pop(); 
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: ListTile(
                            title: Text(destinations[index].destinationName),
                            trailing: Text(destinations[index].destinationAddress),
                            subtitle: Text(destinations[index].destinationDescription),
                          ),
                          secondaryActions: [
                            IconSlideAction(
                              caption: 'Update',
                              color: Colors.transparent,
                              foregroundColor: Colors.black,
                              iconWidget: Icon(
                                Icons.update,
                                color: Colors.black, 
                              ),
                              onTap: () {
                                pushUpdateDestination(context, destinations[index].id.toString());
                              },
                            ),
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.transparent,
                              foregroundColor: Colors.black,
                              iconWidget: Icon(
                                Icons.delete,
                                color: Colors.black, 
                              ),
                              onTap: () {
                                _showDeleteConfirmationDialog(destinations[index].id.toString());
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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