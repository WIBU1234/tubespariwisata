                                        // FutureBuilder<Destinasi>(
                                        //   future: ApiDestinasiHelper.getDestinasiById(book.idDestinasi),
                                        //   builder: (BuildContext context, AsyncSnapshot<Destinasi> snapshot) {
                                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                                        //       return const CircularProgressIndicator();
                                        //     } else if (snapshot.hasError) {
                                        //       return Text('Error: ${snapshot.error}');
                                        //     } else if (snapshot.hasData) {
                                        //       destinasiTemp = snapshot.data;

                                        //       return
                                        //       FutureBuilder<Ticket>(
                                        //         future: ApiTicketHelper.getTicketById(book.idTicket),
                                        //         builder: (BuildContext context, AsyncSnapshot<Ticket> snapshot) {
                                        //           if (snapshot.connectionState == ConnectionState.waiting) {
                                        //             return const CircularProgressIndicator();
                                        //           } else if (snapshot.hasError) {
                                        //             return Text('Error: ${snapshot.error}');
                                        //           } else if (snapshot.hasData) {
                                        //             ticketTemp = snapshot.data;

                                        //             return 
                                        //             Padding(
                                        //               padding: const EdgeInsets.only(left: 0, right: 0),
                                        //               child: Container(
                                        //                 width: 380,
                                        //                 decoration: BoxDecoration(
                                        //                   color: Colors.white,
                                        //                   borderRadius: BorderRadius.circular(10),
                                        //                   boxShadow: const [
                                        //                     BoxShadow(
                                        //                       color: Colors.black12,
                                        //                       spreadRadius: 1,
                                        //                       blurRadius: 10,
                                        //                       offset: Offset(0, 4),
                                        //                     ),
                                        //                   ],
                                        //                 ),

                                        //                 child: Row(
                                        //                   children: [
                                        //                     Container(
                                        //                       width: 120,
                                        //                       height: 120,
                                        //                       decoration: BoxDecoration(
                                        //                         borderRadius: BorderRadius.circular(20),
                                        //                         image: DecorationImage(
                                        //                           image: MemoryImage(base64.decode(destinasiTemp!.destinationImage)),
                                        //                           fit: BoxFit.fill,
                                        //                         ),
                                        //                       ),
                                        //                     ),

                                        //                     const SizedBox(width: 12),
                                        //                     Column(
                                        //                       children: [
                                        //                         const SizedBox(height: 12),
                                        //                         Text(
                                        //                           destinasiTemp!.id.toString(),
                                        //                           style: const TextStyle(
                                        //                             fontWeight: FontWeight.w500,
                                        //                           ),
                                        //                         ),

                                        //                         const SizedBox(height: 6),
                                        //                         const Padding(
                                        //                           padding: EdgeInsets.only(left: 0),
                                        //                           child: Text(
                                        //                             "12 Desember 2023",
                                        //                             style: TextStyle(
                                        //                               fontWeight: FontWeight.w300,
                                        //                               fontSize: 12,
                                        //                             ),
                                        //                           ),
                                        //                         ),

                                        //                         const SizedBox(height: 26),
                                        //                         Padding(
                                        //                           padding: const EdgeInsets.only(left: 0),
                                        //                           child: Container(
                                        //                             width: 100,
                                        //                             height: 20,
                                        //                             decoration: BoxDecoration(
                                        //                               borderRadius: BorderRadius.circular(10),
                                        //                               color: Colors.grey[300],
                                        //                             ),
                                        //                             child: const Row(
                                        //                               mainAxisAlignment: MainAxisAlignment.center,
                                        //                               children: [
                                        //                                   Padding(
                                        //                                     padding: EdgeInsets.only(left: 5),
                                        //                                     child: Text(
                                        //                                       "See Ticket",
                                        //                                       style: TextStyle(
                                        //                                         fontSize: 12,
                                        //                                         fontWeight: FontWeight.w300,
                                        //                                       ),
                                        //                                     ),
                                        //                                   ),                                                       

                                        //                                 Padding(
                                        //                                   padding: EdgeInsets.only(left: 5),
                                        //                                   child: Icon(Icons.arrow_forward_ios, size: 12.0),
                                        //                                 ),

                                        //                               ],
                                        //                             ),
                                        //                           ),
                                        //                         ),

                                        //                       ],
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             );

                                        //           } else {
                                        //             return const Text('No data V2');
                                        //           }
                                        //         },
                                        //       );

                                        //     } else {
                                        //       return const Text('No data');
                                        //     }
                                        //   },
                                        // ),

                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 0, right: 0),
                                      //   child: Container(
                                      //     width: 380,
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius: BorderRadius.circular(10), // This gives the box (and its shadow) rounded corners
                                      //       boxShadow: const [
                                      //         BoxShadow(
                                      //           color: Colors.black12,
                                      //           spreadRadius: 1,
                                      //           blurRadius: 10,
                                      //           offset: Offset(0, 4),
                                      //         ),
                                      //       ],
                                      //     ),

                                      //     child: Row(
                                      //       children: [
                                      //         Container(
                                      //           width: 120,
                                      //           height: 120,
                                      //           decoration: BoxDecoration(
                                      //             borderRadius: BorderRadius.circular(20),
                                      //             image: const DecorationImage(
                                      //               image: AssetImage("resources/images/bali.jpg"),
                                      //               fit: BoxFit.fill,
                                      //             ),
                                      //           ),
                                      //         ),

                                      //         const SizedBox(width: 12),
                                      //         Column(
                                      //           children: [
                                      //             const SizedBox(height: 12),
                                      //             Text(
                                      //               ticket.ticketName,
                                      //               style: const TextStyle(
                                      //                 fontWeight: FontWeight.w500,
                                      //               ),
                                      //             ),

                                      //             const SizedBox(height: 6),
                                      //             const Padding(
                                      //               padding: EdgeInsets.only(left: 0),
                                      //               child: Text(
                                      //                 "12 Desember 2023",
                                      //                 style: TextStyle(
                                      //                   fontWeight: FontWeight.w300,
                                      //                   fontSize: 12,
                                      //                 ),
                                      //               ),
                                      //             ),

                                      //             const SizedBox(height: 26),
                                      //             Padding(
                                      //               padding: const EdgeInsets.only(left: 0),
                                      //               child: Container(
                                      //                 width: 100,
                                      //                 height: 20,
                                      //                 decoration: BoxDecoration(
                                      //                   borderRadius: BorderRadius.circular(10),
                                      //                   color: Colors.grey[300],
                                      //                 ),
                                      //                 child: const Row(
                                      //                   mainAxisAlignment: MainAxisAlignment.center,
                                      //                   children: [
                                      //                       Padding(
                                      //                         padding: EdgeInsets.only(left: 5),
                                      //                         child: Text(
                                      //                           "See Ticket",
                                      //                           style: TextStyle(
                                      //                             fontSize: 12,
                                      //                             fontWeight: FontWeight.w300,
                                      //                           ),
                                      //                         ),
                                      //                       ),                                                       

                                      //                     Padding(
                                      //                       padding: EdgeInsets.only(left: 5),
                                      //                       child: Icon(Icons.arrow_forward_ios, size: 12.0),
                                      //                     ),

                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),

                                      //           ],
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),