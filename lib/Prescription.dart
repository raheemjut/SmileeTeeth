import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prescription extends StatefulWidget {
  const Prescription({Key? key}) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: Text('Dashboard'),

        
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child:Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: Stack(children: [
        ListView(
          children: [
            
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.white,
              
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    Container(
                      height: 100,
                      width: 100,
                      child: Column(children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image(
                              image: AssetImage('assets/images/camera.png')),
                        ),
                        Text(
                          'CAMERA',
                          style: GoogleFonts.lato(),
                        ),
                      ]),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Column(children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image(
                              image: AssetImage('assets/images/gallery.png')),
                        ),
                        Text(
                          'GALLERY',
                          style: GoogleFonts.lato(),
                        ),
                      ]),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Column(children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image(
                              image: AssetImage('assets/images/record.png')),
                        ),
                        Text(
                          'HEALTH RECORDS',
                          style: GoogleFonts.lato(),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ),
                  ]),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/images/shield.png'),
                    ),
                  ),
                  Text(
                      'You attached prescription will be scure and private. \n Only our pharmaciest will review it',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(
                height: 500,
                width: double.infinity,
                margin: new EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text('Valid Prescription Guide',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: Image(
                          image: AssetImage('assets/images/prescription.jpeg')),
                    )
                  ],
                ))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 7,left: 110),
              child:  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('Countinue',
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ),
            ),
          ],
        )
      ]),
    );
  }
}
