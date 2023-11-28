import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Message extends StatefulWidget {
  const Message({ Key? key }) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        backgroundColor: Colors.teal.shade400,
        leading: InkWell(
             
            onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 12),
                    child: Column(
                      children:[
                          Text('Miller',style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,left: 10),
                                  child: Text('Hi Dear',style: GoogleFonts.lato(fontSize: 15,)),
                                ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170,bottom: 25),
                    child: Text('Friday',style: GoogleFonts.lato(fontSize: 15,)),
                  ),
                ],
              ),
              Divider(
                thickness: 1,color:Colors.black,
              ),
               Row(
                
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 12),
                    child: Column(
                      children:[
                          Text('David',style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,left: 10),
                                  child: Text('Hi Dear',style: GoogleFonts.lato(fontSize: 15,)),
                                ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170,bottom: 25),
                    child: Text('Tuesday',style: GoogleFonts.lato(fontSize: 15,)),
                  ),
                ],
              ),
              Divider(
                thickness: 1,color:Colors.black,
              ),
               Row(
                
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 12),
                    child: Column(
                      children:[
                          Text('John B',style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,left: 10),
                                  child: Text('Hi Dear',style: GoogleFonts.lato(fontSize: 15,)),
                                ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 140,bottom: 25),
                    child: Text('September 10',style: GoogleFonts.lato(fontSize: 15,)),
                  ),
                ],
              ),
              Divider(
                thickness: 1,color:Colors.black,
              ),
               Row(
                
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 12),
                    child: Column(
                      children:[
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Text('Ali',style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w600)),
                          ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,left: 10),
                                  child: Text('Have you done this?',style: GoogleFonts.lato(fontSize: 15,)),
                                ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60,bottom: 25),
                    child: Text('September 01',style: GoogleFonts.lato(fontSize: 15,)),
                  ),
                ],
              ),
              Divider(
                thickness: 1,color:Colors.black,
              ),
               Row(
                
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 12),
                    child: Column(
                      children:[
                          Text('John',style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,left: 10),
                                  child: Text('Waiting',style: GoogleFonts.lato(fontSize: 15,)),
                                ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 160,bottom: 25),
                    child: Text('August 25',style: GoogleFonts.lato(fontSize: 15,)),
                  ),
                ],
              ),
              Divider(
                thickness: 1,color:Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}