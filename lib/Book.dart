// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'Config.dart';

class Book extends StatefulWidget { 
  final String doctorid, userid;
  const Book({Key key, this.doctorid, this.userid}) : super(key: key);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  final eventdatecontroller = new TextEditingController();
  final timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2200));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        eventdatecontroller.text = ("${selectedDate.toLocal()}".split(' ')[0]);
      });
  }
  void showMessage(String message, Color bgclrvalue, Color txtclrvalue) {
    Toast.show(
      message,
      context,
      backgroundRadius: 0,
      backgroundColor: bgclrvalue,
      textColor: txtclrvalue,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.TOP,
    );
  }
Future<List> bookappointment() async {
    final response = await http.post(ApiUrls.bookappointment, body: {
      "aptdate": eventdatecontroller.text,
      "apttime": timeController.text,
      "useremail": widget.userid,
      "doctorid": widget.doctorid,
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
     if (arr[0] == "pass") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("Appointment Booked", Colors.green, Colors.white);
          Navigator.pop(context);

          
        });
      }
    }  
    else  if (arr[0] == "exists") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("Appointment Already Booked", Colors.green, Colors.white);
          Navigator.pop(context);

          
        });
      }
    }  else {
      setState(() {
        showMessage("Failed to connect", Colors.red, Colors.white);
      });
    }
    return message;
  }
  
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
        title: Text('Select Booking Time & Date'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
           Container(
                height: 180,
                width: 180,
                child: Image(
                  image: AssetImage('assets/images/logo2.png'),
                  fit: BoxFit.contain,
                ),
              ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: eventdatecontroller,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                  setState(() {
                    eventdatecontroller.text =
                        ("${selectedDate.toLocal()}".split(' ')[0]);
                  });
                },
                cursorColor: Colors.lightGreen,
                decoration: InputDecoration(
                    labelText: 'Appointment Date',
                    labelStyle: GoogleFonts.ubuntu(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                 ),
              child: Center(
                  child: TextField(
                      readOnly: true,
                      controller: timeController,
                      decoration: InputDecoration(
                    labelText: 'Appointment Time',
                    labelStyle: GoogleFonts.ubuntu(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    )),
                      onTap: () async {
                        var time = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                          

                        );
                        timeController.text = time.format(context);
                      })),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: (){
                    if(timeController.text == "")
                    {
                        showMessage("Please Select Appointment Time", Colors.red, Colors.white);
                    }
                    else if (eventdatecontroller.text == "")
                    {
                        showMessage("Please Select Appointment Date", Colors.red, Colors.white);
                    }
                    else
                    {
                      bookappointment();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: new EdgeInsets.only(top:10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Send Request',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600,color: Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
