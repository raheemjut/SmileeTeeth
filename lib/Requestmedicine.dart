// @dart=2.9

import 'dart:convert';
import 'dart:io';

import 'package:finalproject/Findpharmacy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'Config.dart';
class Requestmedicine extends StatefulWidget {
  final String pharmacyid, userid;
  const Requestmedicine({Key key, this.pharmacyid, this.userid}) : super(key: key);

  @override
  _RequestmedicineState createState() => _RequestmedicineState();
}

class _RequestmedicineState extends State<Requestmedicine> {
  final nameController = new TextEditingController();
  final phoneController = new TextEditingController();
  final addressController = new TextEditingController();
  final cnicController = new TextEditingController();
  final emailController = new TextEditingController();
  final referalDoctorConstroller = new TextEditingController();
    File uploadimageproduct = new File("");
  Future<void> cameraImageCamera() async {
    var choosedimage = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimageproduct = choosedimage;
    });
  }

  Future<void> chooseImageGallery() async {
    try {
      var choosedimage = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      //set source: ImageSource.camera to get image from camera
      setState(() {
        uploadimageproduct = choosedimage;
      });
    } catch (e) {
      print("gallery not responding");
    }
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
  
   Future<void> sendMediceneRequest() async {
 
    try {
      List<int> imageBytesproduct = uploadimageproduct.readAsBytesSync();
      String baseimageproduct = base64Encode(imageBytesproduct);

      //convert file image to Base64 encoding

      var response = await http.post(ApiUrls.sendorder, body: {
        'image': baseimageproduct,
        "useremail": widget.userid,
      "pharmacyid": widget.pharmacyid,
      "name":nameController.text,
      "phone":phoneController.text,
      "address":addressController.text,
      "cnic":cnicController.text,
      "email":emailController.text,
      "doctor":referalDoctorConstroller.text,
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        print(jsondata);
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          print(jsondata["msg"]);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Findpharmacy()));
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("Error during converting to Base64");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
        title: Text('Order Medicine '),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.only(right: 0,top: 10, left: 20),
                child: Text('Valid Order Request Guide' ,style: GoogleFonts.lato(
                                  fontSize: 17, fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0,top: 10, left: 20),
                child: Text('Write complete name of receiver and fill all the details'),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 0,top: 10, left: 20),
              child: Text('Be assure that your medicene will be deilvered from the selected pharmacy with complete privacy'),
            ),
            SizedBox(
              height: 20,
              
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Icon(Icons.receipt_outlined),
                    ),   
                    SizedBox(
                  width: 10,
                  
                ),             
                     Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: nameController,
                                      decoration: InputDecoration(
                                    hintText: 'Receiver Name',
                                  )),
                              ),
                              
                  ],
                ),
                 Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Icon(Icons.phone),
                    ),   
                    SizedBox(
                  width: 10,
                  
                ),             
                      Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: phoneController,
                                      decoration: InputDecoration(
                                    hintText: 'Receiver Phone Number',
                                  )),
                              ),
                              
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Icon(Icons.location_on),
                    ),   
                    SizedBox(
                  width: 10,
                  
                ),             
                      Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: addressController,
                                      decoration: InputDecoration(
                                    hintText: 'Receiver Address',
                                  )),
                              ),
                              
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Icon(Icons.perm_identity),
                    ),   
                    SizedBox(
                  width: 10,
                  
                ),             
                      Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: cnicController,
                                      decoration: InputDecoration(
                                    hintText: 'Receiver CNIC Number',
                                  )),
                              ),
                              
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Icon(Icons.email),
                    ),   
                    SizedBox(
                  width: 10,
                  
                ),             
                      Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: emailController,
                                      decoration: InputDecoration(
                                    hintText: 'Receiver Email',
                                  )),
                              ),
                              
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Icon(Icons.account_box_rounded),
                    ),   
                    SizedBox(
                  width: 10,
                  
                ),             
                      Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: referalDoctorConstroller,
                                      decoration: InputDecoration(
                                    hintText: 'Referal Doctor',
                                  )),
                              ),
                              
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                  Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                    onPressed: cameraImageCamera,
                                    iconSize: 40.0,
                                    icon: new Icon(
                                      Icons.photo_camera,
                                      color: Colors.black,
                                    )),
                                IconButton(
                                    iconSize: 40.0,
                                    onPressed: chooseImageGallery,
                                    icon: new Icon(
                                      Icons.image,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
              padding: const EdgeInsets.only(top: 40),
              child: InkWell(
                onTap: (){
                  if(nameController.text == "")
                  {
                    showMessage("Please Enter Receiver Name", Colors.red, Colors.white);
                  }
                  else if(phoneController.text == "")
                  {
                    showMessage("Please Enter Receiver Phone Number", Colors.red, Colors.white);
                  }
                  else if(addressController.text == "")
                  {
                    showMessage("Please Enter Receiver Address", Colors.red, Colors.white);
                  }
                  else  if(cnicController.text == "")
                  {
                    showMessage("Please Enter Receiver CNIC", Colors.red, Colors.white);
                  }
                  else if(emailController.text == "")
                  {
                    showMessage("Please Enter Receiver Email", Colors.red, Colors.white);
                  }
                  else if(referalDoctorConstroller.text == "")
                  {
                    showMessage("Please Enter Referal Doctor", Colors.red, Colors.white);
                  }
                  else
                  {
                    sendMediceneRequest();
                  }

                },
                child: Container(
                  
                 
                    
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Request For Medicine',
                            style: GoogleFonts.lato(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                      ),
                    ),
              ),
            ),
            
              ],
            ),
          
            ],
          )
        ],
      ),
    );
  }
}