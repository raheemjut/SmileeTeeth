import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}
 _launchURL() async {
  const url = 'https://goo.gl/maps/cQgXB9egboh7Zcrn6';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchURL1() async {
  const url = 'https://goo.gl/maps/cQgXB9egboh7Zcrn6';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Pharmacy Locations'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                     child:
                     
                     Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png')))),
                                         SizedBox(width: 20,),
                                         Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text("Mekki Hospital",
                            style: GoogleFonts.lato(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                      ),
                              SizedBox(
                                height: 10,
                              ),
                      SizedBox(
                        width: 250,
                        child: Text("C466+MH4, 24 a/b Block A People's Colony No 1, Faisalabad, Punjab",
                            style: GoogleFonts.lato(
                              fontSize: 14,
                            )),
                      ),
                      SizedBox(height: 20,),
                                InkWell(
                   onTap: () {_launchURL();
                              
                            },
                  child: Container(
                    height: 50,
                    width: 180,
                    margin: new EdgeInsets.only(left:35),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Open on Map',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
      
                    ],
                  ),
                ],
              ),
              Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 10,top: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            ],
          ),
             Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                     child:
                     
                     Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png')))),
                                         SizedBox(width: 20,),
                                         Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text("American Docor Hospital",
                            style: GoogleFonts.lato(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                      ),
                              SizedBox(
                                height: 10,
                              ),
                      SizedBox(
                        width: 250,
                        child: Text("C468+Q94, Kohinoor City Faisalabad, Punjab, Pakistan",
                            style: GoogleFonts.lato(
                              fontSize: 14,
                            )),
                      ),
                      SizedBox(height: 20,),
                                InkWell(
                   onTap: () {
                             _launchURL1();
                              
                            },
                  child: Container(
                    height: 50,
                    width: 180,
                    margin: new EdgeInsets.only(left:35),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Open on Map',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
      
                    ],
                  ),
                ],
              ),
              Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 10,top: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            ],
          ),
        ],
      ),
    );
  }
}
