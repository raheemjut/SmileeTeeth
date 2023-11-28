import 'package:finalproject/Findpharmacy.dart';
import 'package:finalproject/Home.dart';
import 'package:finalproject/Prescription.dart';
import 'package:finalproject/Requestmedicine.dart';
import 'package:finalproject/Requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pharmahome extends StatefulWidget {
  const Pharmahome({Key? key}) : super(key: key);

  @override
  _PharmahomeState createState() => _PharmahomeState();
}

class _PharmahomeState extends State<Pharmahome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Select Your Order Type'),
          centerTitle:true,
           leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: Container(
          //     height: 45,
          //     width: 200,
          //     margin: const EdgeInsets.only(top: 15),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(5),
          //         border: Border.all(
          //           color: Colors.black,
          //           width: 1,
          //         )),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         prefixIcon: Icon(Icons.search, color: Colors.blue.shade900),
          //         border: InputBorder.none,
          //         fillColor: Colors.black,
          //         contentPadding: new EdgeInsets.only(top: 10),
          //         hintText: 'Search',
          //         hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Findpharmacy()),
  );
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  margin: new EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        child: Image(
                          image: AssetImage('assets/images/medicine.png'),
                        ),
                      ),
                      Text('Search & Buy Medicine',
                          textAlign: TextAlign.center,style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
               onTap: (){
               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Prescription()),
  );
            },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  margin: new EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 60,
                        child: Image(
                          image: AssetImage('assets/images/receipt.png'),
                        ),
                      ),
                      Text('Order with Prescription',
                          textAlign: TextAlign.center,style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              ),
             
            ],
          ),
    
          SizedBox(
            height: 10,
          ),
          // Container(
          //     child: Row(children: [
          //   Padding(
          //     padding: const EdgeInsets.only(left: 20),
          //     child: Text('Featured Products',
          //         style: GoogleFonts.lato(fontSize: 20)),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(left: 130),
          //     child: Text(
          //       'View All',
          //       style: GoogleFonts.lato(
          //           fontSize: 15, color: Colors.orange.shade900),
          //     ),
          //   ),
          // ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   height: 250,
          //   width: double.infinity,
          //   child:
          //       ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Container(
          //           height: 240,
          //           width: 175,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(5),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 0,
          //                   spreadRadius: 2,
          //                   offset: Offset(0, 1),
          //                 )
          //               ]),
          //           child: Column(
          //             children: [
          //               SizedBox(
          //                 height: 10,
          //               ),
          //               Container(
          //                 height: 100,
          //                 width: 130,
          //                 child: Image(
          //                     image: AssetImage('assets/images/panadol.png'),
          //                     fit: BoxFit.cover),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(right: 15, top: 10),
          //                 child: Text(
          //                   'Panadol Extra 500mg',
          //                   textAlign: TextAlign.center,
          //                   style: GoogleFonts.lato(
          //                       fontWeight: FontWeight.bold, fontSize: 15),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(right: 15, top: 7),
          //                 child: Text(
          //                   'Paracetamol with Caffeine',
          //                   style: GoogleFonts.lato(fontSize: 12),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 30, left: 10),
          //                 child: Row(children: [
          //                   Container(
          //                       child: Column(
          //                     children: [
          //                       Text(
          //                         'Rs. 100',
          //                         style: GoogleFonts.lora(
          //                             decoration: TextDecoration.lineThrough,
          //                             fontSize: 17,
          //                             color: Colors.red),
          //                       ),
          //                       Text('Rs. 90',
          //                           style: GoogleFonts.lora(
          //                               color: Colors.red, fontSize: 17)),
          //                     ],
          //                   )),
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 20),
          //                     child: Text(
          //                       'Add to Cart',
          //                       style: GoogleFonts.lora(
          //                           fontSize: 15, color: Colors.red),
          //                     ),
          //                   ),
          //                 ]),
          //               )
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
                 
          //         Container(
          //           height: 240,
          //           width: 175,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(5),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 0,
          //                   spreadRadius: 2,
          //                   offset: Offset(0, 1),
          //                 )
          //               ]),
          //           child: Column(children: [
          //             Container(
          //               height: 100,
          //               width: 130,
          //               child: Image(
          //                   image: AssetImage('assets/images/disprin.png'),
          //                   fit: BoxFit.cover),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(right: 60, top: 10),
          //               child: Text(
          //                 'Disprin Tablet',
          //                 textAlign: TextAlign.center,
          //                 style: GoogleFonts.lato(
          //                     fontWeight: FontWeight.bold, fontSize: 15),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(right: 50, top: 7),
          //               child: Text(
          //                 'SOLUBLE ASPIRIN',
          //                 style: GoogleFonts.lato(fontSize: 12),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 30, left: 10),
          //               child: Row(children: [
          //                 Container(
          //                     child: Column(
          //                   children: [
          //                     Text(
          //                       'Rs. 100',
          //                       style: GoogleFonts.lora(
          //                           decoration: TextDecoration.lineThrough,
          //                           fontSize: 17,
          //                           color: Colors.red),
          //                     ),
          //                     Text('Rs. 95',
          //                         style: GoogleFonts.lora(
          //                             color: Colors.red, fontSize: 17)),
          //                   ],
          //                 )),
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 20),
          //                   child: Text(
          //                     'Add to Cart',
          //                     style: GoogleFonts.lora(
          //                         fontSize: 15, color: Colors.red),
          //                   ),
          //                 ),
          //               ]),
          //             )
          //           ]),
          //         ),
          //       ],
          //     ),
          //   ]),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     child: Row(children: [
          //   Padding(
          //     padding: const EdgeInsets.only(left: 20),
          //     child: Text('Recently Added Products',
          //         style: GoogleFonts.lato(fontSize: 20)),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(left: 70),
          //     child: Text(
          //       'View All',
          //       style: GoogleFonts.lato(
          //           fontSize: 15, color: Colors.orange.shade900),
          //     ),
          //   ),
          // ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   height: 250,
          //   width: double.infinity,
          //   child:
          //       ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Container(
          //           height: 240,
          //           width: 175,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(5),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 0,
          //                   spreadRadius: 2,
          //                   offset: Offset(0, 1),
          //                 )
          //               ]),
          //           child: Column(
          //             children: [
          //               SizedBox(
          //                 height: 10,
          //               ),
          //               Container(
          //                 height: 100,
          //                 width: 130,
          //                 child: Image(
          //                     image: AssetImage('assets/images/panadol.png'),
          //                     fit: BoxFit.cover),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(right: 15, top: 10),
          //                 child: Text(
          //                   'Panadol Extra 500mg',
          //                   textAlign: TextAlign.center,
          //                   style: GoogleFonts.lato(
          //                       fontWeight: FontWeight.bold, fontSize: 15),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(right: 15, top: 7),
          //                 child: Text(
          //                   'Paracetamol with Caffeine',
          //                   style: GoogleFonts.lato(fontSize: 12),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 30, left: 10),
          //                 child: Row(children: [
          //                   Container(
          //                       child: Column(
          //                     children: [
          //                       Text(
          //                         'Rs. 100',
          //                         style: GoogleFonts.lora(
          //                             decoration: TextDecoration.lineThrough,
          //                             fontSize: 17,
          //                             color: Colors.red),
          //                       ),
          //                       Text('Rs. 90',
          //                           style: GoogleFonts.lora(
          //                               color: Colors.red, fontSize: 17)),
          //                     ],
          //                   )),
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 20),
          //                     child: Text(
          //                       'Add to Cart',
          //                       style: GoogleFonts.lora(
          //                           fontSize: 15, color: Colors.red),
          //                     ),
          //                   ),
          //                 ]),
          //               )
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Container(
          //           height: 240,
          //           width: 175,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(5),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 0,
          //                   spreadRadius: 2,
          //                   offset: Offset(0, 1),
          //                 )
          //               ]),
          //           child: Column(children: [
          //             Container(
          //               height: 100,
          //               width: 130,
          //               child: Image(
          //                   image: AssetImage('assets/images/flagyl.png'),
          //                   fit: BoxFit.cover),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(right: 60, top: 10),
          //               child: Text(
          //                 'Flagyl 500mg',
          //                 textAlign: TextAlign.center,
          //                 style: GoogleFonts.lato(
          //                     fontWeight: FontWeight.bold, fontSize: 15),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left: 10, top: 7),
          //               child: Text(
          //                 'Metronidazole Pharmaceutical drug Dose',
          //                 style: GoogleFonts.lato(fontSize: 12),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 30, left: 10),
          //               child: Row(children: [
          //                 Container(
          //                     child: Column(
          //                   children: [
          //                     Text(
          //                       'Rs. 120',
          //                       style: GoogleFonts.lora(
          //                           decoration: TextDecoration.lineThrough,
          //                           fontSize: 17,
          //                           color: Colors.red),
          //                     ),
          //                     Text('Rs. 100',
          //                         style: GoogleFonts.lora(
          //                             color: Colors.red, fontSize: 17)),
          //                   ],
          //                 )),
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 20),
          //                   child: Text(
          //                     'Add to Cart',
          //                     style: GoogleFonts.lora(
          //                         fontSize: 15, color: Colors.red),
          //                   ),
          //                 ),
          //               ]),
          //             )
          //           ]),
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Container(
          //           height: 240,
          //           width: 175,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(5),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 0,
          //                   spreadRadius: 2,
          //                   offset: Offset(0, 1),
          //                 )
          //               ]),
          //           child: Column(children: [
          //             Container(
          //               height: 100,
          //               width: 130,
          //               child: Image(
          //                   image: AssetImage('assets/images/disprin.png'),
          //                   fit: BoxFit.cover),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(right: 60, top: 10),
          //               child: Text(
          //                 'Disprin Tablet',
          //                 textAlign: TextAlign.center,
          //                 style: GoogleFonts.lato(
          //                     fontWeight: FontWeight.bold, fontSize: 15),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(right: 50, top: 7),
          //               child: Text(
          //                 'SOLUBLE ASPIRIN',
          //                 style: GoogleFonts.lato(fontSize: 12),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 30, left: 10),
          //               child: Row(children: [
          //                 Container(
          //                     child: Column(
          //                   children: [
          //                     Text(
          //                       'Rs. 100',
          //                       style: GoogleFonts.lora(
          //                           decoration: TextDecoration.lineThrough,
          //                           fontSize: 17,
          //                           color: Colors.red),
          //                     ),
          //                     Text('Rs. 95',
          //                         style: GoogleFonts.lora(
          //                             color: Colors.red, fontSize: 17)),
          //                   ],
          //                 )),
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 20),
          //                   child: Text(
          //                     'Add to Cart',
          //                     style: GoogleFonts.lora(
          //                         fontSize: 15, color: Colors.red),
          //                   ),
          //                 ),
          //               ]),
          //             )
          //           ]),
          //         ),
          //       ],
          //     ),
          //   ]),
          // ),
        
        
        
        ],
      ),
    );
  }
}
